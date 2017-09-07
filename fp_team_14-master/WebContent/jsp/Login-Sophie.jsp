<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/Login-Sophie.css" /> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>

<body>
	<div class="title">
	<img src="../images/Cuposugar.png" />
	</div>
	<div class="container">
		<form class="form-signin">
			
			
			
			<input type="username" id="inputUser" class="form-control" placeholder="Username" required autofocus><br/>
			
			
			<input type="password" id="inputPassword" class="form-control" placeholder="Password" required><br/>
			
			<!-- <div class="switchbutton">
			Customer
			<label class="switch">
 					 <input type="checkbox">
 				 	<div class="slider round"></div>
				</label>
				Shopper
			</div> -->
			
			<div class="onoffswitch">
    			<input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" checked onclick="myFunction(this)">
   					 <label class="onoffswitch-label" for="myonoffswitch">
       					 <span class="onoffswitch-inner"></span>
        				<span class="onoffswitch-switch"></span>
    				</label>
			</div>
				
			<div class = "twobutton">
			<button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
			<button class="btn btn-lg btn-primary btn-block" type="submit">Visit as Guest</button>
			</div>
		</form>
	</div>
</body>
</html>