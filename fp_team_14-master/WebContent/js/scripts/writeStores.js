/**
 *
 */

import stores from '../data/storesData';
import items from '../data/itemsData';

import { Item } from '../backend/items';
import { Store } from '../backend/stores';

// First, create the items
let itemCreationPromises = [
  Item.clear(),
];
// map item names to UUIDs
let itemMap = {};
for (let item of items) {
  let p = Item.create(item.name, item.category)
    .then(item => {
      itemMap[item.name] = item.uid;
    })
  itemCreationPromises.push(p);
}

Promise.all(itemCreationPromises)
  .then(() => {
    console.log("Created all items!");

    // create the stores
    let storeCreationPromises = [
      Store.clear(),
    ];

    for (let store of stores) {
      for (let itemName in store.items) {
        // replace name with IDs
        store.items[itemMap[itemName]] = store.items[itemName];
        delete store.items[itemName];
      }
      let p = Store.create(store.name, store.address, store.categories, store.items);
      storeCreationPromises.push(p);
    }

    return Promise.all(storeCreationPromises);
  })
  .then(() => {
    console.log("Created all stores!");
  });
