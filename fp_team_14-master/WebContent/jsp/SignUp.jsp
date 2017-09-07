<!-- Create new user and display error if the email is taken. Uses Firebase to authenticate and add a new user. -->
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/NewUserSignup.css" /> 
		<script src="../js/SignUpValidation.js" type="text/javascript"></script>
		<title>Sign Up</title>
	</head>
	<body>

	  <div id="title" class="title">
	  	<img src="../images/Cuposugar.png" />
	  </div>
	  <div id="error"></div>
	  <div id="signup" class="container">
      	<form class="form-signin" id="signupForm" name = "signupForm" method = "POST" onsubmit="return handleSubmit()" action="../EntryConfirmation">
				<input type="text" id="fname" class="form-control" name="fname" placeholder="First Name" required autofocus/>
				<input type="text" id="lname" class="form-control" name="lname" placeholder="Last Name" required autofocus/>
				<input type="text" id="email" class="form-control" name="email" placeholder="Email" required autofocus><br/>
				<input type="password" id="password" class="form-control" placeholder="Password" required><br/>
				<div class="onoffswitch">
   					<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch">
    				<label class="onoffswitch-label" for="myonoffswitch">
        				<span class="onoffswitch-inner"></span>
        				<span class="onoffswitch-switch"></span>
   					</label>
				</div>
				<input type="text" id="address1" class="form-control" name="address1"  placeholder="Address1" required autofocus/><br/>
				<input type="text" id="address2" class="form-control" name="address2" placeholder="Address2" required autofocus/><br/>
				<input type="text" id="citystate" class="form-control" name="citystate" placeholder="City, State" required autofocus /><br/>
				<input type="text" id="zipcode" class="form-control" name="zipcode" placeholder="Zipcode" required autofocus/><br/>
				<button class="btn btn-lg btn-primary btn-block" id="submitButton" name="submitButton" type="submit">Sign Up</button>
			</form>
		</div>
	</body>
</html>