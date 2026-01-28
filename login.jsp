<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>Login</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
      <form action="loginaction.jsp" method="post">
      <input type="email" name="email" placeholder="Enter Email" required>
      <input type="password" name="password" placeholder="Enter Password" required>
      <input type="submit" value="Login">
      </form>
      <h2><a href="signup.jsp">SignUp</a></h2>
       <h2><a href="forgotPassword.jsp">Forgot Password?</a></h2>
  </div>
  <div class='whysignLogin'>
  <%
  String msg=request.getParameter("msg");
  if("notexist".equals(msg))
  {
  %>
  <h1>Incorrect Username or Password</h1>
<%} %>
<%if("invalid".equals(msg))
{%>
<h1>Some thing Went Wrong! Try Again !</h1>
<%} %>
    <h2>Timeverse</h2>
    <p><strong>TimeVerse</strong> is a premium online watch-selling platform that redefines the way you experience time. It offers a curated collection of luxury and designer watches, allowing customers to explore, compare, and purchase timeless pieces from the worlds finest brands all from the comfort of their homes.</p>
   
  </div>
</div>

</body>
</html>