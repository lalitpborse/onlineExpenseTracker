package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/updateExpense")
public class updateExpense extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve expense details from the form
        int expenseId = Integer.parseInt(request.getParameter("expenseId"));
        String title = request.getParameter("title");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        // Prepare the database connection and update query
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");

            // SQL query to update the expense
            String query = "UPDATE daily_expense SET title = ?, date = ?, time = ?, description = ?, price = ? WHERE expense_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, date);
            ps.setString(3, time);
            ps.setString(4, description);
            ps.setDouble(5, price);
            ps.setInt(6, expenseId);

            int rowsAffected = ps.executeUpdate();

            HttpSession session = request.getSession();
            if (rowsAffected > 0) {
                // If the update was successful, redirect to view.jsp with a success message
                session.setAttribute("msg", "Expense updated successfully!");
                response.sendRedirect("view.jsp");
            } else {
                // If the update failed, redirect back to the edit page with an error message
                session.setAttribute("errorMessage", "Failed to update the expense. Please try again.");
                response.sendRedirect("editExpense.jsp?expenseId=" + expenseId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle any exceptions and set an error message in the session
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
            response.sendRedirect("editExpense.jsp?expenseId=" + expenseId);
        } finally {
            try {
                // Close the resources
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
