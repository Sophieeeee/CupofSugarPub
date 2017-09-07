<!-- Displays the stores as a dropdown menu box -->
<%
	//Get the list of stores
	String stores = request.getParameter("stores");
	String[] storeList = stores.split(",");
%>
	
	<!-- List of stores as Dropdown menu -->
	<select  class="styled-select blue semi-square" id="storeListDropdown" onchange="getAvailableIntervals()">
		<option value="Select Options">Select Store...</option>
	<%for(int i = 0; i < storeList.length; i++) { %>
		<option value="<%=storeList[i]%>"><%=storeList[i]%></option>
	<%} %>	
	</select>
	
	