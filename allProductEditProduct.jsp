<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/addNewProduct-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>All Products</title>
    <link rel="stylesheet" href="../css/admin-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
   <h1 style="text-align: center; font-size: 30px;">All Products <i class="fa fa-list"></i></h1>
    <table border="1">
        <thead>
            <tr>
                <th>Product ID</th>
                
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    con = ConnectionProvider.getcon();
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM product"); 
                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("id") %></td>
                
                <td><%= rs.getString("product_name") %></td>
                <td><%= rs.getString("category") %></td>
                <td><i class="fa fa-inr"></i> <%= rs.getString("price") %></td>
                <td><%= rs.getString("active") %></td>
                <td>
                    <a href="editProduct.jsp?id=<%= rs.getString("id") %>">Edit <i class="fas fa-pen-fancy"></i></a>
                </td>
            </tr>
            <%
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if(rs != null) rs.close();
                    if(st != null) st.close();
                    if(con != null) con.close();
                }
            %>
        </tbody>
    </table>
</body>
</html>
