<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>

<%
		String code = request.getParameter("code");

		String sessionState = request.getParameter("session_state");
	
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<meta charset="ISO-8859-1">
</head>

<body>
    <script type="text/javascript">
    
        function makePostRequest() {
            
            var url = '<%= properties.getProperty("tokenEndpoint") %>';           
            var code = encodeURIComponent('<%= code %>');
            var state = encodeURIComponent('<%= sessionState %>');
            var sessionState = encodeURIComponent('<%= sessionState %>');
            localStorage.setItem('state', state);
            var client_Id = '<%= properties.getProperty("client_id") %>';
            var client_secret = '<%= properties.getProperty("client_secret") %>';
            var redirect_uri = '<%= properties.getProperty("baseurl") %>'+ '/MotoService_VehicleReservation/Authorize.jsp';
            
            var csrfToken = '<%= session.getAttribute("csrfToken") %>';    
            
            var bodyParams = new URLSearchParams();
            bodyParams.append('code', code);
            bodyParams.append('grant_type', 'authorization_code');
            bodyParams.append('client_id', client_Id);
            bodyParams.append('client_secret', client_secret);
            bodyParams.append('redirect_uri', redirect_uri);
            bodyParams.append('state', state);
            bodyParams.append('csrfToken', csrfToken);
            
            var requestOptions = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                data: bodyParams.toString() 
            };

            $.ajax(url, requestOptions)
                .done(function (data) {
                    console.log(data.access_token);
                    var access_token  = data.access_token;
                   	var id_token = data.id_token;
                   	localStorage.setItem('access_token', access_token);
                   	localStorage.setItem('id_token', id_token);
            	    window.location.href = "Pages/Home.jsp";
                })	
                .fail(function (xhr, textStatus, errorThrown) {
                   console.error('Error:',  errorThrown);

                    window.location.href = "Pages/Login.jsp";
                });   
            
        }

        
        makePostRequest();
    </script>   
</body>

</html>