/**
 * Queries firebase for all of the items in a given store.
 */
function getAvailableItems(store) {
	var items = ["Apple", "Banana", "Cherries"];
	var prices = [1, 2, 3];
	displayItems(items, store, prices);
}

/**
 *  Changes the innerHTML of itemsList to display all of the items
 */
function displayItems(items, store, prices) {
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "ItemsHelper.jsp?items="+items+"&store="+store+"&prices="+prices, false);
	xhttp.send();
	if (xhttp.responseText.trim().length > 0) {
		document.getElementById("itemsList").innerHTML = xhttp.responseText;
	}
}

/**
 * Updates the price dynamically when clicked.
 * Should query the JSON object or database or something for
 * the price associated with itemName.
 */
function changeTotalPrice(itemName, itemPriceTemp) {
	var newTotal = 0.00;
	var itemPrice = 0.00;
	itemPrice += parseFloat(itemPriceTemp);
	var oldPrice = document.getElementById("totalPrice").innerHTML;
	newTotal += parseFloat(oldPrice.substr(1, oldPrice.length));
	newTotal += itemPrice;
	document.getElementById("totalPrice").innerHTML = "$" + newTotal;
}

/**
 * Given the customer UUID, queries the database to find
 * the shopper and change their status to available.
 */

function cancelOrder() {
	window.location.href = '../jsp/CustomerHomepage.jsp';

}

/**
 * Should put the details of the cart in firebase
 */
function confirmOrder() {

}
