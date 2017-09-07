<%@page import = "database.MySQLDriver" %>
<%@page import = "user.Cart" %>
<%
	//Get custoemrID, interval, and store
	Integer loggedInUserID = (Integer)session.getAttribute("loggedInUserID");
	Integer interval = (Integer)session.getAttribute("interval");
	String store = (String)session.getAttribute("store");
	
	//Decrement the inAppCurrency based off of the total price of the cart
	Cart cart = (Cart)session.getAttribute("cart");
	Float priceOfCart = cart.getTotalPrice();
	Float inAppCurrency = (Float)session.getAttribute("inAppCurrency");
	inAppCurrency = inAppCurrency - priceOfCart;
	session.setAttribute("inAppCurrency",inAppCurrency);
	

	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	int storeID = msql.getStoreId(store);
	int shopperID = msql.getShopperFromInterval(interval, storeID);
	msql.setInAppCurrency(loggedInUserID, inAppCurrency);
	
	//Set the shopper to occupied
	msql.setShopperToOccupied(shopperID);
	int intervalID = msql.getIntervalID(interval, storeID, shopperID);

	//Add the order to the database and remove the interval from availableIntervals
	msql.addOrder(loggedInUserID, shopperID, storeID, intervalID);
	msql.setIntervalToCompleted(intervalID);
	
	msql.stop();
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../css/CustomerConfirmation.css" /> 
		<title>Customer Confirmation</title>
		<script src="../js/WebSocketEndpoint.js" type="text/javascript"></script>
		<script src="../js/Feedback.js" type="text/javascript"></script>
	</head>
	<body>
		<div>
    		<form method="POST" id="feedback" action="../Feedback">
    			<input type=checkbox id="deliveryConfirmation1" name="hasReceived">
    			<label id = "deliveryid" for="deliveryConfirmation1" ><span></span>I have received my order
    				<img class = "iconimg" src="../images/happy.png" /></br>
    			</label>
    			<input type=checkbox id="deliveryConfirmation2" name="hasNotReceived">
    			<label id = "deliveryid" for="deliveryConfirmation2" ><span></span>I have not received my order 
    				<img class = "iconimg" src="../images/happy.png" /></br>
    			</label>
    			<textarea cols="50" rows="10" class="form-control" name="feedbackText" maxlength="250" id="feedbackText" placeholder = "We need your feedback! :)"></textarea>
    			<input class = "btn btn-lg btn-primary btn-block" type="submit" id="submitFeedback">
    			<input type="hidden" name="customerID" value="<%=loggedInUserID%>">
    			<input type="hidden" name="shopperID" value="<%=shopperID%>">
    		</form>
    	</div>
	</body>
</html>