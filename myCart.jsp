<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Cart</title>
<style>
h3
{
	color: yellow;
	text-align: center;
}
</style>
</head>
<body>
<div style="color: black; text-align: center; font-size: 30px;">My Cart <i class='fas fa-cart-arrow-down'></i></div>
<%
String msg = request.getParameter("msg");
if ("notPossible".equals(msg)) {
%>
    <h3 class="alert">There is only one Quantity! So click on remove!</h3>
<%
}
if ("inc".equals(msg)) {
%>
    <h3 class="alert">Quantity Increased Successfully!</h3>
<%
}
if ("dec".equals(msg)) {
%>
    <h3 class="alert">Quantity Decreased Successfully!</h3>
<%
}
if ("removed".equals(msg)) {
%>
    <h3 class="alert">Product Successfully Removed!</h3>
<%
}
%>
<table>
<thead>
<%
int total = 0;
int sno = 0;
String emailid = (String)session.getAttribute("email");

try {
    Connection con = ConnectionProvider.getcon();
    Statement st = con.createStatement();
    ResultSet rs1 = st.executeQuery("select sum(total) from cart where email='"+emailid+"' and address is NULL");
    if(rs1.next()) {
        total = rs1.getInt(1);
    }
%>
    <tr>
        <th scope="col" style="background-color: yellow;">Total: <%=total %> <i class="fa fa-inr"></i> </th>
        <%
          if(total>0)
          {       
        %>
        <th scope="col"><a href="addressPaymentForOrder.jsp">Proceed to order</a></th>
        <%} %>
    </tr>
    <thead>
    <tr>
        <th scope="col">S.No</th>
        <th scope="col">Product Name</th>
        <th scope="col">Category</th>
        <th scope="col"><i class="fa fa-inr"></i> Price</th>
        <th scope="col">Quantity</th>
        <th scope="col">Sub Total</th>
        <th scope="col">Remove <i class='fas fa-trash-alt'></i></th>
    </tr>
</thead>
<tbody>

    
<%
        ResultSet rs2 = st.executeQuery("select * from product inner join cart on product.id = cart.product_id and cart.email='" +emailid+ "' and cart.address is NULL" );
    while(rs2.next()) 
    {
%>
       <tr>
       <%=sno=sno+1 %>
        <td><%= ++sno %></td>
        <td><%=rs2.getString("product_name") %></td>
        <td><%=rs2.getString("category") %></td>
        <td><i class="fa fa-inr"></i> <%=rs2.getString("price") %></td>
        <td>
            <a href="incDecQuantityAction.jsp?id=<%=rs2.getInt("id")%>&quantity=inc"><i class='fas fa-plus-circle'></i></a>
            <%=rs2.getString("quantity") %>
            <a href="incDecQuantityAction.jsp?id=<%=rs2.getInt("id")%>&quantity=dec"><i class='fas fa-minus-circle'></i></a>
        </td>
        <td><i class="fa fa-inr"></i> <%=rs2.getString("total") %></td>
        <td><a href="removeFromCart.jsp?id=<%=rs2.getInt("id")%>">Remove <i class='fas fa-trash-alt'></i></a></td>
    </tr>
<%
    }
} catch(Exception e) {
    out.println(e);
}
%>
        </tbody>
      </table>
      <br>
      <br>
      <br>

</body>
</html>