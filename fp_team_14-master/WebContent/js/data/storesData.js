/**
 * Data for stores.
 */

const stores = [
  // RALPH'S
  {
    name: "Ralph's",
    address: "2600 S Vermont. Ave, Los Angeles, CA 90007",
    categories: [
      "grocery",
      "health",
      "convenience",
      "clothing",
    ],
    items: {
      "apples": {
        price: 2.50,
        stock: 10,
      },
    },
  },

  // VONS
  {
    name: "Vons",
    address: "3461 W 3rd St, Los Angeles, CA 90020",
    categories: [
      "grocery",
      "convenience",
    ],
    items: {
      "bread": {
        price: 2.00,
        stock: 2,
      },
    }
  },
];

export default stores;
