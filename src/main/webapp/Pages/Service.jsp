<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.database.*" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%@ page import="java.util.Properties" %>	
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>


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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript"  src="../JS/moto.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet"  href ="../Styles/service.css">	 
	<title>FixMyRide | Service</title>
	
<%
      MotoservicesDAO motoservicesDAO = new MotoservicesDAO();
		String dbUrl = "jdbc:mysql://172.187.178.153:3306/vehicle_service_db";
		String dbUser = "root";
		String dbPassword = "";
		ResultSet pastResultSet = null;
		ResultSet futureResultSet = null;
		
		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    
		    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		    
		    if (request.getParameter("submit") != null) {
		        String location = request.getParameter("location");
		        String mileageStr = request.getParameter("mileage");
		        String vehicle_no = request.getParameter("vehicle");
		        String message = request.getParameter("message");
		        String userName = request.getParameter("usernameForStore");
		        String dateStr = request.getParameter("date");
		        String timeStr = request.getParameter("time");
		        
		        System.out.println("Username: " + userName);
			    System.out.println("location: " + location);
			    System.out.println("Mileage: " + mileageStr);
			    System.out.println("Message: " + message);
			    System.out.println("Vehicle No: " + vehicle_no) ;
			    
		        int rowsInserted =  motoservicesDAO.insertService(location,  mileageStr, vehicle_no,  message,  userName,  dateStr,  timeStr, conn);
		        if (rowsInserted > 0) {
		        	out.println("Data inserted successfully. Redirecting...");
		        	response.sendRedirect(request.getRequestURI());
		             
		         }
		        	else if(rowsInserted == -1){
		        	 out.println("Invalid time format. Please enter time in hh:mm format.");
		         }		        
		         	else if(rowsInserted == -2){
		        	 out.println("Error parsing time");		        	 	   
		         }		        
		        	else {
		        	 out.println("Failed to insert data.");
		         }		         
		    }
        
		} catch (ClassNotFoundException e) {
			e.printStackTrace();			
			}		
    %>
    
</head>

	<%@ include file="Navbar.jsp" %>

<body>
 
	<section class="service_container">
		<h1>Register For Service</h1>
		           
		<form class="service_form" method="post" id="serviceform" name="serviceform">	             	              
	 			<input type="hidden" id="usernameForStore" name="usernameForStore" value="">	
	 			<br>	
	 		 	 
			<div class="service_content">
			    <label for="date" class="serv_select">Date *</label>
		  	    &emsp;&emsp;&emsp;&emsp;&nbsp;
		  	    <input type="date" id="date" name="date" min="<%= java.time.LocalDate.now()%>" required="required">
			</div>
			<br>  
	
			<div class="service_content">
		  		<label for="time" class="serv_select">Select a time * </label>
	  	  		&nbsp; &nbsp;
	  	  			<select id="time" name="time" required="required">
		  	  		   <option selected>Time</option>
		  	  		   <option value="10:00 AM">10:00 AM</option>
		               <option value="11:00 AM">11:00 AM</option>
		               <option value="12:00 AM">12:00 AM</option>
	  	  			</select>
			</div>
			<br>
	
			<div class="service_content">
	    		<label for ="location" class="serv_select">Location *</label>
	    		&emsp;&emsp;&nbsp;&nbsp;
					<select class="selectcustom" id="location" name="location" title="Please select a location" required="required">
						<option selected>Choose...</option>
					    <option value="Colombo">Colombo</option>
						<option value="Gampaha">Gampaha</option>
						<option value="Kalutara">Kalutara</option>
						<option value="Kandy">Kandy</option>
						<option value="Matale">Matale</option>
						<option value="Nuwara Eliya">Nuwara Eliya</option>
						<option value="Galle">Galle</option>
						<option value="Matara">Matara</option>
						<option value="Hambantota">Hambantota</option>
						<option value="Jaffna">Jaffna</option>
						<option value="Kilinochchi">Kilinochchi</option>
						<option value="Mannar">Mannar</option>
						<option value="Vavuniya">Vavuniya</option>
						<option value="Mullaitivu">Mullaitivu</option>
						<option value="Batticaloa">Batticaloa</option>
						<option value="Ampara">Ampara</option>
						<option value="Trincomalee">Trincomalee</option>
						<option value="Kurunegala">Kurunegala</option>
						<option value="Puttalam">Puttalam</option>
						<option value="Anuradhapura">Anuradhapura</option>
						<option value="Polonnaruwa">Polonnaruwa</option>
						<option value="Badulla">Badulla</option>
						<option value="Monaragala">Monaragala</option>
						<option value="Ratnapura">Ratnapura</option>
						<option value="Kegalle">Kegalle</option>
					</select>	                  
			</div>				
			<br>
	
			<div class="service_content">
			      <label for="vehicle" class="serv_select">Vehicle *</label>
			      &emsp;&emsp;&emsp;
			      <input type="text" class="form-control" name="vehicle" placeholder="vehicle number" required="required">
			</div>
			<br>
							 
			<div class="service_content">
				<label for="mileage" class="serv_select">Mileage *</label>
				&emsp;&emsp;&nbsp;&nbsp;&nbsp;
				<input type="number" step="1" min="1" pattern="\d+" class="form-control" name="mileage" id="mileage"  placeholder="Total mileage" required="required">
			</div>
			<br>
		                	            
			<div class="service_content">
				<label for="message" class="serv_select">Message *</label>
				&emsp;&emsp; &nbsp;
				<textarea class="form-control" name="message" rows="3" cols="20" id="message" placeholder="Your message" required="required"></textarea>
			</div>
			<br>
			
			<div class="service_content01">
		         <input type="submit" value="submit" id="submit" name="submit" class="service_submit">	         
			</div>		    		              
		</form>		
	</section>
	
	<script>
	    	document.addEventListener('DOMContentLoaded', function () {
	        var username = localStorage.getItem('username');
	        console.log('Value retrieved: ' + username);
	
	        document.getElementById('submit').addEventListener('click', function () {	         
	            document.getElementById('usernameForStore').value = username;
	        });
	    });
	</script>
</body>

</html>