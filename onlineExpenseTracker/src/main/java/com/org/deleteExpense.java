package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/deleteExpense")
public class deleteExpense extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the expenseId from the query parameter
        int expenseId = Integer.parseInt(request.getParameter("expenseId"));

        // Prepare the database connection and delete query
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");

            // SQL query to delete the expense
            String query = "DELETE FROM daily_expense WHERE expense_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, expenseId);

            int rowsAffected = ps.executeUpdate();

            // Check if deletion was successful
            if (rowsAffected > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("msg", "Expense deleted successfully!");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Failed to delete the expense. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Handle any exceptions and set an error message in the session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to the view.jsp page after the operation
        response.sendRedirect("view.jsp");
    }
}
