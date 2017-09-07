<%@ page import="java.util.ArrayList"  %>
<%@ page import="user.Cart"  %>
<% 
	String store = (String)session.getAttribute("store");
	Integer quantity = Integer.parseInt(request.getParameter("quantity"));
	Integer itemID = Integer.parseInt(request.getParameter("itemID"));
	Float itemPrice = Float.parseFloat(request.getParameter("itemPrice")); 
	
	//Add it to the Java cart object 
	Cart cart = (Cart)session.getAttribute("cart");
	cart.addToCart(itemID, quantity, itemPrice);
%>