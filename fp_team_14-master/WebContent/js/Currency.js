/*
* Queries the database for the current user's in app balance
*/
function getInAppCurrency ()
{
  //Also make a call to determine if the current user is a shopper or customer
  //If the current user is a shopper and occupied==true -> redirect to ShopperRoutePage
  return FirebaseDB.firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
      // get current user
      FirebaseDB.Customer.get(user.uid)
        .then(function(customer) {
          document.getElementById("inAppCurrency").innerHTML = "$" + customer.balance.toFixed(2);
        });
    }
    else {
      // no user is signed in
      console.log("Unfortunately, no user is signed in.");
    }
  });
}
