<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import ="business.*,java.util.ArrayList"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.*"%>
<html>
	<head>
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
		<meta charset="utf-8">
	<a href="/MarketMaps/add_company.jsp">Add a company</a>
	<a href="/MarketMaps/logout.jsp">Logout</a>
    
    	<title>MarketMaps Site Administration</title>
	    <style>
		      #map-canvas {
		        width: 500px;
		        height: 400px;
		        margin: 0px;
		        padding: 0px;
		      }
		      #panel {
		        position: absolute;
		        top: 5px;
		        left: 50%;
		        margin-left: -180px;
		        z-index: 5;
		        background-color: #fff;
		        padding: 5px;
		        border: 1px solid #999;
		      }
		      body{
		      	font: 15px arial, sans-serif;
		      }
		      
	    </style>
	    
	    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
  
        <script> var array = []; </script>
  
   <!--  This code goes through the companies in the request object and insert the city and state into 
   a JavaScrip array that can be used for mapping pins later -->
	  <%  
	  ArrayList<Company> companyList = (ArrayList<Company>) request.getAttribute("companyList");
	  String gfl="";
	   
	  if(companyList!=null){
		for (Company currentCompany:companyList)
		{
		  gfl= currentCompany.getCity()+","+ currentCompany.getState(); 
		%>
		
			<script>
			array.push("<%out.print(gfl);%>")
			</script>
		
		<%
			}
	    }
	   %>

  <!--  This script segment are the function to initilize the map upon loading the page and geocoding the locatio
     of the companies using the city and state of the company -->  
  <script>
	  
	  var geocoder;
	  var map;
	  
	    function initialize() {
	    geocoder = new google.maps.Geocoder();
	    var latlng = new google.maps.LatLng(45.520, -122.682);
	    
	    var mapOptions = {
	      zoom: 8,
	      center: latlng
	    }
	    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	    
	    
	    
	    var xyz = "<%out.print(gfl);%>";
	    
	    for (index = 0; index < array.length; ++index) {
	        codeAddress(array[index]);
	    }
	  
	  }
	
	  function codeAddress() {
	
		   var address = document.getElementById('address').value;
	  		
	  	  geocoder.geocode( { 'address': address}, function(results, status) {
	    
	  	  if (status == google.maps.GeocoderStatus.OK) {
	        map.setCenter(results[0].geometry.location);
	     
	        var marker = new google.maps.Marker({
	            map: map,
	            position: results[0].geometry.location
	        });
	      } else {
	        alert('Geocode was not successful for the following reason: ' + status);
	      }
	    });
	  
	  }
	  
	  
	  function codeAddress(address) {
	
	 		
		 	  geocoder.geocode( { 'address': address}, function(results, status) {
		   
		 	  if (status == google.maps.GeocoderStatus.OK) {
		       map.setCenter(results[0].geometry.location);
		    
		       var marker = new google.maps.Marker({
		           map: map,
		           position: results[0].geometry.location
		       		});
		     } else {
		       alert('Geocode was not successful for the following reason: ' + status);
		     }
		   });
		 
	 	}
	  
        /*Upon loading the window call initialize JavaScript fuction*/
   		google.maps.event.addDomListener(window, 'load', initialize);
  	
      </script>
	</head>

	<%
	response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
	%>

	<body>
		<h1>MarketMaps Site Administration</h1>
		
		
	  	<div id="map-canvas"></div>
		
		<table border="0" cellpadding="5">
			<tr>
				<th>Name</th>
				<th>Address</th>
				<th>City</th>
				<th>State</th>
				<th>Zipcode</th>
				<th>Phonenumber</th>
				<th>Email</th>
				<th>Description</th>
				<th>Owner</th>
				<th>Logo</th>
		    </tr>
			
				<%
				if(companyList!=null){
				for (Company currentCompany:companyList)
				{
				%>
					  					  
					<!--   		  <form action="addToCompanyList" method="post">  -->					  
			
						  <tr>
						    <td><%= currentCompany.getName()%></td>
						    <td><%= currentCompany.getAddress()%></td>
						    <td><%= currentCompany.getCity()%></td>
						    <td><%= currentCompany.getState()%></td>
						    <td><%= currentCompany.getZipcode()%></td>
						    <td><%= currentCompany.getPhonenumber()%></td>
						    <td><%= currentCompany.getEmail()%></td>
						    <td><%= currentCompany.getDescription()%></td>
						    <td><%= currentCompany.getOwner()%></td>
						    
						    <td>
						<%
						  if(currentCompany.getImg()!=null){
							 					  
							  ByteArrayOutputStream baos = new ByteArrayOutputStream();
							  ImageIO.write(currentCompany.getImg(), "jpg", baos );
							  baos.flush();
							  byte[] imageInByteArray = baos.toByteArray();
							  baos.close();
							  String b64 ="";
							  b64=javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
	
							  
							 out.println("<img src='data:image/jpg;base64,"+ b64 + "' alt='No Company Logo Added' style='max-height: 100px; max-width: 100px;'/>");
					         }
					         
					       %>    
							</td>					    

					        					        
					        <td>
							  <form action="editCompanyInfo" method="post">
								  <input type="hidden" name="name" value="<%= currentCompany.getName()%>">
								  <input type= "submit" name = "editCompany" value="Edit">
							 </form>
							</td>
   
                            <td>
                   
							  <form action="addToCompanyList" method="post">
							    <input type="hidden" name="name" value="<%= currentCompany.getName()%>">
   								<input type="submit" name="removeCompany" value="Remove">
							  </form>
							</td>
                            
           			  </tr>
					<%}}%>
			
		</table>

	<a href="/MarketMaps/add_company.jsp">Add a company</a>
	<a href="/MarketMaps/logout.jsp">Logout</a>
</body>

</html>
