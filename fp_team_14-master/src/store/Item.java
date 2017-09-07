package store;

public class Item {
	private String name;
	private int quantity;
	private float price;

	public Item(String n, float p) {
		name = n;
		price = p;
	}

	public String getName() {
		return name;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

}
