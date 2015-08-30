		function validate()
		{
			
			if(document.form.j_username.value=="")
			{
				alert("Please enter your username");
				form.j_username.focus();	
				return false;
			}
			else if (document.form.j_password.value=="")
			{
				alert("Please enter your password");
				form.j_password.focus();		
				return false;
			} 
			else
			{
			 	return true;
			}
		}