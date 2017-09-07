<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.util.Map" %>
<%@page import = "database.MySQLDriver" %>
<%
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	MySQLDriver msql = new MySQLDriver();
	
	msql.connect();

	//Username does not exist
	if(!msql.userExists(email)){
		%>Username does not exist!<%
	}
	else{
		int loggedInUserID = msql.getUserID(email);
		session.setAttribute("loggedInUserID", loggedInUserID);
		
		//Check password
		if(!password.equals(msql.getUserColumn(loggedInUserID, "password"))){
			%>Incorrect Password<%
		}
	}
	msql.stop();%>