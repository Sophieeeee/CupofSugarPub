/**
 * Itmes.
 *
 * @author Eddo W. Hintoso
 * @since 10 April, 2017
 */

import { config } from './config';

import * as firebase from 'firebase';


// [START Item]
export class Item {

  static get ref () {
    return firebase.database().ref().child('items');
  }

  static get byCategoryRef () {
    return firebase.database().ref().child('itemsByCategory');
  }

  static create (name, category) {
    let newItem = null;
    let newItemKey = Item.ref.push().key;
    let newItemRef = Item.ref.child(newItemKey);

    return newItemRef.set({
      name: name,
      category: category,
    })
    .then(() => {
      let categoryRef = Item.byCategoryRef.child(category);
      return categoryRef.transaction(itemIds => {
        if (!itemIds)
          itemIds = []
        itemIds.push(newItemKey);
        return itemIds;
      });
    })
    .then(() => {
      return newItemRef.once('value', snapshot => {
        newItem = snapshot.val();
      });
    })
    .then(() => {
      newItem.uid = newItemKey;
      return newItem;
    })

  }

  static clear () {
    return Item.ref.remove()
      .then(() => {
        return Item.byCategoryRef.remove();
      })
  }

}
