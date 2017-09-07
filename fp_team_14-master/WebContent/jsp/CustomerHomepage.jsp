<!--  Display categories for the customer to choose. Queries Firebase for the customer information. -->
<%
	float inAppCurrency = (float)session.getAttribute("inAppCurrency");
	String inAppString = (String)session.getAttribute("inAppString");
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/CustomerHomepage.css" /> 
		<title>Customer Homepage</title>	
	</head>
	<body>
		<div id="headerbar">
			<h1 id="title">
				<img src="../images/Cuposugar.png" />
			</h1>
		</div>
		<div id="sidebar">
			<button id="profilePage"><img src="../images/profilePic.png" /></button>
			<h3 id = "inAppCurrency"><%=inAppString%></h3>
			<button id="logout"><img src="../images/logout.png" /></button>
		</div>
		<div id="customerHomepage">
			<table id="categories">
				<tr>
					<td>
						<button id="grocery" name="grocery" onclick="location.href='StoreList.jsp?category=grocery';"><img src="../images/grocery.png" /></button>
					</td>
					<td>
						<button id="convenience" name="convenience" onclick="location.href='StoreList.jsp?category=convenience';"><img src="../images/convenience.png" /></button>
					</td>
				</tr>
				<tr>
					<td>
						<button id="health" name="health" onclick="location.href='StoreList.jsp?category=health';"><img src="../images/health.png" /></button>
					</td>
					<td>
						<button id="clothing" name="clothing" onclick="location.href='ComingSoon.jsp';"><img src="../images/clothing.png" /></button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>