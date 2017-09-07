<!-- Displays list of available times for chosen store -->
<%@page import = "java.util.ArrayList" %>
<%@page import = "java.util.Map" %>
<%@page import = "java.util.Date" %>
<%@page import = "database.MySQLDriver" %>
<%@page import = "java.text.SimpleDateFormat" %>
<%
	//Get the type of user
	String typeOfUser = (String)session.getAttribute("typeOfUser");
		
	//Get the selected store
	String store = request.getParameter("store");
	
	//Get the category
	String category = (String)session.getAttribute("category");
	
	//Get the map of times
	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	Map<String,ArrayList<Integer>> storeList = msql.getStoreList(category);
	msql.stop();
	//Map<String,ArrayList<Integer>> storeList = (Map<String,ArrayList<Integer>>)session.getAttribute("storeList");
	ArrayList<Integer> timeList = storeList.get(store);
	timeList.sort(null);
		
	//Get all of the times for the store
	if(typeOfUser.equals("customer")){
		//Make sure all times are available times
		if(timeList.size()==0){%>
			There are no available times for this store
		<%} else%>
			 <form class = "timeform" method="POST" id="<%=store%>AvailableIntervals" onsubmit="return validateInterval()" action="Items.jsp">
				<%for(int j = 0; j < timeList.size(); j++) { 
					SimpleDateFormat sdf = new SimpleDateFormat("hh:mm aa");
					SimpleDateFormat parseFormat = new SimpleDateFormat("h");
				    Date date = parseFormat.parse(Integer.toString(timeList.get(j)));
				%>
					<input type="radio" id="<%=j%>" name="interval" value="<%=timeList.get(j)%>" onclick="storeInterval(<%=timeList.get(j)%>)">
					<input type="hidden" name="store" value="<%=store%>">
					<label class="timelabel" for="<%=j%>"><span></span>Available Time: <%=sdf.format(date) %> <br/> </label>
				<%} %>
				<input class="btn btn-lg btn-primary btn-block" type="submit" name="submitButton">
				<h4 id="choosetime">Choose That Time!</h4> <br/>
				
			</form> 
	<%//If the user is a shopper, display option of times they can pick to go shopping
	}else if(typeOfUser.equals("shopper")){%>
		<select class="styled-select blue semi-square"  id="timeOptionsDropdown" onchange="storeShopperTime()">
			<option value="Select A Time">Select A Time...</option>
			<%for(int i = 0; i < 24; i++) { 
				SimpleDateFormat sdf = new SimpleDateFormat("hh:mm aa");
				SimpleDateFormat parseFormat = new SimpleDateFormat("h");
			    Date date = parseFormat.parse(Integer.toString(i));
			    if(i==12){%>
			    	<option value="<%=i%>">12:00 PM</option>
			    <%} else{%>
				<option value="<%=i%>"><%=sdf.format(date) %></option>
				<%}
			}%>	
		</select>
		<form action="CustomerHomepage.jsp">
			<input class="shopperbtn" type="submit" onclick="return sendIntervalToDB()" name="submitButton" value="Choose that time!"></br>
		</form>
	<%}%>