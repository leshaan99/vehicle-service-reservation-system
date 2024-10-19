<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>

<% 
		Properties properties = new Properties();
		
		try {
			 InputStream inputStream = application.getResourceAsStream("/WEB-INF/application.properties");
			 properties.load(inputStream);
			} catch (IOException e) {
			    e.printStackTrace();
			} 
%>
	
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<script type="text/javascript"  src="../JS/moto.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet"  href ="../Styles/home.css">	
	<title>FixMyRide | Home</title>
</head>

<body>
	<%@ include file="Navbar.jsp" %>

	<div class="home_container">
		<img class="homebg" src="../Images/homebg07.avif">	
			<div class="home_text">
				<h2>Welcome to</h2>
				<h1>FixMyRide</h1>
				<h3>Your Trusted</h3>
				<h3>Vehicle Service Partner</h3>
			</div>
	</div>
</body>

</html>