package user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import store.Item;

public class Cart {
	private int intervalID;
	private int customerID;
	private Map<Integer, Integer> itemQuantities = new HashMap<>();
	private Map<Integer, Float> itemToUnitPrice = new HashMap<>();
	private float totalPrice;

	public Cart() {
		totalPrice = 0;
	}

	public void addToCart(int itemID, int quantity, float unitPrice) {
		itemQuantities.put(itemID, quantity);
		itemToUnitPrice.put(itemID, unitPrice);
	}
	
	public float getPriceFromID(int itemID){
		if(itemToUnitPrice.containsKey(itemID)){
			return itemToUnitPrice.get(itemID);
		}
		return -1;
	}

	public float getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(float totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Map<Integer, Integer> getItemQuantities() {
		return itemQuantities;
	}
}
