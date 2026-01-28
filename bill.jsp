+<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@include file="footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="css/bill.css">
<title>Bill</title>
</head>
<body>
<%
String email = session.getAttribute("email").toString();
try
{
    int total = 0;
    int sno = 0;
    Connection con = ConnectionProvider.getcon();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select sum(total) from cart where email='" + email + "' and status='prosessing'");
    while(rs.next())
    {
        total = rs.getInt(1);
    }
    ResultSet rs2 = st.executeQuery("select * from users inner join cart on users.email=cart.email where cart.email='" + email + "' and cart.status='prosessing'");
    if(rs2.next())
    { 
%>
<h3>Online shopping Bill</h3>
<hr>
<div class="left-div"><h3>Name: <%= rs2.getString("name") %> </h3></div>
<div class="right-div-right"><h3>Email: <%= email %>  </h3></div>
<div class="right-div"><h3>Mobile Number: <%= rs2.getString("mobileNumber") %> </h3></div>  

<div class="left-div"><h3>Order Date: <%= rs2.getString("orderDate") %>  </h3></div>
<div class="right-div-right"><h3>Payment Method: <%= rs2.getString("paymentMethod") %> </h3></div>
<div class="right-div"><h3>Expected Delivery: <%= rs2.getString("deliveryDate") %> </h3></div> 

<div class="left-div"><h3>Transaction Id: <%= rs2.getString("transactionId") %></h3></div>
<div class="right-div-right"><h3>City: <%= rs2.getString("city") %> </h3></div> 
<div class="right-div"><h3>Address: <%= rs2.getString("address") %>  </h3></div> 

<div class="left-div"><h3>State: <%= rs2.getString("state") %></h3></div>
<div class="right-div-right"><h3>Country: <%= rs2.getString("country") %> </h3></div>  
<hr>
	
	
	
<table id="customers">
<h3>Product Details</h3>
<tr>
    <th>S.No</th>
    <th>Product Name</th>
    <th>Category</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Sub Total</th>
</tr>
<%
ResultSet rs1 = st.executeQuery(
	    "SELECT cart.*, product.product_name AS productname, product.category, product.price " +
	    "FROM cart INNER JOIN product ON cart.product_id = product.id " +
	    "WHERE cart.email='" + email + "' AND cart.status='bill'"
	);


int calculatedTotal = 0; // New total calculated from products
while(rs1.next()) {
    sno++;
    int subTotal = rs1.getInt("total");
    calculatedTotal += subTotal;
%>
<tr>
    <td><%= sno %></td>
    <td><%= rs1.getString("productname") %></td>
    <td><%= rs1.getString("category") %></td>
    <td><i class="fa fa-inr"></i> <%= rs1.getInt("price") %></td>
    <td><%= rs1.getInt("quantity") %></td>
    <td><i class="fa fa-inr"></i> <%= subTotal %></td>
</tr>
<%
} // end while
%>
</table>

<h3>Total: <i class="fa fa-inr"></i> <%= calculatedTotal %> </h3>
<a href="continueShopping.jsp"><button class="button left-button">Continue Shopping</button></a>
<a onclick="window.print();"><button class="button right-button">Print</button></a>

<br><br><br><br>
<%
    } 
  }
  catch(Exception e)
  {
      System.out.println(e);
  }
%>
</body>
</html>