package user;

import java.util.UUID;

public abstract class User {
	private String username;
	private String fname;
	private String lname;
	private UUID uuid;
	private String password;
	private String email;
	private float accountBalance;

	// Only called when we have already verified that the user exists
	public User() {

	}

	public User(String username, String fname, String lname, String password, String email) {
		/**
		 * if(the username exists in the database) Pull and set all fields from
		 * database
		 */
		this.username = username;
		this.fname = fname;
		this.lname = lname;
		this.password = password;
		this.email = email;

	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public UUID getUuid() {
		return uuid;
	}

	public void setUuid(UUID uuid) {
		this.uuid = uuid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public float getAccountBalance() {
		return accountBalance;
	}

	public void setAccountBalance(float accountBalance) {
		this.accountBalance = accountBalance;
	}

}
