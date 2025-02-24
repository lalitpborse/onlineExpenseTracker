package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/userLogin")
public class userLogin extends HttpServlet {

    // Handle POST requests (for login)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the user input from the login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setContentType("text/html");

        // Initialize connection and statement objects
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");

            // Query to check if the email and password match in the database
            String query = "SELECT * FROM register WHERE email = ? AND password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);  // Set email parameter
            ps.setString(2, password);  // Set password parameter

            // Execute query and get the result set
            rs = ps.executeQuery();

            // Check if the user exists in the database
            if (rs.next()) {
                // Login successful: store user details in the session
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));  // Store user ID in session
                session.setAttribute("userName", rs.getString("name"));  // Store user name in session

                // Redirect to home page or dashboard after successful login
                response.sendRedirect("home.jsp");  // Change to your desired page after login
            } else {
                // Login failed: send error message
                request.setAttribute("errorMessage", "Invalid email or password!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);  // Redirect back to login page
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error");
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Handle GET requests (redirect to the login page)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");  // Redirect to login page
    }
}
