/*
 * Sends the message to the other person. Should check which checkbox is clicked and also send the messages.
 * Checkbox: getElementById("hasReceived") and "hasNotReceived"
 * Message: getElementById("feedbackText")
 */
function sendFeedbackToShopper() {

}

/*
 * Sends the message to the other person. Should check which checkbox is clicked and also send the messages.
 * Checkbox: getElementById("hasDelivered") and "hasNotDelivered"
 * Message: getElementById("feedbackText")
 */
function sendFeedbackToCustomer() {

}


function toggleDeliveryFeedback() {
	if(document.getElementById("hasNotDeliveredFeedback").style.visibility == "visible") {
		document.getElementById("hasNotDeliveredFeedback").style.visibility = "hidden";
	} else {
		document.getElementById("hasNotDeliveredFeedback").style.visibility = "visible";
	}
}
