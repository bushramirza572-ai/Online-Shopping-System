<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*"%>
<%
String email=request.getParameter("email");
String mobileNumber=request.getParameter("mobileNumber");
String newPassword=request.getParameter("newPassword");

try {
    Connection con = ConnectionProvider.getcon();  

    
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM users WHERE email=? AND mobilenumber=?"
    );
    ps.setString(1, email);
    ps.setString(2, mobileNumber);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        
        PreparedStatement ps2 = con.prepareStatement(
            "UPDATE users SET password=? WHERE email=?"
        );
        ps2.setString(1, newPassword);
        ps2.setString(2, email);
        int updated = ps2.executeUpdate();

        if (updated > 0) {
            response.sendRedirect("forgotPassword.jsp?msg=done");
        } else {
            response.sendRedirect("forgotPassword.jsp?msg=invalid");
        }
    } else {
       
        response.sendRedirect("forgotPassword.jsp?msg=invalid");
    }
    con.close();
 }
catch(Exception e)
{
	System.out.println(e);
	}
%>