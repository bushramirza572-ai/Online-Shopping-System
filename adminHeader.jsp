<%@page errorPage="../error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/home-style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<style>
h2 {
	color:white;
	}
</style>
</head>
    
    <br>
    <div class="topnav sticky">
  <%
String email = (String) session.getAttribute("email");

if (email == null) {
%>
    <h2>You are not logged in!</h2>
    <a href="../login.jsp">Go to Login</a>
<%
    return;
}
%>
           <div class="navbar-brand">
            <center><h2>Online shopping</h2></center>
            <a href="addNewProduct.jsp"><i class="fa fa-plus-circle"></i> Add New Product</a>
            <a href="allProductEditProduct.jsp"><i class="fa fa-list"></i> All Products & Edit Products</a>
            <a href="messagesReceived.jsp"><i class="fa fa-envelope"></i> Messages Received</a>
            <a href="ordersReceived.jsp"><i class="fa fa-shopping-cart"></i> Orders Received</a>
            <a href="cancelOrders.jsp"><i class="fa fa-ban"></i> Cancel Orders</a>
            <a href="deliveredOrders.jsp"><i class="fa fa-check-circle"></i> Delivered Orders</a>
            <a href="../logout.jsp"><i class="fa fa-sign-out"></i> Logout</a>
          </div>
          </div>
           <br>
          