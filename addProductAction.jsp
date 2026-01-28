<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %> 
<%
String name = request.getParameter("productname");
String category = request.getParameter("category");
Double price = Double.parseDouble(request.getParameter("price"));
String active = request.getParameter("active");
String image = request.getParameter("bimg");

try (Connection con = ConnectionProvider.getcon()) {
    PreparedStatement ps = con.prepareStatement("INSERT INTO product(product_name, category, price, active, photoname) VALUES (?, ?, ?, ?,?)");
    ps.setString(1, name);
    ps.setString(2, category);
    ps.setDouble(3, price);
    ps.setString(4, active);
    ps.setString(5, image);

    int result = ps.executeUpdate();
    if (result > 0) {
        response.sendRedirect("addNewProduct.jsp?msg=done");
    } else {
        response.sendRedirect("addNewProduct.jsp?msg=wrong");
    }
} catch(Exception e) {
    e.printStackTrace();
    response.sendRedirect("addNewProduct.jsp?msg=wrong");
}
%>

