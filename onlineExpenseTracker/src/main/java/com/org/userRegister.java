package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/userRegister")
public class userRegister extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String about = request.getParameter("about");

        response.setContentType("text/html");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");
            Statement stat = con.createStatement();
            stat.executeUpdate("INSERT INTO register (name, email, password, about) VALUES ('" + fullName + "', '"
                    + email + "','" + password + "','" + about + "')");

            System.out.println("Registration successful");

            HttpSession session = request.getSession();
            session.setAttribute("msg", "Registration Successful!");
            response.sendRedirect("register.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("msg", "Registration Failed: " + e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}
