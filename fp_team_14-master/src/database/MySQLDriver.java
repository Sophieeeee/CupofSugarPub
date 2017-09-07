package database;

import java.io.BufferedReader; 
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import store.Item;

public class MySQLDriver {
	
	private Connection conn;
	
	private String buildPath;
	
	//Add and select statements for the user
	private final static String addUser = "INSERT INTO USERS(email,password,fname,lname,accountBalance,address,typeOfUser,shopperStatus) VALUES(?,?,?,?,?,?,?,?)";
	private final static String selectUser = "SELECT * FROM USERS WHERE email=?";
	private final static String selectUserID = "SELECT uuid FROM USERS WHERE email=?";
	
	private final static String updateMovieRating = "UPDATE MOVIES SET ratingCinemate=?, numRating=? WHERE imdbID=?";
	private final static String updateProduct = "UPDATE FACTORYORDERS SET CREATED = ? WHERE NAME = ?";
	
	//Constructor
	public MySQLDriver(){
		try{
			new com.mysql.jdbc.Driver();
			//Create the buildpath with what was given
			buildPath = "jdbc:mysql://localhost:3306/cupOfSugar?user=root&password=root&useSSL=false";
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	//Connect to the database
	public void connect(){
		try{
			//Jdbc:mysql://localhost:3306 specifies the MySQL server we are connecting to
			//'cupOfSugar' indicates factory schema
			conn = DriverManager.getConnection(buildPath);
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	/**Methods for the User**/
	//Adds user to the database
	public void addUser(String email, String password,String fname, String lname, String address, String typeOfUser){
		try{
			PreparedStatement ps = conn.prepareStatement(addUser);
			ps.setString(1, email);
			ps.setString(2, password);
			ps.setString(3, fname);
			ps.setString(4, lname);
			ps.setString(6, address);
			System.out.println(address);
			ps.setString(7, typeOfUser);
			if(typeOfUser.equals("shopper")){
				ps.setString(8, "available");
				ps.setFloat(5, 10);
			}else{
				ps.setString(8, "customer");
				ps.setFloat(5, 20);
			}
			ps.executeUpdate();
			System.out.println("Adding user: "+email);
		}
		catch(SQLException e){
			e.printStackTrace();
		}
	}
	public boolean userExists(String email){
		try{
			PreparedStatement ps = conn.prepareStatement(selectUser);
			ps.setString(1, email);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				return true;
			} else{
				return false;
			}
		} catch (SQLException sqe){
			return false;
		}
	}
	//Gets the user id
	public int getUserID(String email){
		try{
			PreparedStatement ps = conn.prepareStatement(selectUserID);
			//sets ? from selectName to productName
			ps.setString(1, email);
			ResultSet result = ps.executeQuery();
			result.next();
			return result.getInt(1);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return -1;
	}
	//Gets other fields of the specified user
	public String getUserColumn(int userID, String columnName){
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT "+columnName+" FROM USERS WHERE uuid=?");
			ps.setInt(1, userID);
			ResultSet result = ps.executeQuery();
			result.next();
			System.out.println(columnName+" for "+userID+" is "+result.getString(1));
			return result.getString(1);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
	//Get the inAppCurrency
	public float getInAppCurrency(int userID){
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT accountBalance FROM USERS WHERE uuid=?");
			ps.setInt(1, userID);
			ResultSet result = ps.executeQuery();
			result.next();
			return result.getFloat(1);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return 0;
	}
	//Set the inAppCurrency
	public void setInAppCurrency(int userID, float inAppCurrency){
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE users SET accountBalance=? WHERE uuid=?");
			ps.setFloat(1, inAppCurrency);
			ps.setInt(2, userID);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//Make shopper available
	public void setShopperToAvailable(int shopperID){
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE users SET shopperStatus='available' WHERE uuid=?");
			ps.setInt(1, shopperID);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//Make shopper occupied
	public void setShopperToOccupied(int shopperID){
		try{
			PreparedStatement ps = conn.prepareStatement("UPDATE users SET shopperStatus='occupied' WHERE uuid=?");
			ps.setInt(1, shopperID);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	/**Methods for the stores**/
	public String getStore(int storeID){
		String store = "";
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT name FROM STORES WHERE uuid=?");
			ps.setInt(1, storeID);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				store=result.getString(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return store;
	}
	//Gets storeID based on the name
	public int getStoreId(String storeName){
		int store = -1;
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT uuid FROM STORES WHERE name=?");
			ps.setString(1, storeName);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				store=result.getInt(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return store;
	}
	public Map<String,ArrayList<Integer>> getStoreList(String category){
		Map<String, ArrayList<Integer>> storesToIntervals = new HashMap<>();
		ArrayList<Integer> storeIds = new ArrayList<>();
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT store FROM CATEGORIES WHERE category=?");
			ps.setString(1, category);
			ResultSet result = ps.executeQuery();
			//Go through stores of category and get available intervals
			while(result.next()){
				//Add store name and list of available intervals
				storesToIntervals.put(getStore(result.getInt(1)), getAvailableIntervals(result.getInt(1)));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return storesToIntervals;
	}
	public String getStoreImage(String storeName){
		String image = "";
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT image FROM STORES WHERE name=?");
			ps.setString(1, storeName);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				image=result.getString(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return image;
	}
	/**Store functions for Intervals**/
	//Gets the available intervals for 1 store
	public ArrayList<Integer> getAvailableIntervals(int storeId){
		ArrayList<Integer> availableIntervals = new ArrayList<>();
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM AVAILABLEINTERVALS WHERE store=?");
			ps.setInt(1, storeId);
			ResultSet result = ps.executeQuery();
			while(result.next()){
				//If the shopper is not occupied, add them to the available intervals
				if(result.getString(5).equals("available")){
						availableIntervals.add(result.getInt(4));
						System.out.println("Adding: "+result.getInt(4)+" to "+storeId);
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return availableIntervals;
	}
	
	//Adds a new interval to AvailableIntervals as available
	public void addInterval(int shopperID, String storeName, int interval) {
		String addIntervalQuery = "INSERT INTO AVAILABLEINTERVALS(shopper, store, timeInterval, intervalStatus) VALUES(?, ?, ?, ?);";
		try{
			PreparedStatement ps = conn.prepareStatement(addIntervalQuery);
			ps.setInt(1, shopperID);
			ps.setInt(2, getStoreId(storeName));
			ps.setInt(3,  interval);
			ps.setString(4, "available");
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//Changes the status of an existing interval to pending
	public void changeStatusOfInterval(String storeName, int interval) {
		String changeStatusOfIntervalQuery = "UPDATE AVAILABLEINTERVALS SET intervalStatus = 'pending' WHERE store=? AND timeInterval=?;";
		try{
			PreparedStatement ps = conn.prepareStatement(changeStatusOfIntervalQuery);
			ps.setInt(1, getStoreId(storeName));
			ps.setInt(2, interval);
			ps.executeUpdate();
			System.out.println("Changing interval: "+interval+" of store: "+storeName+" to pending.");
		}catch(SQLException e){
			e.printStackTrace();
		}
		
	}
	//Get the shopper from the interval and storeID and "pending" status
		public int getShopperFromInterval(int interval, int storeID){
			int shopperID = -1;
			try{
				PreparedStatement ps = conn.prepareStatement("SELECT shopper FROM AvailableIntervals WHERE store=? AND timeInterval=? AND intervalStatus='pending'");
				ps.setInt(1, storeID);
				ps.setInt(2, interval);
				ResultSet result = ps.executeQuery();
				if(result.next()){
					shopperID = result.getInt(1);
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			return shopperID;
		}
	//Get the interval id from the remaining fields
	public int getIntervalID(int interval, int storeID, int shopperID){
		System.out.println("interval: "+interval+" storeID: "+storeID+" shopperID: "+shopperID);
		int intervalID = -1;
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT uuid FROM AvailableIntervals WHERE store=? AND timeInterval=? AND intervalStatus='pending' AND shopper=?");
			ps.setInt(1, storeID);
			ps.setInt(2, interval);
			ps.setInt(3, shopperID);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				intervalID = result.getInt(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return intervalID;
	}
	//Set interval to completed when it has been chosen
	public void setIntervalToCompleted(int intervalID){
		String changeStatusOfIntervalQuery = "UPDATE AVAILABLEINTERVALS SET intervalStatus = 'completed' WHERE uuid=?;";
		try{
			PreparedStatement ps = conn.prepareStatement(changeStatusOfIntervalQuery);
			ps.setInt(1, intervalID);
			ps.executeUpdate();
			System.out.println("Changing interval: "+intervalID+" to completed.");
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	/**Store functions for items**/
	//Query StoresToItems for all items in a store
	public ArrayList<Item> getItemsFromStore(String store){
		ArrayList<Item> items = new ArrayList<>();
		int storeID = getStoreId(store);
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM StoreToItems WHERE storeID=?");
			ps.setInt(1, storeID);
			ResultSet result = ps.executeQuery();
			//Create an item and add to a list of items
			while(result.next()){
				Item item = new Item(result.getInt(3),result.getFloat(4));
				items.add(item);
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
		return items;
	}
	//Get item name from item ID
	public String getItemNameFromID(int itemID){
		String itemName = "";
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT itemName FROM Items WHERE uuid=?");
			ps.setInt(1, itemID);
			ResultSet result = ps.executeQuery();
			if(result.next()){
				itemName = result.getString(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return itemName;
	}
	
	//Get Map from category to list of items
	public Map<String, ArrayList<Item>> getCategoriesToItems(String store){
		Map<String, ArrayList<Item>> categoryToItems = new HashMap<>();
		//Get all the items in the store
		ArrayList<Item> items = getItemsFromStore(store);
		
		//Loop through all items and get name and category
		try{
			for(Item item : items){
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM Items WHERE uuid=?");
				ps.setInt(1, item.getItemID());
				ResultSet result = ps.executeQuery();
				if(result.next()){
					String itemName = result.getString(2);
					String category = result.getString(3);
					String img = result.getString(4);
					
					//Add the item name to the item
					item.setName(itemName);
					item.setImage(img);
					//If the category exists in the map, add the item to the list
					if(categoryToItems.containsKey(category)){
						categoryToItems.get(category).add(item);
					} 
					//Otherwise add the category and a new list to the map
					else{
						ArrayList<Item> temp = new ArrayList<>();
						temp.add(item);
						categoryToItems.put(category, temp);
					}
				}
			}
		}catch (SQLException e){
			e.printStackTrace();
		}
		return categoryToItems;
	}
	
	/**Functions for Orders**/
	
	//Insert into the orders table
	public void addOrder(int customerID, int shopperID, int storeID, int intervalID){
		try{
			PreparedStatement ps = conn.prepareStatement("INSERT INTO ConfirmedOrders(customer,shopper,store,chosenInterval,orderStatus) VALUES(?,?,?,?,?)");
			ps.setInt(1, customerID);
			ps.setInt(2, shopperID);
			ps.setInt(3, storeID);
			ps.setInt(4, intervalID);
			ps.setString(5, "In progress");
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//Get customerID from the order
	public int getCustomerIDFromOrder(int shopperID){
		int customerID = -1;
		try{
			PreparedStatement ps = conn.prepareStatement("SELECT customer FROM ConfirmedOrders WHERE shopper=? AND orderStatus='In progress'");
			ps.setInt(1, shopperID);
			ResultSet result = ps.executeQuery();
			//Create an item and add to a list of items
			if(result.next()){
				customerID = result.getInt(1);
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
		return customerID;
	}
	//Add feedback to the orders
	public void addFeedback(String feedback, int customerID, int shopperID, String typeOfUser){
		try{
			PreparedStatement ps;
			if(typeOfUser.equals("shopper")){
				ps = conn.prepareStatement("UPDATE ConfirmedOrders SET shopperOrderFeedback=? WHERE customer=? AND shopper=? AND orderStatus='In progress'");
			}else{
				ps = conn.prepareStatement("UPDATE ConfirmedOrders SET customerOrderFeedback=? WHERE customer=? AND shopper=? AND orderStatus='In progress'");
			}
			ps.setString(1, feedback);
			ps.setInt(2, customerID);
			ps.setInt(3, shopperID);
			ps.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//Set order to completed when it has been chosen
		public void setOrderToCompleted(int customerID, int shopperID){
			try{
				PreparedStatement ps = conn.prepareStatement("UPDATE ConfirmedOrders SET orderStatus='completed' WHERE customer=? AND shopper=? AND orderStatus='In progress'");
				ps.setInt(1, customerID);
				ps.setInt(2, shopperID);
				ps.executeUpdate();
				System.out.println("Changing order: to completed.");
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	
	public void stop(){
		try{
			conn.close();
			System.out.println("Closing connection...");
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
}

