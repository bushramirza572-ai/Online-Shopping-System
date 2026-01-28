<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="../footer.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>
<body>
<div style="color: white; text-align: center; font-size: 30px;">Home <i class="fa fa-institution"></i></div>

<form method="get" action="home.jsp" style="text-align: center; margin: 20px;">
    <input type="text" name="search" placeholder="Search by name or category"
           value="<%= (request.getParameter("search") != null) ? request.getParameter("search") : "" %>">
    <button type="submit" name="btnSearch"><i class="fas fa-search"></i> Search</button>
</form>
<table>
        <thead>
          <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> Price</th>
            <th scope="col">Add to cart <i class='fas fa-cart-plus'></i></th>
          </tr>
        </thead>
        <tbody>
<%
int z = 0;
try {
    String search = request.getParameter("search");
    String query;
    Connection con = ConnectionProvider.getcon();
    Statement st = con.createStatement();

    if (search != null && !search.trim().isEmpty()) {
        query = "SELECT * FROM product WHERE (name LIKE '%" + search + "%' OR category LIKE '%" + search + "%') AND active='Yes'";
    } else {
        query = "SELECT * FROM product WHERE active='Yes'";
    }

    ResultSet rs = st.executeQuery(query);

    while(rs.next()) {
        z = 1;
%>
        <tr>
            <td><%=rs.getString(1) %></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><i class="fa fa-inr"></i> <%=rs.getString(4) %></td>
            <td><a href="addToCartAction.jsp?id=<%=rs.getString(1) %>">Add to cart <i class='fas fa-cart-plus'></i></a></td>
        </tr>
<%
    }
} catch(Exception e) {
    System.out.println(e);
}
%>

        </tbody>
      </table>
      	<%if(z==0){ %>
	<h1 style="color:white; text-align: center;">Nothing to show</h1>
	<%} %>
      <br>
      <br>
      <br>
      <div class="footer">
          <p>All right reserved</p>
      </div>

</body>
</html>