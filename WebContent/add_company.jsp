<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
	    <title>MarketMaps Add a Company</title>
	</head>    
<body>


    <%
    	String message = (String) request.getAttribute("message");
    	if (message==null) message="";
    %>
     <p><i><%= message %></i></p>

    <form action="addToCompanyList" method="post" enctype="multipart/form-data">
		<table cellspacing="5" border="0">
		    <tr>
		        <td align="right">Company Name:</td>
		        <td><input type="text" name="name">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">City:</td>
		        <td><input type="text" name="city">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">State:</td>
		        <td><input type="text" name="state">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">Description:</td>
		        <td><input type="text" name="description">
		        </td>
		    </tr>
		    <tr>
		        <td align="right">Select file to upload:</td>
     	        <td><input type="file" name="logo">
     	        </td>
     	    </tr>
		    <tr>
		        <td>
		        <input type="hidden" name="addCompany" value="doAdd">
		        </td>
		        <td><br><input type="submit" value="Submit"></td>
		    </tr>
		</table>
	</form>
</body>

</html>