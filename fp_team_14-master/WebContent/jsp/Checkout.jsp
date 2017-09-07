<!-- Displays the cart created in Items.jsp.
On cancel, should loop to Customer Homepage. On confirm, should:
(1) write the cart to firebase (2) Notify shopper and provide them with a route. 
(3) deduct total price of cart from the in-app balance.  -->
 <%@ page import="user.Cart"  %>
 <%@ page import="store.Item"  %>
 <%@ page import="java.util.Map"  %>
 <%@ page import="java.text.NumberFormat"  %>
 <%@ page import="database.MySQLDriver"  %>

<%
	Integer loggedInUserID = (Integer) session.getAttribute("loggedInUserID");
	Float inAppCurrency = (Float) session.getAttribute("inAppCurrency");

	Cart cart = (Cart) request.getSession().getAttribute("cart");
	String store = (String) request.getSession().getAttribute("store");
	Map<Integer, Integer> numQuantities = cart.getItemQuantities();
	MySQLDriver msql = new MySQLDriver();
	msql.connect();
	String storeImage = msql.getStoreImage(store);

	//Get total price
	Float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
	cart.setTotalPrice(totalPrice);
	String totalPriceString = NumberFormat.getCurrencyInstance().format(totalPrice);
%>
<html>
	<head>
		<title>Checkout</title>
		<script src="../js/Cart.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/Checkout.css" /> 
	</head>
	<body>
		<div id="headerbar">
			<h1 id="title">
				<img src="../images/Cuposugar.png" />
			</h1>
		</div>
		<div class="shadow">
			<img id="storeLogo" src="<%=storeImage%>" />
			<!-- Need to put delivery time in here -->
			<h2> Order: </h2>
			<table class="orderTable">
			<%for (Map.Entry<Integer, Integer> cartItems : numQuantities.entrySet()) {
			    int itemID = cartItems.getKey();
			    int itemQuantity = cartItems.getValue();
			    String itemName = msql.getItemNameFromID(itemID);
			    float itemPrice = cart.getPriceFromID(itemID);
			    float subTotalItem = itemPrice*itemQuantity;
			    String subTotalString = NumberFormat.getCurrencyInstance().format(subTotalItem);
			    
			 %>
				<tr class="orderRow">
					<td class="orderColumn"><%=itemName%></td>
					<td class="orderColumn-1"><%=itemQuantity%> x $<%=itemPrice%></td>
					<td class="orderColumn-1"><%=subTotalString%></td>
				</tr>
			<%} %>
			</table>
			<h3>Total: </h3>
			<%=totalPriceString %> <br/>
			<button type=button id="confirmOrder" onclick="confirmOrder(<%=loggedInUserID%>, <%=inAppCurrency%>, <%=totalPrice%>)">Confirm</button>
			<button type=button id="cancelOrder" onclick = "cancelOrder()">Cancel</button>
			<div id="error"></div>
			<div id = "signUpGuest">
				<button type=button id='signUpGuestButton' onclick = "location.href='SignUp.jsp'" style = "visibility: hidden">Sign Up Now!</button>
			</div>
			<div id = "backToItems">
				<button type=button id='backToItemsButton' onclick = "location.href='Items.jsp'" style = "visibility: hidden">Update Cart</button>
			</div>
		</div>
	</body>
</html>
<%msql.stop();%>