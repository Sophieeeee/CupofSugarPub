/**
 * Configuration constants.
 *
 * @author Eddo W. Hintoso
 * @since 04 April, 2017
 */

import * as firebase from "firebase";


const config = {
  apiKey: "AIzaSyBdtu5ms82r89YG8QjHdsgqpLQfzLfjwjk",
  authDomain: "buymefood-dev-demo.firebaseapp.com",
  databaseURL: "https://buymefood-dev-demo.firebaseio.com",
  projectId: "buymefood-dev-demo",
  storageBucket: "buymefood-dev-demo.appspot.com",
  messagingSenderId: "856929363748"
};
firebase.initializeApp(config);

const defaultValues = {
  shopperBalance: 10.0,
  customerBalance: 20.0,
}


// EXPORTS
export {
  config,
  defaultValues,
};
