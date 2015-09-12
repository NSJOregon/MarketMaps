<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import ="business.*,java.util.ArrayList"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.*"%>
<html>
	<head>
	    <title>Edit Company Information</title>
	    
	    
	     <style>
	    
	         html{
		        background: -webkit-linear-gradient(#006666, white); /* For Safari 5.1 to 6.0 */
				background: -o-linear-gradient(#006666, white); /* For Opera 11.1 to 12.0 */
				background: -moz-linear-gradient(#006666, white); /* For Firefox 3.6 to 15 */
				background: linear-gradient(#006666, white); /* Standard syntax (must be last) */
		     	font: 15px arial, sans-serif;
                } 

	    </style>
	    
</head>


<body>
	<font color="white"><h1>Edit Company Information</h1></font>
 	<%
    	String message = (String) request.getAttribute("message");
    	if (message==null) message="";
    %>
     <p><i><%= message %></i></p>
 	
 	<%
    Company currentCompany = (Company)request.getAttribute("currentCompany");
     String b64="";      

     if(currentCompany.getImg()!=null){
     ByteArrayOutputStream baos = new ByteArrayOutputStream();
	  ImageIO.write(currentCompany.getImg(), "jpg", baos );
	  baos.flush();
    byte[] imageInByteArray = baos.toByteArray();
	  baos.close();
	  b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
     }
	%>
    <form action="editCompanyInfo" method="post" enctype="multipart/form-data">
	
		<table cellspacing="5" border="0">
		
		    <tr>
		        <td align="right">Company Name:</td>
			<!-- We do not want to let the company name be edited, just display the name-->
			<!-- 		        <td><input type="text" name="name" value="${currentCompany.name}" > -->
				<td>${currentCompany.name}
		        <input type="hidden" name="name" value="${currentCompany.name}" >
		        </td>
		    </tr>
		    <tr>
		        <td align="right">City:</td>
		        <td><input type="text" name="city" value="${currentCompany.city}">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">State:</td>
		        <td><input type="text" name="state" value="${currentCompany.state}">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">Description:</td>
		        <td><input type="text" name="description" value="${currentCompany.description}">
		        </td>
		    </tr>
		        <td><img src="data:image/jpg;base64, <%=b64%>" alt="No Company Logo Added" style="max-height: 100px; max-width: 100px;"/></td>
		    <tr>
		        <td align="right">Replace image:</td>
     	        <td><input type="file" name="logo">
     	        </td>
     	    </tr>
     	    <tr>
		        <td>
		        <input type="hidden" name="updateCompany" value="doUpdate">
		        </td>
		        <td><br><input type="submit" value="Submit"></td>
		    </tr>
		</table>
	</form>
</body>

</html>