
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import ="business.*,java.util.ArrayList"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<font color="#ffffff" size="2" face="Helvetica, Arial, sans-serif">	<a href="addToCompanyList">Login</a></font>
	<title>MarketMaps</title>	
		<style>
			#grad1{

                background-image: url("backgroundimage.jpg");
                background-color: #0E4039;
                background-repeat: no-repeat;
              	background-size: 100%;		
			}
		
		    #map-canvas {
		        width: 500px;
		        height: 400px;
		        margin: 0px;
		        padding: 0px
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
	        
	        #table{
	        color:#ffffff;
	        size="20";
	        font-family: Verdana;
	        
	        }
    	</style>
    
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
	
    <script>
 	 	var array = [];
    </script>
  
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
	    
	    
	    var styles = [
	                  {
	                    stylers: [
	                      { hue: "#00ffe6" },
	                      { saturation: -20 }
	                    ]
	                  },{
	                    featureType: "road",
	                    elementType: "geometry",
	                    stylers: [
	                      { lightness: 100 },
	                      { visibility: "simplified" }
	                    ]
	                  },{
	                    featureType: "road",
	                    elementType: "labels",
	                    stylers: [
	                      { visibility: "off" }
	                    ]
	                  }
	                ];
	    
	    var styledMap = new google.maps.StyledMapType(styles,
	    	    {name: "Styled Map"});

	    
	    var mapOptions = {
	      zoom: 8,
	      center: latlng,
	      
	      mapTypeControlOptions: {
	          mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
	    }
	    };
	    
	    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	    
	    map.mapTypes.set('map_style', styledMap);
	    map.setMapTypeId('map_style');

	    
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
		           position: results[0].geometry.location,
		           icon: 'marketmapsicon.png'

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

	<body id="grad1">

		<table border="0" cellpadding="2" cellspacing="10" width="100%">
			<tbody>
				<tr>
					<td valign="top"><br></td>
					<td align="center" valign="top" width="60%">
						<font color="#ffffff" size="40" face="Helvetica, Arial, sans-serif">MarketMaps</font><br>
						<font color="#ffffff" size="5" face="Helvetica, Arial, sans-serif">MarketMaps works with many local companies!</font>
						<hr>
						<div id="map-canvas"></div>
						<hr>
					</td>
					<td valign="top"><br></td>
				</tr>
			</tbody>
		</table>
	
<!-- Code below reads the list of companies from the request object and displays -->    

	<table border="0" cellpadding="10" cellspacing="2" width="100%">

	<tbody id="table">
	 
	  <%
				if(companyList!=null){
				for (Company currentCompany:companyList)
				{
				%>

						  <tr>
						    <td></td>
				        	<font size="10"><td><%= currentCompany.getName()%></td></font>
                  		   	<td><%= currentCompany.getCity()%>,
							<%= currentCompany.getState()%></td>
    						<td><%= currentCompany.getDescription()%></td>
						  
						  <!-- Other company information that could be accessed at a later time
							    <td><%= currentCompany.getName()%></td>
							    <td><%= currentCompany.getAddress()%></td>
							    <td><%= currentCompany.getCity()%></td>
							    <td><%= currentCompany.getState()%></td>
							    <td><%= currentCompany.getZipcode()%></td>
							    <td><%= currentCompany.getPhonenumber()%></td>
							    <td><%= currentCompany.getEmail()%></td>
							    <td><%= currentCompany.getOwner()%></td>
						    -->
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
         			  </tr>
					<%}}%>
			 
			 </tbody>
			 
		</table>
	<br>
	
	
 
<font color="#ffffff" size="2" face="Helvetica, Arial, sans-serif">	<a href="addToCompanyList">Login</a></font>

</body>
</html>