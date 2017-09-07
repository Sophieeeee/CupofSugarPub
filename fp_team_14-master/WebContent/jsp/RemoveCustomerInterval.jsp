<%@page import = "database.MySQLDriver" %>
<%
	MySQLDriver msql = new MySQLDriver();
	Integer interval = Integer.parseInt(request.getParameter("interval"));
	String store = request.getParameter("store");
	
	//Set interval and store as a session attribute
	session.setAttribute("store", store);
	session.setAttribute("interval", interval);
	
	//update interval in the database
	msql.connect();
	msql.changeStatusOfInterval(store, interval);
	msql.stop();
%>