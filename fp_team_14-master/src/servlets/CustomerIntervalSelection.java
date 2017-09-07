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
 * Servlet implementation class CustomerIntervalSelection
 */
@WebServlet("/CustomerIntervalSelection")
public class CustomerIntervalSelection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerIntervalSelection() {
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
		int interval = Integer.parseInt(request.getParameter("interval"));
		String store = request.getParameter("store");

		//Set interval and store as a session attribute
		session.setAttribute("store", store);
		session.setAttribute("interval", interval);

		//update interval in the database
		msql.connect();
		msql.changeStatusOfInterval(store, interval);
		msql.stop();
		
		//Redirect the page to Items
		response.sendRedirect(request.getContextPath() + "/jsp/Items.jsp");
	}

}
