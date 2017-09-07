<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Queries the firebase for all the available items at a given store and displays them -->
<!-- When the user selects an item, add them to a cart on the backend. Allows user to cancel. -->
<!-- On confirm, move to Checkout page. -->
<%@ page import="store.Item"  %>
<%@ page import="user.Cart"  %>
<%@ page import="database.MySQLDriver"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%
	String store = (String)session.getAttribute("store");
	//Getting the map of categories to items from the database
	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	Map<String, ArrayList<Item>> items = msql.getCategoriesToItems(store);
	String storeImage = msql.getStoreImage(store);
	msql.stop();
	
	//setting the map to the session
	session.setAttribute("categoryToItems",items);
	
	//Create a cart object for the customer
	Cart cart = new Cart();
	session.setAttribute("cart",cart);
		
	
%>
<html>
	<head>

		<title>Items</title>
		<link rel="stylesheet" type="text/css" href="../css/Items.css" /> 
		<script src="../js/WebSocketEndpoint.js" type="text/javascript"></script>
		<script src="../js/StoreList.js" type="text/javascript"></script>
		<script src="../js/Cart.js" type="text/javascript"></script>
	</head>
	<body>
		<div id="headerbar">
			<h1 id="title">
				<img src="../images/Cuposugar.png" />
			</h1>
		</div>
		<img id="storeLogo" src="<%=storeImage%>" />
		<!-- Look at displayItems, which sets the innerHTMl of itemsList by forwarding to ItemsHelper.jsp -->
		<%for(String category : items.keySet()){ %>
		<div id="category">
			<%=category %>
		</div>
		<div id="section">
		  <div class="items-container">
		    <div class="items-row">
		    	<%for(int i=0; i<items.get(category).size(); i++){ 
					Item item = items.get(category).get(i);
				%>
				<img class="itemImage" src="<%=item.getImage()%>" id="itemImage">
				<!-- Don't change the id of this input field -->
		     	<%} %>
		    </div>
		     <div class="quantity-row">
		    	<%for(int i=0; i<items.get(category).size(); i++){ 
					Item item = items.get(category).get(i);
				%>
				<input class="quantity" id="itemID<%=item.getItemID()%>" type="number" min="0" max="10" oninput="addItemToCart(<%=item.getItemID()%>,'<%=item.getPrice()%>')">
		     	<%} %>
		    </div>
		  </div>
		</div>​
		<%} %>
		<button class="btn btn-lg btn-primary btn-block" type="button" id="checkout" onclick="checkoutOrder()">Checkout</button>
		<button class="btn btn-lg btn-primary btn-block" type="button" id="cancel" onclick="cancelOrder()">Cancel</button>
		<div id="totalPrice">$0.00</div>
		
		
	</body>
</html>