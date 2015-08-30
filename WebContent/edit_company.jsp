<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import ="business.*,java.util.ArrayList"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.*"%>
<html>
	<head>
	    <title>Edit Company Information</title>
	</head>
<body>
 	<%
          Company currentCompany = (Company)request.getAttribute("currentCompany");
 	      ByteArrayOutputStream baos = new ByteArrayOutputStream();
		  ImageIO.write(currentCompany.getImg(), "jpg", baos );
		  baos.flush();
	      byte[] imageInByteArray = baos.toByteArray();
		  baos.close();
		  String b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
	%>
    <form action="editCompanyInfo" method="post" enctype="multipart/form-data">
	
		<table cellspacing="5" border="0">
		
		    <tr>
		        <td align="right">Company Name:</td>
		        <td><input type="text" name="name" value="${currentCompany.name}" >
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