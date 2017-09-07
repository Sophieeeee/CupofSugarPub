// Initialize variables
var intervalNumber = -1;
var stores = null;
var times;
var selectedStore;
var selectedTime;
var typeOfUser;

/**
 * Get the list of stores for the specified category.
 */
function getListOfStores (category, userType)
{
  // First connect to the server so multiple clients can be on this page at once
  connectToServer();

  // Save the type of User
  typeOfUser = userType;
  // Get the stores from a firebase call depending on the category
  return FirebaseDB.Store.getByCategory(category)
    .then(function(storesQuery) {
      stores = storesQuery;
    })
    .then(function() {
      var storeNames = [];
      for (var i = 0; i < stores.length; i++) {
        var store = stores[i];
        storeNames.push(store.name);
      }
      console.log("Store names: " + storeNames);
      // Send the stores to a jsp to render the innerHTML
      var xhttp = new XMLHttpRequest();
      xhttp.open("GET", "StoreListHelper.jsp?stores="+storeNames, false);
      xhttp.send();
      document.getElementById("storeList").innerHTML = xhttp.responseText;
    });
}

/**
  * Get the available time intervals for the specified store
  */
function getAvailableIntervals ()
{
  // Save which store is selected
  selectedStore = document.getElementById("storeListDropdown")
    .options[document.getElementById("storeListDropdown").selectedIndex]
    .text;

  // Get the available times for the store from a firebase call
  if (selectedStore == "Ralph's") {
    times = [1,2,3,4];
  }
  else if (selectedStore == "Vons") {
    times = [1,2,3];
  }

  // Make the Http request to the jsp to load availableTimes
  var xhttp = new XMLHttpRequest();
  xhttp.open("GET", "StoreListTimeHelper.jsp?times="+times+"&typeOfUser="+typeOfUser, false);
  xhttp.send();

  // Change the innerHTML
  document.getElementById("availableIntervals").innerHTML = xhttp.responseText;
}

/**
 * Stores the interval that the customer has chosen.
 */
function storeInterval (value)
{
  intervalNumber = value;
}

/**
  * Update firebase with which interval customer picked to dynamically change other clients' webpage
  */
function validateInterval ()
{
  // Default if they hit submit before picking an option
  if (intervalNumber == -1) {
    document.getElementById("Status").innerHTML = "You must select an interval <br/>";
    return false;
  }
  else {
    console.log(intervalNumber);
    //First change the status of the chosen interval to pending
    socket.send(
      JSON.stringify({
        action: 'RemoveInterval',
        intervalNumber: self.intervalNumber,
        selectedStore: self.selectedStore,
        typeOfUser: self.typeOfUser,
      })
    );
    return true;
  }
  // would have to change the database
}

/**
 * Stores the time that the shopper is available for
 */
function storeShopperTime ()
{
  // Save the time the shopper selected 
  selectedTime = document
    .getElementById("timeOptionsDropdown")
    .options[document.getElementById("timeOptionsDropdown").selectedIndex]
    .text;
}

/**
 * Send the interval that the shopper picked to firebase and update the customers' webpage
 */
function sendIntervalToFB ()
{
  socket.send(
      JSON.stringify({
      action: 'AddInterval',
      selectedTime: self.selectedTime,
      selectedStore: self.selectedStore,
      typeOfUser: self.typeOfUser
    })
  );
}
