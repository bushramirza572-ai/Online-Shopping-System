<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<title>Home</title>
<style>

h3 {
	color: yellow;
	text-align: center;
}
.product-card {
    /* Reduce the margin from 15px to a smaller value, e.g., 5px or 10px */
    margin: 5px; 
    border-radius: 15px;
    box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
    transition: transform 0.3s ease-in-out;
    /* Optional: Keep the smaller max-width if you used it before */
    max-width: 250px; 
}
.product-card:hover {
    transform: scale(1.05);
}
/* Focus on reducing this height for the image */
.card-img-top {
    height: 120px; /* REDUCED IMAGE HEIGHT */
    object-fit: contain; /* Use 'contain' to show the whole image, or 'cover' to crop it */
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
}

    .card img {
      width: 100%;
      height: 120px; /* REDUCED IMAGE HEIGHT for a smaller look */
      object-fit: contain; /* Use 'contain' to show the whole image, or 'cover' to crop it */
      border-radius: 8px;
    }
 </style>

</head>
<body class="bg-grey text-white">
<div style="color: black; text-align: center; font-size: 30px;">
  Home <i class="fa-solid fa-house"></i>
</div><br>
<%
String msg = request.getParameter("msg");
String qty = request.getParameter("qty"); 
if(msg != null) {
    if(msg.equals("added")) {
%>
        <h3><div class="alert alert-success">
            Product added to cart! Quantity: <%= qty %>
        </div></h3>
<%
    } else if(msg.equals("exist")) {
%>
       <h3> <div class="alert alert-warning">
            Product quantity updated in cart! Quantity: <%= qty %>
        </div></h3>
<%
    } else if(msg.equals("invalid")) {
%>
        <h3><div class="alert alert-danger">Error adding product to cart!</div></h3>
<%
    }
}
%>

<div class="container">
  <div class="row">
<%
int found = 0;
try {
    String search = request.getParameter("search");
    Connection con=ConnectionProvider.getcon();
    PreparedStatement ps;

    if (search != null && !search.trim().isEmpty()) {
        String query = "SELECT * FROM product WHERE (LOWER(name) LIKE ? OR LOWER(category) LIKE ?) AND active='Yes'";
        ps = con.prepareStatement(query);
        ps.setString(1, "%" + search.toLowerCase() + "%");
        ps.setString(2, "%" + search.toLowerCase() + "%");
    } else {
        String query = "SELECT * FROM product WHERE active='Yes'";
        ps = con.prepareStatement(query);
    }

    ResultSet rs = ps.executeQuery();
    while(rs.next()) {
        found = 1;
%>
        <div class="col-md-3">
          <div class="card product-card bg-white text-dark">
                      
            <!-- Card Body -->
            <div class="card-body text-center">
            <img src="product_images/<%= rs.getString("photoname") %>"  class="card-img-top" alt="Product Image" onerror="this.onerror=null;this.src='images/default.jpg';">

              <h5>Name: <%= rs.getString("product_name") %></h5>
              <p>Category: <%= rs.getString("category") %></p>
              <p><strong><i class="fa fa-inr"></i> <%= rs.getString("price") %></strong></p>
              <a href="addToCartAction.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning">
    <i class="fas fa-shopping-cart"></i> Add to Cart
</a>

            </div>
          </div>
        </div>
        
        
<%
    }
    rs.close();
    ps.close();
    con.close();
} catch(Exception e) {
    e.printStackTrace();
}
%>
  </div>
</div>

<% if(found == 0){ %>
    <h1 class="text-center text-warning">Nothing to show</h1>
<% } %>
<%@ include file="footer.jsp" %>
</body>
</html>
