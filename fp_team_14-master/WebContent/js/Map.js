var storeLoc;
var customerLoc;
var shopperLoc;

/*
 * Needs to grab the store location and customer location from firebase.
 */
function getLocations() {
	console.log("here");
	shopperLoc = "3025 Royal Street, Los Angeles CA 90007";
	storeLoc = "26 S, Vermont Ave, Los Angeles CA 90007";
	customerLoc = "3335, South, Figueroa Street, Los, Angeles, CA, 90007";

}
function initMap() {
	var directionsService = new google.maps.DirectionsService;
	var directionsDisplay = new google.maps.DirectionsRenderer;
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 7,
		center: {lat: 34.02, lng: -118.29}
	});
	directionsDisplay.setMap(map);
	calculateAndDisplayRoute(directionsService, directionsDisplay);
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
	getLocations();
	waypts = [];
	waypts.push({location: storeLoc, stopover:true});
	directionsService.route({
		origin: shopperLoc,
		destination: customerLoc,
		waypoints: waypts,
		travelMode: 'DRIVING'
	}, function(response, status) {
		if (status === 'OK') {
			directionsDisplay.setDirections(response);
			console.log(directionsDisplay.directions.routes[0].legs[0].duration.text);
			console.log(directionsDisplay.directions.routes[0].legs[1].duration.text);
			var travelTime = 0.0;
			travelTime += parseFloat(directionsDisplay.directions.routes[0].legs[0].duration.text);
			travelTime += parseFloat(directionsDisplay.directions.routes[0].legs[1].duration.text);
			document.getElementById("travelTime").innerHTML = "Travel time: " + travelTime + " mins";
		} else {
			window.alert('Directions request failed due to ' + status);
		}
	});
}
