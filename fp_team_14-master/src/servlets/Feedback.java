package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.MySQLDriver;

/**
 * Servlet implementation class Feedback
 */
@WebServlet("/Feedback")
public class Feedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Feedback() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Create an HttpSession:
		HttpSession session = request.getSession();

		//Get user database
		MySQLDriver msql = new MySQLDriver();
		String typeOfUser = (String)session.getAttribute("typeOfUser");
		String feedback = request.getParameter("feedbackText");
		Integer shopperID = Integer.parseInt(request.getParameter("shopperID"));
		Integer customerID = Integer.parseInt(request.getParameter("customerID"));
		msql.connect();
		msql.addFeedback(feedback, customerID, shopperID, typeOfUser);
		if(typeOfUser.equals("shopper")){
			msql.setShopperToAvailable(shopperID);
			msql.setOrderToCompleted(customerID, shopperID);
		}
		msql.stop();
		
		//Forward to the hompage
		response.sendRedirect(request.getContextPath() + "/jsp/CustomerHomepage.jsp");
	}

}
