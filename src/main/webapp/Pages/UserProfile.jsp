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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet"  href ="../Styles/user.css">
    <title>FixMyRide | User Profile</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
    <script type="text/javascript"  src="../JS/moto.js"></script>   
    <script type="text/javascript">
			const client_Id = '<%= properties.getProperty("client_id") %>';			
			const postLogoutRedirectUri = '<%= properties.getProperty("baseurl") %>' + '/MotoService_VehicleReservation/Pages/Login.jsp';						  
			const idToken = localStorage.getItem('access_token');
			const state = localStorage.getItem('state');
					console.log(state);
					document.getElementById('logout_btn').addEventListener('click', function () {
					    document.getElementById("client_id").value = client_Id;
					    document.getElementById("post_logout_redirect_uri").value = postLogoutRedirectUri;
					    document.getElementById("state").value = state;
					    document.getElementById("logout-form").submit();
					    console.log("Form submitted");
					});

	</script>
</head>

<body>
    <%@ include file="Navbar.jsp" %>

	    <div class="profile_img">
	        <i class="fas fa-user-circle"></i>
	        <span class="prof_name" id = 'name'></span>
	    </div>

  		<div class="profile_container">
		  <ul>			      
			    <li><span class="profli">First Name&emsp;&nbsp;: </span><span class="prof_li" id="given_name"></span></li>
			    <li><span class="profli">Last Name&emsp;&nbsp; : </span><span class="prof_li" id="family_name"></span></li>
			    <li><span class="profli">User Name&emsp;&nbsp; : </span><span class="prof_li" id="username"></span></li>
			    <li><span class="profli">Email &emsp;&emsp; &emsp; : </span><span class="prof_li" id="email"></span></li>
			    <li><span class="profli">Country &emsp;&emsp; : </span><span class="prof_li" id="address"></span></li>
			    <li><span class="profli">Contact&emsp; &emsp;&nbsp; : </span><span class="prof_li" id="phone"></span></li>		
		  </ul>
		    
			<div class="logout">
			    <form id="logout-form" action='<%= properties.getProperty("logoutEndpoint") %>'method="POST">
			        <input type="hidden" name="client_id" id="client_id" value="">		       
			        <input type="hidden" name="post_logout_redirect_uri" id="post_logout_redirect_uri" value="">
			        <input type="hidden" name="state" id="state" value="">
			        <button type="submit" id="logout_btn" class="logout_btn">Logout</button>
			    </form>     
			</div>
  	    </div>
</body>

</html>
