<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/addNewProduct-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <title>Add New Product</title>
    
</head>
<body>
<%
    String msg = request.getParameter("msg");
    if ("done".equals(msg)) {
        out.println("<h3 class='alert'>Product Added Successfully!</h3>");
    } else if ("wrong".equals(msg)) {
        out.println("<h3 class='alert'>Something went wrong! Try Again!</h3>");
    }
%>

<form action="<%= request.getContextPath() %>/admin/addProductAction.jsp" method="post">
    <div class="left-div">
        <h3>Enter Name</h3>
        <input class="input-style" type="text" name="productname" placeholder="Enter Product Name" required>
        <hr>
    </div>

    <div class="right-div">
        <h3>Enter Category</h3>
        <input class="input-style" type="text" name="category" placeholder="Enter Category" required>
        <hr>
    </div>

    <div class="left-div">
        <h3>Enter Price</h3>
        <input class="input-style" type="number" step="0.01" name="price" placeholder="Enter Product Price" required>
        <hr>
    </div>
   

    <div class="right-div">
        <h3>Active</h3>
        <select class="input-style" name="active" required>
            <option value="yes">Yes</option>
            <option value="no">No</option>
        </select>
        <hr>
    </div>
    <div class="form-group left-div">
       <h3><label for="exampleFormControlFile1" class="label-center">Uploade Photo</label></h3>
       <input class="input-style" name="bimg" type="file" class="form-control-file" id="exampleFormControlFile1" required>
    </div><hr>
    <br>

    <button class="button">
    <i class="fas fa-save"></i> Save
</button>
</form>

</body>
</html>


