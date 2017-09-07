package user;

import java.util.UUID;

public class Order {
	private Cart cart;
	private UUID uuid;
	private Customer customer;
	private Shopper shopper;
	private String status;
	// date created
	// date completed
	// ETA
	private String destination;

	public Order(Cart cart, Customer customer, Shopper shopper) {
		this.cart = cart;
		this.customer = customer;
		this.shopper = shopper;

	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public UUID getUuid() {
		return uuid;
	}

	public void setUuid(UUID uuid) {
		this.uuid = uuid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Shopper getShopper() {
		return shopper;
	}

	public void setShopper(Shopper shopper) {
		this.shopper = shopper;
	}

}
