<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
	    <title>MarketMaps Add a Company</title>
	    
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

  	<font color="white"><h1>Add a New Company</h1></font>
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