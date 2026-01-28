<%@page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%
    Object emailObj = session.getAttribute("email");
    if(emailObj == null) {
        response.sendRedirect("login.jsp?msg=not_logged_in");
        return;
    }
    String email = emailObj.toString();

    String product_id = request.getParameter("id");
    if(product_id == null || product_id.isEmpty()) {
        response.sendRedirect("home.jsp?msg=invalid_product");
        return;
    }

    int quantity = 1;
    int product_price = 0;
    int total = 0;
    boolean exists = false;

    try (Connection con = ConnectionProvider.getcon()) {

       
        try (PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE id=?")) {
            ps.setString(1, product_id);
            try (ResultSet rs = ps.executeQuery()) {
                if(rs.next()) {
                    product_price = rs.getInt("price");
                    total = product_price;
                } else {
                    out.println("Product not found in database.");
                    return;
                }
            }
        }

       
        try (PreparedStatement ps = con.prepareStatement(
                "SELECT quantity FROM cart WHERE product_id=? AND email=? AND address IS NULL")) {
            ps.setString(1, product_id);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if(rs.next()) {
                    exists = true;
                    quantity = rs.getInt("quantity") + 1;
                    total = quantity * product_price;
                }
            }
        }

      
        if(exists) {
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE cart SET quantity=?, total=? WHERE product_id=? AND email=? AND address IS NULL")) {
                ps.setInt(1, quantity);
                ps.setInt(2, total);
                ps.setString(3, product_id);
                ps.setString(4, email);
                ps.executeUpdate();
            }
            response.sendRedirect("home.jsp?msg=exist&qty=" + quantity);
        } else {
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO cart(email, product_id, quantity, price, total) VALUES (?, ?, ?, ?, ?)")) {
                ps.setString(1, email);
                ps.setString(2, product_id);
                ps.setInt(3, quantity);
                ps.setInt(4, product_price);
                ps.setInt(5, total);
                ps.executeUpdate();
            }
            response.sendRedirect("home.jsp?msg=added&qty=" + quantity);
        }

    } catch(Exception e) {
        out.println("<h2>Error adding product to cart:</h2>");
        e.printStackTrace(new java.io.PrintWriter(out)); 
    }
%>
