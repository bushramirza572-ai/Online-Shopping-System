<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/signup-style.css">
<title>ForgotPassword</title>
</head>
<body>
<div id='container'>
  <div class='signup'>
     <form action="forgotPasswordAction.jsp" method="post">
       <input type="email" name="email" placeholder="Enter Email" required>
       <input type="number" name="mobileNumber" placeholder="Enter Mobile Number" required>
       <input type="password" name="newPassword" placeholder="Enter your new password to set" required>
       <input type="submit" value="Save">
     </form>
     <h2><a href="login.jsp">Login</a></h2>
  </div>
  <div class='whyforgotPassword'>
    <%
      String msg = request.getParameter("msg");
      if ("done".equals(msg)) {
    %>
        <h1>Password Changed Successfully!</h1>
    <%
      } else if ("invalid".equals(msg)) {
    %>
        <h1>Something Went Wrong! Try Again!</h1>
    <%
      }
    %>
     <h2>Timeverse</h2>
    <p><strong>TimeVerse</strong> is a premium online watch-selling platform that redefines the way you experience time. It offers a curated collection of luxury and designer watches, allowing customers to explore, compare, and purchase timeless pieces from the worlds finest brands all from the comfort of their homes.</p>
  </div>
</div>
</body>
</html>