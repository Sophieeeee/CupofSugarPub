<%@page import = "database.MySQLDriver" %>
<%
	//Get parameters
	int shopperID = (int)session.getAttribute("loggedInUserID");
	String storeName = request.getParameter("store");
	int interval = Integer.parseInt(request.getParameter("interval"));
	
	//connect to database and update shopper availability
	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	msql.addInterval(shopperID, storeName, interval);
	msql.stop();
%>
