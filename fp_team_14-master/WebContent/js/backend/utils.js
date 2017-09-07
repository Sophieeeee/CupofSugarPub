/**
 * Utility functions.
 *
 * @author Eddo W. Hintoso
 * @since 04 April, 2017
 */

const nowUTC = () => {
  let now = new Date;
  return Date.UTC(
    now.getFullYear(),now.getMonth(), now.getDate() ,
    now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds()
  );
}

const isValidFirebaseKey = key => {
  let invalidKeys = new Set(
    ['', '$', '.', '#', '[', ']']
  );

  let valid = true;
  for (let c of key) {
    if (invalidKeys.has(c)) {
      valid = false;
      break;
    }
  }

  return valid;
}


// EXPORTS
export {
  nowUTC,
  isValidFirebaseKey,
}
