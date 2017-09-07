/**
 * Authentication functions.
 *
 * @author Eddo W. Hintoso
 * @since 04 April, 2017
 */

import { config, defaultValues } from './config';
import { nowUTC, isValidFirebaseKey } from './utils';
import { Cart } from './carts';

import * as firebase from 'firebase';


// [START User]
export class User {

  static get ref () {
    return firebase.database().ref().child('users');
  }

  static create (fname, lname, email, password, address, accountType) {
    return firebase.auth()
      .createUserWithEmailAndPassword(email, password)
      .then(() => {
        return new Promise((resolve, reject) => {
          firebase.auth().onAuthStateChanged(user => {
            if (user) {
              console.log("Registering user " + user.uid + " with email <" + email + ">....");
              User.ref.child(user.uid).set({
                  fname: fname,
                  lname: lname,
                  email: email,
                  accountType: accountType,
                  tsCreated: nowUTC(),
                  address: address,
                })
                .then(() => {
                  console.log("Registering user " + user.uid + " complete.");
                  resolve(user);
                });
            }
            else {
              // no user is signed in
              console.log("Unfortunately, no user is signed in.");
              reject();
            }
          });
        });
      });
  }

  /**
   * Sign in with email and password.
   */
  static signIn (email, password) {
    return firebase.auth().signInWithEmailAndPassword(email, password).then(() => {
      return new Promise((resolve, reject) => {
        firebase.auth().onAuthStateChanged(user => {
          if (user) {
            console.log("Successfully signed in user <" + user.uid + "> with email <" + email + ">.");
            resolve(user);
          }
          else {
            // no user is signed in
            console.log("Unfortunately, no user is signed in.");
            reject();
          }
        });
      });
    });
  }

  /**
   * Get the object associated with the users databse.
   *
   * Return `null` if no user by that UUID was found.
   */
  static get (uuid) {
    var user = null;
    return User.ref.child(uuid)
      .once('value', snapshot => {
        let snapshotValue = snapshot.val();
        if (snapshotValue != null)
          user = snapshotValue;
      })
      .then(() => {
        return user;
      })
  }

}
// [END User]


// [START Shopper]
export class Shopper extends User {

  static get accountType () {
    return "shopper";
  }

  static get ref () {
    return firebase.database().ref().child(Customer.accountType + "s");
  }


  static create (fname, lname, email, password, address, balance = defaultValues.shopperBalance) {
    return super.create(fname, lname, email, password, address, Shopper.accountType)
      .then(shopper => {
        console.log("Registering user " + shopper.uid + " with email <" + email + "> as " + Shopper.accountType + "...");
        return Shopper.ref.child(shopper.uid).set({
          balance: balance,
          numOrders: 0,
          occupied: false,
        })
        .then(() => {
          console.log("Successfully registered " + Shopper.accountType + " <" + shopper.uid + "> as " + Shopper.accountType + ".");
        });
      });
  }

  static get (uuid) {
    let shopper = null;
    return User.get(uuid)
      .then(user => {
        return Shopper.ref.child(uuid).once('value', snapshot => {
          let shopperQuery = snapshot.val();
          if (shopperQuery != null) {
            user.occupied = shopperQuery.occupied;
            user.balance = shopperQuery.balance;
            user.numOrders = shopperQuery.numOrders;
          }
          shopper = user;
        });
      })
      .then(() => {
        if (shopper.accountType != Shopper.accountType)
          shopper = null;
        return shopper;
      });
  }

}
// [END Shopper]


// [START Customer]
export class Customer extends User {

  static get accountType () {
    return "customer";
  }

  static get ref () {
    return firebase.database().ref().child(Customer.accountType + "s");
  }

  static create (fname, lname, email, password, address, balance = defaultValues.customerBalance) {
    return super.create(fname, lname, email, password, address, Customer.accountType)
      .then(customer => {
        console.log("Registering user " + customer.uid + " with email <" + email + "> as " + Customer.accountType + "...");
        return Customer.ref.child(customer.uid).set({
          balance: balance,
          numOrders: 0,
        })
        .then(() => {
          console.log("Successfully registered " + Customer.accountType + " <" + customer.uid + "> as " + Customer.accountType + ".");
        });
      });
  }

  static get (uuid) {
    let customer = null;
    return User.get(uuid)
      .then(user => {
        return Customer.ref.child(uuid).once('value', snapshot => {
          let customerQuery = snapshot.val();
          if (customerQuery != null) {
            user.balance = customerQuery.balance;
            user.numOrders = customerQuery.numOrders;
          }
          customer = user;
        });
      })
      .then(() => {
        if (customer.accountType != Customer.accountType)
          customer = null;
        return customer;
      });
  }

  static getCarts (uuid) {
    return Cart.getByUser(uuid);
  }

}
// [END Customer]


// User.signIn("john.doe@firebase.com", "firebase-is-awesome")
//   .then(() => {
//     console.log(firebase.auth().currentUser.uid);
//   });

// let name = "John Doe";
// let email = "john.doe@firebase.com";
// let password = "firebase-is-awesome";
// let balance = 0;
// Shopper.create(name, email, password, 0);

// User.get("ppvMdSFnmCMrJirRW7gyr0WXmKU2")
//   .then(user => {
//     console.log(user);
//   })

// Shopper.get("ppvMdSFnmCMrJirRW7gyr0WXmKU2")
//   .then(shopper => {
//     console.log(shopper);
//   })
//   .then(() => {
//     Customer.get("ppvMdSFnmCMrJirRW7gyr0WXmKU2")
//       .then(shopper => {
//         console.log(shopper);
//       })
//   });

// let fname = "Maya";
// let lname = "Ram";
// let email = "mayaram@usc.edu";
// let password = "00000000";
// let address = "3025 Royal Street, Los Angeles, CA 90007";
// Customer.create(fname, lname, email, password, address)
//   .then(() => {
//     console.log("I end here!");
//   })
