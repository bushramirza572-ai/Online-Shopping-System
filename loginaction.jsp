<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*"%>
<%

String email=request.getParameter("email");
String password=request.getParameter("password");
try{
if("admin@gmail.com".equals(email) && "admin".equals(password))
{
	session.setAttribute("email",email);
	response.sendRedirect("admin/adminHome.jsp");
}
else
{
	Connection con = ConnectionProvider.getcon();
    String query = "SELECT * FROM users WHERE email = ? AND password = ?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, email);
    ps.setString(2, password);
    
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        session.setAttribute("email", email);
        response.sendRedirect("home.jsp");
    } else {
        response.sendRedirect("login.jsp?msg=notexist");
    }
    rs.close();
    ps.close();
    con.close();
}
} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("login.jsp?msg=invalid");
}
%>