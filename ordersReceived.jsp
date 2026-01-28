<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../css/ordersReceived-style.css">
<title>Home</title>
<style>
.th-style
{ width: 25%;}
</style>
</head>
<body>
<div style="color: black; text-align: center; font-size: 30px;">Orders Received <i class="fa fa-shopping-cart"></i></div>
<%
String msg=request.getParameter("msg");
if("cancel".equals(msg))
{
%>
<h3 class="alert">Order Cancel Successfully!</h3>
<%} %>
<%
if("delivered".equals(msg))
{
%>
<h3 class="alert">Successfully Updated!</h3>
<%} %>
<%
if("invalid".equals(msg))
{
%>
<h3 class="alert">Some thing went wrong! Try Again!</h3>
<%} %>

<table id="customers">
          <tr>
          <th>Mobile Number</th>
            <th scope="col">Product Name</th>
            <th scope="col">Quantity</th>
            <th scope="col"><i class="fa fa-inr"></i> Sub Total</th>
            <th>Address</th>
            <th>City</th>
            <th>State</th>
            <th>Country</th>
            <th scope="col">Order Date</th>
             <th scope="col">Expected Delivery Date</th>
             <th scope="col">Payment Method</th>
              <th scope="col">T-ID</th>
              <th scope="col">Status</th>
              <th scope="col">Cancel order <i class='fas fa-window-close'></i></th>
              <th scope="col">Order Delivered <i class='fas fa-dolly'></i></i></th>
          </tr>
        
<%
int sno=0;
try
{
	Connection con=ConnectionProvider.getcon();
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from cart inner join product on cart.product_id = product.id where cart.orderDate is not null and cart.status = 'prosessing'");
	while(rs.next())
	{
		
%>
          <tr>
          
            <td><%= rs.getString("mobileNumber") %></td>
        <td><%= rs.getString("product_name") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><i class="fa fa-inr"></i> <%= rs.getDouble("total") %></td>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("city") %></td>
        <td><%= rs.getString("state") %></td>
        <td><%= rs.getString("country") %></td>
        <td><%= rs.getString("orderDate") %></td>
        <td><%= rs.getString("deliveryDate") %></td>
        <td><%= rs.getString("paymentMethod") %></td>
        <td><%= rs.getString("transactionId") %></td>
        <td><%= rs.getString("status") %></td>
        <td><a href="cancelOrdersAction.jsp?id=<%= rs.getInt("id") %>&email=<%=rs.getString("email")%>">Cancel <i class="fa fa-ban"></i></a></td>
        <td><a href="deliveredOrdersAction.jsp?id=<%= rs.getInt("id") %>&email=<%=rs.getString("email")%>">Delivered <i class="fa fa-check-circle"></i></a></td>
            </tr>
 <%
	}
}
catch(Exception e)
{
	System.out.println(e);
}
 %>
        </table>
      <br>
      <br>
      <br>

</body>
</html>