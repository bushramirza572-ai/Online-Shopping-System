<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<title>Add New Product</title>

<style>
.back
{
  color: black;
  margin-left: 2.5%
}
</style>
</head>
<body>
 <h2>
  <a class="back" href="allProductEditProduct.jsp">
    <i class="fas fa-arrow-circle-left"></i> Back
  </a>
</h2>
<%
String id=request.getParameter("id");
try
{
	Connection con=ConnectionProvider.getcon();
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select *from product where id='"+id+"'");
	while(rs.next())
	{
		

%>

<form action="editProductAction.jsp" method="post">
<input type="hidden" name="id" value="<%out.println(id);%>">
<div class="left-div">
 <h3>Enter Name</h3>
<input class="input-style" type="text" name="name" value="<%=rs.getString("product_name")%>" required>

<hr>
</div>

<div class="right-div">
<h3>Enter Category</h3>
 <input class="input-style" type="text" name="category" value="<%=rs.getString("category")%>" required>
<hr>
</div>

<div class="left-div">
<h3>Enter Price</h3>
 <input class="input-style" type="number" name="price" value="<%=rs.getString("price")%>" required>
<hr>
</div>

<div class="right-div">
<h3>Active</h3>
<select class="input-style" name="active">
<option value="Yes">Yes</option>
<option value="No">No</option>
</select>
 <hr>
</div>

  <button class="button">
    <i class="fas fa-save"></i> Save
</button>
</form>
<%
}
}catch(Exception e)
{
	System.out.println(e);
	}
%>

</body>
<br><br><br>
</body>
</html>