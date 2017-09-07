<%
	int availableIntervals = Integer.parseInt(request.getParameter("intervals"));
	//int availableIntervals = 1;
%>
<form>
	<%for(int i = 0; i < availableIntervals; i++) { %>
		<input type="radio" name="interval" value="<%=i%>" onclick="sendMessage(<%=i%>)">Available Time: <%=i%> <br/> 
	<%} %>
	<input type="submit" name="submitButton">Choose that time! <br/>
</form>
