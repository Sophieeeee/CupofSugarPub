/**
 * Stores
 *
 * @author Eddo W. Hintoso
 * @since 04 April, 2017
 */

import { config } from './config';

import * as firebase from 'firebase';


// [START Store]
export class Store {

  static get ref () {
    return firebase.database().ref().child('stores');
  }

  static get byCategoryRef () {
    return firebase.database().ref().child('storesByCategory');
  }

  /**
   * `items` is in the format:
   *
   *   {
   *     itemUUID: {
   *       price: >= 0.0,
   *       numAvailable: >= 0,
   *     },
   *     ...
   *   }
   *
   */
  static create (name, address, categories, items) {
    let newStore = null;
    let newStoreKey = Store.ref.push().key;
    let newStoreRef = Store.ref.child(newStoreKey);

    return newStoreRef.set({
      name: name,
      address: address,
      categories: categories,
      items: items,
    })
    .then(() => {
      for (let category of categories) {
        let categoryRef = Store.byCategoryRef.child(category);
        categoryRef.transaction(storeIds => {
          if (!storeIds)
            storeIds = [];
          storeIds.push(newStoreKey);
          return storeIds;
        });
      }
    })
    .then(() => {
      return newStoreRef.once('value', snapshot => {
        newStore = snapshot.val();
      });
    })
    .then(() => {
      newStore.uid = newStoreKey;
      return newStore;
    });
  }

  static clear () {
    return Store.ref.remove()
      .then(() => {
        return Store.byCategoryRef.remove();
      });
  }

  static remove (storeUUID) {
    let store = null;

    return Store.get(storeUUID)
      .then(s => {
        store = s;
      })
      .then(() => {
        // if stores is null, do absolutely nothing
        if ('categories' in store) {
          let promises = [];

          for (let category of categories) {
            // for each category, remove the storeUUID
            let categoryStores = null;
            let categoryRef = Store.byCategoryRef.child(category);

            let promise = Store.getByCategory(category)
              .then(stores => {
                categoryStores = stores;
              })
              .then(() => {
                // remove the storeUUID from the category
                let storeUUIDIndex = -1;
                storeUUIDIndex = categoryStores.indexOf(storeUUID);
                if (storeUUIDIndex != -1)
                  categoryStores.splice(storeUUIDIndex, 1);

                // reset value
                categoryRef.set(categoryStores);
              })
              .then(() => {
                categoryStores = [];
              })

            promises.push(promise);
          }

          // execute promises in order (serially)
          promises.reduce(
            (curr, next) => {
              return curr.then(next);
            },
            Promise.resolve()
          );
        }
      })
      .then(() => {
        // safe to remove store
        Store.ref.child(storeUUID).remove();
      })
  }

  static get (storeUUID) {
    var store = null;
    return Store.ref.child(storeUUID)
      .once('value', snapshot => {
        store = snapshot.val();
      })
      .then(() => {
        return store;
      })
  }

  /**
   * Returns a promise with all the stores
   * associated with the category.
   */
  static getByCategory (category) {
    let stores = [];
    let storeIds = null;
    let categoryRef = Store.byCategoryRef.child(category);

    return categoryRef.once('value', snapshot => {
      storeIds = snapshot.val();
    })
    .then(() => {
      let getStoresPromises = [];

      if (storeIds != null) {
        for (let sid of storeIds) {
          let p = Store.get(sid)
            .then(store => {
              store.uid = sid;
              stores.push(store);
            });
          getStoresPromises.push(p);
        }
      }

      return Promise.all(getStoresPromises)
    })
    .then(() => {
      return stores;
    });
  }

}
// [END Store]

// Store.clear();
// let store = stores[1];
// Store.create(store.name, store.address, store.categories, store.items);
// let promises = [];
// for (let store of stores) {
//   Store.create(store.name, store.address, store.categories, store.items);
// }
//
// // execute promises in order (serially)
// promises.reduce(
//   (curr, next) => {
//     return curr.then(next);
//   },
//   Promise.resolve()
// );
//
//
// Store.remove("-Kh4NTIDo4fYQmpNGgyn");
// Store.get("-Kh3XSp0zaUhDMcQK7l1")
//   .then(store => {
//     console.log(store);
//   });
//
// Store.getByCategory("beauty")
//   .then(stores => {
//     console.log(stores);
//   });
