<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/addressPaymentForOrder-style.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<title>Home</title>

<script>
if(window.history.forward(1) != null)
	window.history.forward(1); 
</script>
</head>
<body>
<br>
<table>
<thead>
<%
String email = (String) session.getAttribute("email");

if(email != null && !email.trim().equals("")) { 
    int total = 0;
    int sno = 0;
    try {
        Connection con = ConnectionProvider.getcon();
        Statement st = con.createStatement();
        
        
        ResultSet rsTotal = st.executeQuery("select sum(total) from cart where email='"+email+"' and address is NULL");
        if(rsTotal.next()) {
            total = rsTotal.getInt(1);
        }
%>
<tr>
<th scope="col">
    <a href="myCart.jsp"><i class="fas fa-arrow-circle-left"></i> Back</a>
</th>
<th scope="col" style="background-color: yellow;">Total: <i class="fa fa-inr"></i><%= total %></th>
</tr>
</thead>
<thead>
<tr>
    <th scope="col">S.No</th>
    <th scope="col">Product Name</th>
    <th scope="col">Category</th>
    <th scope="col"><i class="fa fa-inr"></i> Price</th>
    <th scope="col">Quantity</th>
    <th scope="col">Sub Total</th>
</tr>
</thead>
<tbody>
<%
        // Get cart products
        ResultSet rsCart = st.executeQuery("select * from product inner join cart on product.id = cart.product_id and cart.email='" +email+ "' and cart.address is NULL");
        while(rsCart.next()) {
            sno++;
%>
<tr>
    <td><%= sno %></td>
    <td><%= rsCart.getString("product_name") %></td>
    <td><%= rsCart.getString("category") %></td>
    <td><i class="fa fa-inr"></i> <%= rsCart.getString("price") %></td>
    <td><%= rsCart.getString("quantity") %></td>
    <td><i class="fa fa-inr"></i> <%= rsCart.getString("total") %></td>
</tr>
<%
        }

     
        Statement stUser = con.createStatement();
        ResultSet rsUser = stUser.executeQuery("select * from users where email='"+email+"'");
        if(rsUser.next()) {
%>
</tbody>
</table>

<hr style="width: 100%">
<form action="addressPaymentForOderAction.jsp" method="post">
<div class="left-div">
<h3>Enter Address</h3>
<input class="input-style" type="text" name="address" value="<%= rsUser.getString("address") %>" placeholder="Enter Address" required>
</div>

<div class="right-div">
<h3>Enter City</h3>
<input class="input-style" type="text" name="city" value="<%= rsUser.getString("city") %>" placeholder="Enter City" required>
</div> 

<div class="left-div">
<h3>Enter State</h3>
<input class="input-style" type="text" name="state" value="<%= rsUser.getString("state") %>" placeholder="Enter State" required>
</div>

<div class="right-div">
<h3>Enter Country</h3>
<input class="input-style" type="text" name="country" value="<%= rsUser.getString("country") %>" placeholder="Enter Country" required>
</div>

<h3 style="color: red">*If there is no address, it means you did not set your address!</h3>
<h3 style="color: red">*This address will also be updated to your profile</h3>
<hr style="width: 100%">

<div class="left-div">
<h3>Select way of Payment</h3>
<select class="input-style" name="paymentMethod">
<option value="Cash on delivery(COD)">Cash on delivery (COD)</option>
<option value="Online Payment">Online Payment</option>
</select>
</div>

<div class="right-div">
<h3>Pay online on admin@pay.com</h3>
<input class="input-style" type="text" name="transactionId" placeholder="Enter Transaction ID">
<h3 style="color: red">*If you select online Payment, then enter your transaction ID here otherwise leave this blank</h3>
</div>

<hr style="width: 100%">
<div class="left-div">
<h3>Mobile Number</h3>
<input class="input-style" type="text" name="mobileNumber" value="<%= rsUser.getString("mobileNumber") %>" placeholder="Enter Mobile Number" required>
<h3 style="color: red">*This mobile number will also be updated to your profile</h3>
</div>

<div class="right-div">
<h3 style="color: red">*If you enter wrong transaction ID, then your order can be canceled!</h3>
<button class="button" type="submit">Proceed to Generate Bill & Save<i class='far fa-arrow-alt-circle-right'></i></button>
<h3 style="color: red">*Fill form correctly</h3>
</div>
</form>
<%
        }
        st.close();
        stUser.close();
        con.close();
    } catch(Exception e) {
        e.printStackTrace(); 
    }
} else {
    response.sendRedirect("login.jsp");
}
%>
<br><br><br>
<%@ include file="footer.jsp" %>
</body>
</html>
