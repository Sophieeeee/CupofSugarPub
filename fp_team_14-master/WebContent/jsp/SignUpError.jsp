<%@page import = "database.MySQLDriver" %>
<%@page import = "java.sql.SQLException"%>
<%
	//Create and store the database in the session
	MySQLDriver msql = new MySQLDriver();
	
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String citystate = request.getParameter("citystate");
	String zipcode = request.getParameter("zipcode");
	String fullAddress = address1+", "+address2+", "+citystate+" "+zipcode;
	String typeOfUser = request.getParameter("typeOfUser");
	
	//Check if any of the fields are empty
	if(email=="" || password=="" || fname=="" || lname=="" || address1=="" || citystate=="" || zipcode==""){
		%>Please fill in all the fields.<%
	}else{
		msql.connect();
		if (msql.userExists(email)) {
			%>An account has already been created with this email.<%
		} else {
			msql.addUser(email, password, fname, lname, fullAddress, typeOfUser);
		}
		msql.stop();
	}
%>