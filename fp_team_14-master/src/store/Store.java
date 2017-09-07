package store;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import user.Shopper;

public class Store {

	private String name;
	private String address;
	private String category;
	private List<Item> availableItems;
	// int ranges from 0-24 for the hour that the shopper is available
	private Map<Integer, List<Shopper>> availability;

	public Store(String name, String address, String category, List<Item> items) {
		availability = new HashMap<Integer, List<Shopper>>();

		this.name = name;
		this.address = address;
		this.category = category;
		this.availableItems = items;
	}

	// Getters and Setters
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public List<Item> getAvailableItems() {
		return availableItems;
	}

	public void setAvailableItems(List<Item> availableItems) {
		this.availableItems = availableItems;
	}

	public Map<Integer, List<Shopper>> getAvailability() {
		return availability;
	}

	public void setAvailability(Map<Integer, List<Shopper>> availability) {
		this.availability = availability;
	}

	// Add a shopper to the available timeframes
	public void addShopper(Integer timeframe, Shopper shopper) {
		// if timeframe doesn't exist, add it in and initialize List of shoppers
		if (!availability.containsKey(timeframe)) {
			List<Shopper> temp = new ArrayList<Shopper>();
			temp.add(shopper);
			availability.put(timeframe, temp);
		} else {
			// Add the shopper to the timeframe
			availability.get(timeframe).add(shopper);
		}
	}

}
