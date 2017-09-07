<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/Login.css" /> 
		<title>Login</title>
		<script>
			function validate(){
				var xhttp = new XMLHttpRequest(); //JavaScript is acting like a browser making an Http request
				xhttp.open("GET", "LoginError.jsp?email="+document.signUpForm.email.value+"&password="+document.signUpForm.password.value, false);
				xhttp.send();
				if (xhttp.responseText.trim().length>0) {
		            document.getElementById("error").innerHTML = xhttp.responseText;
		            return false;
		        }
				return true;
			}
		</script>
	</head>
	
	<body>
		<div class="title">
			<img src="../images/Cuposugar.png" />
		</div>
		<div class="container">
			<div id="error"></div>
			<form name="signUpForm" class="form-signin" method="POST" onsubmit="return validate()" action="../EntryConfirmation">
				<input type="username" name="email" id="inputUser" class="form-control" placeholder="email" required autofocus><br/>
				<input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required><br/>
				<div class="onoffswitch">
	    			<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" checked onclick="myFunction(this)">
	   				<label class="onoffswitch-label" for="myonoffswitch">
	       				<span class="onoffswitch-inner"></span>
	        			<span class="onoffswitch-switch"></span>
	    			</label>
				</div>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Visit as Guest</button>
			</form>
		</div>
	</body>
</html>