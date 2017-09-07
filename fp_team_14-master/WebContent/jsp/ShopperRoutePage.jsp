<%@page import = "database.MySQLDriver" %>
<%
	MySQLDriver msql = new MySQLDriver();
	Integer loggedInUserID = (Integer)session.getAttribute("loggedInUserID");
	String typeOfUser = (String)session.getAttribute("typeOfUser");
	msql.connect();
	int customerID = msql.getCustomerIDFromOrder(loggedInUserID);
	msql.stop();
	
%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Route</title>
    <link rel="stylesheet" type="text/css" href="../css/ShopperRoutePage.css" /> 
    <script src="../js/Map.js" type="text/javascript"></script>
    <script src="../js/Feedback.js" type="text/javascript"></script>
  </head>
  	<body onload="connectShopperToServer(<%=loggedInUserID%>)">
  		<div id="headerbar">
			<img src="../images/Cuposugar.png" />
		</div>
    	<div id="map"></div>
    	<div id="travelTime"></div>
    	<div id="feedback">
    		<form method="POST" id="feedback" action="../Feedback">
    			<input type=checkbox id="deliveryConfirmation1" name="hasDelivered">
    			<label id = "deliveryid" for="deliveryConfirmation1" ><span></span>I have delivered my order </br></label>
    			<input type=checkbox id="deliveryConfirmation2" name="hasNotDelivered" onclick="toggleDeliveryFeedback()">
    			<label id = "deliveryid" for="deliveryConfirmation2"><span></span>I was unable to deliver my order </br></label>
    			<textarea cols="50" style="visibility: hidden" rows="10" class="form-control" name="feedbackText" maxlength="250" id="hasNotDeliveredFeedback" placeholder = "What went wrong?"></textarea>
    			<input type="hidden" name="customerID" value="<%=customerID%>">
    			<input type="hidden" name="shopperID" value="<%=loggedInUserID%>">
    			<br/>
    			<input type="submit" onclick="sendFeedbackToCustomer()" id="submitFeedback">
    		</form>
    	</div>
    	<div id="pastOrderFeedback">
    	</div>
   		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbvgARfNVsUqNbvsmgK495M6vxq5JB4Wc&callback=initMap" type="text/javascript"></script>
	</body>
</html>
