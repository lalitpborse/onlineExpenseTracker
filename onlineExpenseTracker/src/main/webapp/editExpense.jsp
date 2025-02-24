<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Edit Expense</title>
    <%@include file="component/all_css.jsp"%>  <!-- Include your CSS file -->

    <style>
        form {
            width: 50%;
            margin: 0 auto;
            padding: 40px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        label {
            font-weight: bold;
            margin-right: 10px;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 4px;
            margin: 3px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #45a049;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<%@include file="component/navbar.jsp"%> <!-- Include your navbar -->

<h3 class="text-center">Edit Expense</h3>

<%-- Get the expense ID from the URL --%>
<%
    int expenseId = Integer.parseInt(request.getParameter("expenseId"));
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String title = "", date = "", time = "", description = "";
    double price = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");

        // Query to get the expense details for the given ID
        String query = "SELECT * FROM daily_expense WHERE expense_id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, expenseId);
        rs = ps.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            date = rs.getString("date");
            time = rs.getString("time");
            description = rs.getString("description");
            price = rs.getDouble("price");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<div class="form-container">
    <form action="updateExpense" method="post">
        <input type="hidden" name="expenseId" value="<%= expenseId %>">

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required><br><br>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="<%= date %>" required><br><br>

        <label for="time">Time:</label>
        <input type="time" id="time" name="time" value="<%= time %>" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description %></textarea><br><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="<%= price %>" required><br><br>

        <button type="submit">Update Expense</button>
    </form>
</div>

</body>
</html>
