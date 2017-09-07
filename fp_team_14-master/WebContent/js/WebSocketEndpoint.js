var socket;

function connectToServer() {
	socket = new WebSocket("ws://localhost:8080/fp_team_14/cupofsugar"); 
	
	socket.onopen = function(event) {
		console.log("Connecting");
		document.getElementById("Status").innerHTML = "Connecting...<br/>";
	}
	
	socket.onmessage = function(event) {
		//Get the message sent to the socket
		var msg = JSON.parse(event.data);
		
		//If the message is to remove the intervals, change intervals on firebase and update frontend
		if(msg.action=='RemoveInterval'){
			//Only update the jsp for those who are looking at the same store currently
			var currentStore = document.getElementById("storeListDropdown").options[document.getElementById("storeListDropdown").selectedIndex].text;
			if(currentStore == msg.selectedStore){
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "StoreListTimeHelper.jsp?times=1&typeOfUser="+msg.typeOfUser,false);
				xhttp.send();
				document.getElementById("availableIntervals").innerHTML = xhttp.responseText;
			}
		}
		//If message is to add the intervals, change interval on firebase and update the frontend
		else if(msg.action=='AddInterval'){
			alert("type of user = "+msg.typeOfUser);
			//Only update the jsp for customers who are looking at the same store currently
			var currentStore = document.getElementById("storeListDropdown").options[document.getElementById("storeListDropdown").selectedIndex].text;
			if(currentStore == msg.selectedStore && typeOfUser=="customer"){
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "StoreListTimeHelper.jsp?times="+msg.selectedTime+"&typeOfUser=customer",false);
				xhttp.send();
				document.getElementById("availableIntervals").innerHTML = xhttp.responseText;
			}
		}
		return true;
	}
	
	socket.onclose = function(event) {
		console.log("Closing");
	}	
}



