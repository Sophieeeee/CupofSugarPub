package servlets;

import java.io.IOException;
import java.text.NumberFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.MySQLDriver;

/**
 * Servlet implementation class EntryConfirmation
 */
@WebServlet("/EntryConfirmation")
public class EntryConfirmation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EntryConfirmation() {
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
		String email = request.getParameter("email");
		msql.connect();

		//Get userID
		int loggedInUserID = msql.getUserID(email);
		session.setAttribute("loggedInUserID", loggedInUserID);

		//Get typeOfUser
		String typeOfUser = msql.getUserColumn(loggedInUserID, "typeOfUser");
		session.setAttribute("typeOfUser", typeOfUser);

		//Get shopperStatus
		String shopperStatus = msql.getUserColumn(loggedInUserID,"shopperStatus");
		
		//Get inAppCurrency
		float inAppCurrency = msql.getInAppCurrency(loggedInUserID);
		NumberFormat formatter = NumberFormat.getCurrencyInstance();
		String moneyString = formatter.format(inAppCurrency);
		session.setAttribute("inAppCurrency", inAppCurrency);
		session.setAttribute("inAppString", moneyString);
		msql.stop();

		// Redirect to the appropriate page
		if(shopperStatus.equals("occupied")){
			response.sendRedirect(request.getContextPath() + "/jsp/ShopperRoutePage.jsp");
		}else{
			response.sendRedirect(request.getContextPath() + "/jsp/CustomerHomepage.jsp");
		}
	}

}
