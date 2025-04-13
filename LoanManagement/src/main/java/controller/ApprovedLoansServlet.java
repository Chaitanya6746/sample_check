package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.LoanApplication;

import java.io.IOException;
import java.util.List;

import dao.LoanDAO;

/**
 * Servlet implementation class ApprovedLoansServlet
 */
@WebServlet("/approvedLoans")
public class ApprovedLoansServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApprovedLoansServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<LoanApplication> loans = new LoanDAO().getApprovedLoans();
        for (LoanApplication loan : loans) {
           // double emi = LoanUtils.calculateEMI(loan.getAmount(), loan.getDuration());
            loan.setEmi(20);
        }
        request.setAttribute("loans", loans);
        request.getRequestDispatcher("approvedLoans.jsp").forward(request, response);
    }	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
