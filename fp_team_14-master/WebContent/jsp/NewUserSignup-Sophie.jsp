<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" type="text/css" href="../css/NewUserSignup-Sophie.css" />  


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SignUp</title>
</head>
<script>
		/*
		* Queries the database to see if the email entered in the form is unique.
		* Returns true if the email is unique and false otherwise. 
		* Displays an error message on false. 
		*
		*/
		function checkUniqueEmail() {
			document.getElementById("error").innerHTML = "This email has already been taken. Please choose another one.";
			return false;
		}
		function myFunction(x) {
			System.out.println("c");
		  
		    if (x.style.display === 'Customer') {
		       System.out.print("I'm a customer")
		    } else {
		    	System.out.println("I'm a shopper")
		    }
		}
	</script>
<body>
<div class="title">
	<img src="../images/Cuposugar.png" />
	</div>
	<div id="error"> </div>
	<div class="container">
		<form class="form-signin" name = "signupForm" method = "POST" onsubmit="return checkUniqueEmail()" action = "CustomerHomepage.jsp">
			
			
				
			<input type="text" class="form-control" name="fname" placeholder="First Name" required autofocus/>
				
				<input type="text" class="form-control" name="lname" placeholder="Last Name" required autofocus/>
			
				
				<input type="text" id="inputUser" class="form-control" placeholder="Username" required autofocus><br/>
			
			
			<input type="password" id="inputPassword" class="form-control" placeholder="Password" required><br/>
				
				
				<div class="onoffswitch">
    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" checked onclick="myFunction(this)">
    <label class="onoffswitch-label" for="myonoffswitch">
        <span class="onoffswitch-inner"></span>
        <span class="onoffswitch-switch"></span>
    </label>
</div>
				
				
				<!-- <label for="flip-1">Flip switch:</label>
				<select name="toggleSwitch" id="toggleSwitch" data-role="slider">
					<option value="Customer">Customer</option>
					<option value="Shopper">Shopper</option>
				</select> -->
				
				
				
				<input type="text" class="form-control" name="address1"  placeholder="Address1" required autofocus/><br/>
			
				<input type="text" class="form-control" name="address2" placeholder="Address2" required autofocus/><br/>
			
				<input type="text" class="form-control" name="citystate" placeholder="City, State" required autofocus /><br/>
				
				<input type="text" class="form-control" name="zipcode" placeholder="Zipcode" required autofocus/><br/>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Sign Up</button>
		</form>
		
	</div>
</body>
</html>