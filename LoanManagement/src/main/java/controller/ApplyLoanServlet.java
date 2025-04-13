package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanApplication;

import java.io.IOException;

import dao.LoanDAO;

/**
 * Servlet implementation class ApplyLoanServlet
 */
@WebServlet("/apply")
public class ApplyLoanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplyLoanServlet() {
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
		// TODO Auto-generated method stub
		LoanApplication loan = new LoanApplication();
        loan.setFirstName(request.getParameter("firstName"));
        loan.setLastName(request.getParameter("lastName"));
        loan.setEmail(request.getParameter("email"));
        loan.setPhone(request.getParameter("phone"));
        loan.setDob(request.getParameter("dob"));
        loan.setAadhar(request.getParameter("aadhar"));
        loan.setPan(request.getParameter("pan"));
        loan.setLoanType(request.getParameter("loanType"));
        loan.setAmount(Double.parseDouble(request.getParameter("amount")));
        loan.setDuration(Integer.parseInt(request.getParameter("duration")));

        int applicationId =  new LoanDAO().insertLoanApplication(loan);

        request.setAttribute("applicationId", applicationId);
        request.setAttribute("status", "Pending");
        request.getRequestDispatcher("success.jsp").forward(request, response);
	}

}
