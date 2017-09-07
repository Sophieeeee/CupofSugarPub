<%@page import = "database.MySQLDriver"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "java.util.Map"%>
<%
	String category = request.getParameter("category");
	session.setAttribute("category",category);
	Integer loggedInUserID = (Integer)session.getAttribute("loggedInUserID");
	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	Map<String,ArrayList<Integer>> stores = msql.getStoreList(category);
	//session.setAttribute("storeList",stores);
	String typeOfUser = (String)session.getAttribute("typeOfUser");
	float inAppCurrency = (float)session.getAttribute("inAppCurrency");
	String inAppString = (String)session.getAttribute("inAppString");
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/StoreList.css" />
		<script src="../js/WebSocketEndpoint.js" type="text/javascript"></script>
		<script src="../js/StoreList.js" type="text/javascript"></script>
		<title>Store List</title>
	</head>
	<body>
		<div id="headerbar">
			<h1 id="title">
				<img src="../images/Cuposugar.png" />
			</h1>
		</div>
		<div id="sidebar">
			<button id="profilePage"><img src="../images/profilePic.png"></button>
			<h3 id="inAppCurrency"><%=inAppString%></h3>
			<button id="logout"><img src="../images/logout.png" /></button>
		</div>
		<div class = "shadow">
			<div id="storeList">
				<!-- List of stores as Dropdown menu -->
				<select  class="styled-select blue semi-square" id="storeListDropdown" onchange="getAvailableIntervals('<%=typeOfUser%>',<%=loggedInUserID%>)">
					<option value="Select Options">Select Store...</option>
				<%for(String store : stores.keySet()) { %>
					<option value="<%=store%>"><%=store%></option>
				<%} %>	
				</select>
			</div>
			<div id="availableIntervals">
				<!-- Please check StoreListTimeHelper.jsp for further divs to style -->
			</div>
			<div id="error"></div>
		</div>
	</body>
</html>

	