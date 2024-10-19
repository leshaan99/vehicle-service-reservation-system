package com.database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MotoservicesDAO {
			 String dbUrl = "jdbc:mysql://172.187.178.153:3306/vehicle_service_db";
		     String dbUser = "root";
		     String dbPassword = "";
		
	    public int insertService(String location, String mileageStr, String vehicle_no, String message, String userName, String dateStr, String timeStr, Connection conn) throws ParseException {
			        int mileage = Integer.parseInt(mileageStr);
			
			        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			        Date date = dateFormat.parse(dateStr);
						
					Time time= null;
			
			        SimpleDateFormat inputFormat = new SimpleDateFormat("hh:mm a");
			
		                try {
		                    java.util.Date utilDate = inputFormat.parse(timeStr);
		
		                    time = new Time(utilDate.getTime());	
		                } 
		                catch (ParseException e) {
		                    e.printStackTrace();
		                }
	       
	
		        try {
		        	
		            String sql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		            PreparedStatement preparedStatement = conn.prepareStatement(sql);
		
		            preparedStatement.setDate(1, new java.sql.Date(date.getTime())); 
		            preparedStatement.setTime(2, time); 
		            preparedStatement.setString(3, escapeHtml(location));
		            preparedStatement.setInt(4, mileage);
		            preparedStatement.setString(5, escapeHtml(vehicle_no));
		            preparedStatement.setString(6, escapeHtml(message));
		 	        preparedStatement.setString(7, escapeHtml(userName));
		            
		            int rowsInserted = preparedStatement.executeUpdate();
		            conn.close();
		            
		            return rowsInserted;
		        	} 
		       catch (SQLException e) {
		            e.printStackTrace();		            
		            return -1;
		        	}
	    }
	  
	    	    
	    public ResultSet getPastServices(String username) throws ClassNotFoundException, SQLException {
	    	
				ResultSet pastResultSet = null;
		
	
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
				
				String pastSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) < ? ORDER BY date, time";
				PreparedStatement pastPreparedStatement = conn.prepareStatement(pastSql);
				pastPreparedStatement.setString(1, username);
				
				SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String currentDateTime = dateTimeFormat.format(new Date());
				pastPreparedStatement.setString(2, currentDateTime);
			
				pastResultSet = pastPreparedStatement.executeQuery();
						
				} 
			catch (SQLException e) {
				e.printStackTrace();				
				}			
				return pastResultSet;
		}
			    

	   public ResultSet getFutureServices(String username) throws ClassNotFoundException, SQLException{
	    	
				ResultSet futureResultSet = null;
				Connection conn = null;
	
			try {
			    Class.forName("com.mysql.cj.jdbc.Driver");
			    
			    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			  				
			    String futureSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) >= ? ORDER BY date, time";
			    
			    PreparedStatement futurePreparedStatement = conn.prepareStatement(futureSql);
			    futurePreparedStatement.setString(1, username);
			    
			    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    String currentDateTime = dateTimeFormat.format(new Date());
			    futurePreparedStatement.setString(2, currentDateTime);
			    
				 futureResultSet = futurePreparedStatement.executeQuery();
				 			
				}
			catch (SQLException e) {
				e.printStackTrace();
				}
				return futureResultSet;
		        
	   }  
	   

	   
	   public int deleteServices(int bookingId) throws ClassNotFoundException {
		   		PreparedStatement preparedStatement = null;
	
		   	try {
		   		Class.forName("com.mysql.cj.jdbc.Driver");
				    
		   		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		   			  				   	   
		   	    String sql = "DELETE FROM vehicle_service WHERE booking_id = ?";
		
		   	    preparedStatement = conn.prepareStatement(sql);				   	   
		   	    preparedStatement.setInt(1, bookingId);
		
		   	    int rowsAffected = preparedStatement.executeUpdate();
		   	    		   	    
		   	    conn.close();
		   	    return rowsAffected;
		   		}
		   	catch (SQLException e) {
		   	    e.printStackTrace();
		   	    return -1;
		   		} 
	   }
	   

				   private String escapeHtml(String input) {
				       if (input == null) {
				           return "";
				       }
				       return input.replace("&", "&amp;")
				                   .replace("<", "&lt;")
				                   .replace(">", "&gt;")
				                   .replace("\"", "&quot;")
				                   .replace("'", "&#39;");
				   }
	}
