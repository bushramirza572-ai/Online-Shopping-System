<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>Signup</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
    <form action="signupaction.jsp" method="post">
    <input type="text" name="name" placeholder="Enter Name" required>
    <input type="email" name="email" placeholder="Enter Email" required>
    <input type="number" name="mobileNumber" placeholder="Enter Mobile Number" required>
    <input type="password" name="password" placeholder="Enter password" required>
     <input type="submit" value="signup">
    </form>
     <h1> <a href="login.jsp">Login</a></h1>
  </div>
  <div class='whysign'>
<%
String msg=request.getParameter("msg");
if("valid".equals(msg))
{
%>
<h1>Successfully Registered!</h1>
<%} %>
<%
if("invalid".equals(msg))
{
%>
<h1>Some thing Went Wrong! Try Again !</h1>
<%} %>
    <h2>Timeverse</h2>
    <p><strong>TimeVerse</strong> is a premium online watch-selling platform that redefines the way you experience time. It offers a curated collection of luxury and designer watches, allowing customers to explore, compare, and purchase timeless pieces from the world’s finest brands all from the comfort of their homes.</p>
  </div>
</div>

</body>
</html>