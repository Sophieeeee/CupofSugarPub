<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Route</title>
    <script src="../js/Map.js" type="text/javascript"></script>
    <script src="../js/Feedback.js" type="text/javascript"></script>
    <script src="../js/WebSocketEndpoint.js" type="text/javascript"></script>

    <!-- Sophie: you can move this into your css file / change it. It was the Google Maps default.  -->
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 50%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
    </style>
  </head>
  	<body>
  		<!-- <div id="headerbar">
			<h1 id="title">Cup Of Sugar</h1>
		</div>
		<div id="sidebar">
			<button id="profilePage"><img src="../images/profilePic.png" /></button>
			<h3 id = "inAppCurrency"></h3>
			<button id="logout"><img src="../images/logout.png" /></button>
		</div> -->
 
    	<div id="map"></div>
    	<div id="feedback">
    		
    		<form id="feedback" action="../jsp/CustomerHomepage.jsp">
    			<input type=checkbox id="deliveryConfirmation" name="hasDelivered">I have delivered my order </br>
    			<input type=checkbox id="deliveryConfirmation" name="hasNotDelivered" onclick="toggleDeliveryFeedback()">I was unable to deliver my order </br>
    			<input type=text style="visibility: hidden" id="hasNotDeliveredFeedback" value="Reason for unsuccessful delivery">
    			<br/>
    			<input type=text id="feedbackText" value="Feedback for customer">
    			<input type="submit" onclick="sendFeedbackToCustomer()" id="submitFeedback">
    		</form>
    	</div>
   
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbvgARfNVsUqNbvsmgK495M6vxq5JB4Wc&callback=initMap" type="text/javascript"></script>
	</body>
</html>