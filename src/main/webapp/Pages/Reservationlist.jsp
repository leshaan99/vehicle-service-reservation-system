<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%@ page import="java.util.Properties" %>
<%@ page import="com.database.*" %>
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
		    
		    if (request.getParameter("pastRes") != null){		    	
		    	 String userName = request.getParameter("usernameForStore1");		    	
		    	 pastResultSet =motoservicesDAO.getPastServices(userName);		    			    	
		    }
		    
		    if (request.getParameter("futureRes") != null){		    	
		    	 String userName = request.getParameter("usernameForStore2");		    	
		    	 futureResultSet =motoservicesDAO.getFutureServices(userName);		    		    	
		    }
		    
		   if (request.getParameter("delete") != null){
		    	
		    	String bookingId = request.getParameter("bookingID");		    	
		    	int id = Integer.parseInt(bookingId);		    
		    	int rowsAffected = motoservicesDAO.deleteServices(id);
		    	
		    	if (rowsAffected > 0) {
		    		//refresh the site  
		    		 response.sendRedirect(request.getRequestURI());
			         
			    }else if(rowsAffected == -1){
			    	out.println("Error in the databse. Try again later");
			    } else {
			        out.println("No data found for the given booking ID");
			    }		    			    	
		    } 
		    
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
			
			}		
%>


<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet"  href ="../Styles/reservation.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<title>FixMyRide | Reservation</title>
	<script type="text/javascript"  src="../JS/moto.js"></script>
</head>

<body>
	<%@ include file="Navbar.jsp" %>
				
	<div class="reservation_form">
		<form class="past_reserv" method="post" id="resv_form" onclick="document.getElementById('past_reservation').style.display='block'"  >
			<input type="hidden" id="usernameForStore1" name="usernameForStore1" value="" >
		    <input type="submit" class="res" id="pastRes" name="pastRes" value = "Past Reservation">
	    </form>		    
	    <br>	    
		<form class="future_reserv" method="post" id="resv_form" onclick="document.getElementById('future_reservation').style.display='block'"  >
			<input type="hidden" id="usernameForStore2" name="usernameForStore2" value="" >
		    <input type="submit" class="res" id="futureRes" name="futureRes" value="Future Reservation">
	    </form>
	</div>	
	
<br><br>

	<div id="past_reservation" class = "past_reservation">
		<h1>Past Reservations</h1>
		<hr>
			<table>
				<tr>
					<th>Booking ID</th>
					<th>Date </th>
					<th>Time</th>
					<th>Location</th>
					<th>Mileage</th>
					<th>Vehicle No</th>
					<th>Message</th>	
				</tr>
		
		 <%
	        
	        Date currentDate = new Date();
		 
	        if (pastResultSet != null) {	
	        	
	            while (pastResultSet.next()) {
	            	
	            	Date date = pastResultSet.getDate("date");
	            	if(!date.before(currentDate)){
	            		 continue;
	            	}
	                int bookingId = pastResultSet.getInt("booking_id");
	                Time time = pastResultSet.getTime("time");
	                String location = pastResultSet.getString("location");
	                int mileage = pastResultSet.getInt("mileage");
	                String vehicleNo = pastResultSet.getString("vehicle_no");
	                String message = pastResultSet.getString("message");
	                	            
	        %>
		        <tr>
		            <td><%= bookingId %></td>
		            <td><%= date %></td>
		            <td><%= time %></td>
		            <td><%= location %></td>
		            <td><%= mileage %></td>
		            <td><%= vehicleNo %></td>
		            <td><%= message %></td>
		        </tr>
	        <% 
	            }}
	            
	    %>
			</table>
	</div>

<br><br>

	<div id="future_reservation" class="future_reservation">
		<h1>Future Reservations</h1>
		<hr>
	
			<table>
				<tr>
					<th>Booking ID</th>
					<th>Date </th>
					<th>Time</th>
					<th>Location</th>
					<th>Mileage</th>
					<th>Vehicle No</th>
					<th>Message</th>
					<th>Delete</th>
				</tr>
				 
		<% 
		  Date currentDate1 = new Date();
	        if (futureResultSet != null) {
	            while (futureResultSet.next()) {
	            	
	            	Date date = futureResultSet.getDate("date");
	            	
	            	if(date.before(currentDate1)){
	            		 continue;
	            	}
	                int bookingId = futureResultSet.getInt("booking_id");
	                Time time = futureResultSet.getTime("time");
	                String location = futureResultSet.getString("location");
	                int mileage = futureResultSet.getInt("mileage");
	                String vehicleNo = futureResultSet.getString("vehicle_no");
	                String message = futureResultSet.getString("message");	                	            
	        %>
	        
		        <tr>
		            <td><%= bookingId %></td>
		            <td><%= date %></td>
		            <td><%= time %></td>
		            <td><%= location %></td>
		            <td><%= mileage %></td>
		            <td><%= vehicleNo %></td>
		            <td><%= message %></td>
		            <td><form id="deleteForm" method="post">  
		               		<input type="hidden" id="bookingID" name="bookingID" value=<%= bookingId %>>
		        			<input type="submit" class="delete" name="delete" value="Delete" onclick="confirmDelete()">
		    			</form>
		    		</td>
		        </tr>
	        <% 
	            }}
	            
	    %>	
			</table>	
	</div>
	
	<script>
	    document.addEventListener('DOMContentLoaded', function () {
		        // Getting data from localStorage
		        var username = localStorage.getItem('username');
		        //console.log('Value retrieved: ' + username);
		
	     document.getElementById('pastRes').addEventListener('click', function () {	            
	            document.getElementById('usernameForStore1').value = username;
	        });
	     
	     document.getElementById('futureRes').addEventListener('click', function () {	          
	            document.getElementById('usernameForStore2').value = username;
	        });
	     
	    });
	    
	    function confirmDelete() {
	        if (confirm("Are you sure you want to delete?")) {
	            document.getElementById('deleteForm').submit();
	        }
	    }
	</script>
</body>

</html>