package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import store.Item;
import user.Cart;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToCart() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		int numItems = Integer.parseInt(request.getParameter("numItems"));
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		for (int i = 0; i < numItems; i++) {
			String itemName = "";
			int itemPrice = -1;
			int itemQuantity = -1;
			if (!request.getParameter("itemName" + i).equals("null")) {
				itemName = request.getParameter("itemName" + i);
				if (request.getParameter(itemName + "quantity").length() > 0) {
					itemQuantity = Integer.parseInt(request.getParameter(itemName + "quantity"));
				}
			}
			if (!request.getParameter("itemPrice" + i).equals("null")) {
				itemPrice = Integer.parseInt(request.getParameter("itemPrice" + i));
			}

			System.out.println(itemName + ", $" + itemPrice + ", " + itemQuantity);
			if (itemName.length() == 0 || itemPrice == -1 || itemQuantity == -1) {
				System.out.println("not adding to cart");
			} else {
				Item item = new Item(itemName, itemPrice);
				cart.addToCart(item, itemQuantity);
			}

		}

		request.getSession().setAttribute("cart", cart);
		RequestDispatcher rd = request.getServletContext().getRequestDispatcher("/jsp/Checkout.jsp");
		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
