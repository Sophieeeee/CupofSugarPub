/**
 * Carts
 *
 * @author Eddo W. Hintoso
 * @since 04 April, 2017
 */

import { config } from './config';

import * as firebase from 'firebase';
import urljoin from 'url-join';


// [START Cart]
export class Cart {

  static get ref () {
    return firebase.database().ref().child('carts');
  }

  static get byUserRef () {
    return firebase.database().ref().child('userCarts');
  }

  /**
   * `items` is in the format:
   *
   *   {
   *     itemUUID: numAvailable >= 0,
   *     ...
   *   }
   *
   */
  static create (customerUUID, storeUUID, items) {
    let newCart = null;
    let newCartKey = Cart.ref.push();
    let newCartRef = Cart.ref.child(newCartKey);

    return newCartRef.set({
      customerUUID: customerUUID,
      storeUUID: storeUUID,
      items: items,
      checkedOut: false,
    })
    .then(() => {
      let userCartsRef = Cart.byUserRef.child(customerUUID);
      return userCartsRef.transaction(cartIds => {
        if (!cartIds) {
          cartIds = {
              checkedOut: [],
              inProgress: [],
            };
        }
        else {
          if (!cartIds.inProgress) {
            cartIds.inProgress = [];
          }
        }
        cartIds.inProgress.push(newCart.key);
        return cartIds;
      })
    })
    .then(() => {
      return newCartRef.once('value', snapshot => {
        newCart = snapshot.val();
      });
    })
    .then(() => {
      newCart.uid = newCartKey;
      return newCart;
    });
  }

  /**
   * Check out a customer's cart.
   *
   * Also removes the cart from user's carts that are in progress,
   * and move them to the list that stores UUIDs of checked-out carts.
   */
  static checkOut (cartUUID) {
    let cart = null;
    let userCarts = null;

    let cartRef = Cart.ref.child(cartUUID);
    return cartRef.child('checkedOut')
      .set(true)
      .then(() => {
        // guaranteed that cart is not null
        return Cart.get(cartUUID)
          .then(c => {
            cart = c;
          });
      })
      .then(() => {
        let customerUUID = cart.customerUUID;

        return Cart.getByUser(customerUUID)
          .then(carts => {
            console.log(carts);
            userCarts = carts;
          });
      })
      .then(() => {
        // remove element from inProgress
        let cartUUIDIndex = -1;

        cartUUIDIndex = userCarts.checkedOut.indexOf(cartUUID);
        if (cartUUIDIndex == -1) {
          // this is not found in `checkedOut`
          // and therefore we know we are not duplicating check outs
          cartUUIDIndex = userCarts.inProgress.indexOf(cartUUID);

          if (cartUUIDIndex != -1) {
            // if it is not found in either,
            // just don't do anything I suppose
            userCarts.inProgress.splice(cartUUIDIndex, 1);
            userCarts.checkedOut.push(cartUUID);

            // reset value
            Cart.byUserRef.child(customerUUID).set(userCarts);
          }
        }
      })
  }

  static clear () {
    Cart.ref.remove();
    Cart.byUserRef.remove();
  }

  static remove (cartUUID) {
    let userCarts = null;
    let customerUUID = "";

    let cartRef = Cart.ref.child(cartUUID);
    cartRef.once('value')
      .then(snapshot => {
        let ssv = snapshot.val();
        customerUUID = ssv.customerUUID;
      })
      .then(() => {
        return Cart.getByUser(customerUUID)
          .then(carts => {
            userCarts = carts;
          });
      })
      .then(() => {
        // remove element from either of the carts
        let cartUUIDIndex = -1;

        cartUUIDIndex = userCarts.checkedOut.indexOf(cartUUID);
        if (cartUUIDIndex != -1)
          userCarts.checkedOut.splice(cartUUIDIndex, 1);

        cartUUIDIndex = userCarts.inProgress.indexOf(cartUUID);
        if (cartUUIDIndex != -1)
          userCarts.inProgress.splice(cartUUIDIndex, 1);

        // reset value
        Cart.byUserRef.child(customerUUID).set(userCarts);
      })
      .then(() => {
        // safe to remove cart
        Cart.ref.child(cartUUID).remove()
      })
  }

  static get (cartUUID) {
    var cart = null;
    return Cart.ref.child(cartUUID)
      .once('value', snapshot => {
        cart = snapshot.val();
      })
      .then(() => {
        return cart;
      })
  }

  static getByUser (userUUID) {
    var userCarts = null;
    return Cart.byUserRef.child(userUUID)
      .once('value', snapshot => {
        let ssv = snapshot.val();
        if (ssv != null) {
          userCarts = {
            checkedOut: [],
            inProgress: [],
          }
          if ('checkedOut' in ssv)
            userCarts.checkedOut = ssv.checkedOut;
          if ('inProgress' in ssv)
            userCarts.inProgress = ssv.inProgress;
        }
      })
      .then(() => {
        return userCarts;
      })
  }

}
// [END Cart]

// Cart.clear();
let customerUUID = 'c0';
let storeUUID = 's0';
let items = {
  i1: 0,
  i2: 1,
  i3: 2,
}
// Cart.create(customerUUID, storeUUID, items);
// Cart.remove("-Kh4C8s5Ao0SAY_wYMO4");
// Cart.checkOut("-Kh4Dx2HdBU_al6PX-O3");
// Cart.get("-KgwfcQgmVJR4xcCQe64")
//   .then(cart => {
//     console.log(cart);
//   });
// Cart.getByUser("c1")
//   .then(carts => {
//     console.log(carts);
//   });
