<%@ page
	import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>View Expenses</title>
<%@include file="component/all_css.jsp"%>

<!-- Include Bootstrap 4 CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 8px;
        text-align: left;
    }

    .msg {
        color: green;
    }

    .error {
        color: red;
    }

    .actions {
        text-align: center;
    }

    /* Custom styling for buttons */
    button {
        padding: 6px 12px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        text-decoration: none;
        font-size: 14px;
    }

    .edit-btn {
        background-color: #4CAF50;
        color: white;
    }

    .delete-btn {
        background-color: #f44336;
        color: white;
    }

    .edit-btn:hover {
        background-color: #45a049;
    }

    .delete-btn:hover {
        background-color: #e53935;
    }
</style>

</head>
<body>

	<%@include file="component/navbar.jsp"%>

	<%-- Display success or error message --%>
	<c:if test="${not empty sessionScope.msg}">
		<p class="msg text-center mt-3">${sessionScope.msg}</p>
		<%
		session.removeAttribute("msg");
		%>
	</c:if>

	<c:if test="${not empty sessionScope.errorMessage}">
		<p class="error">${sessionScope.errorMessage}</p>
		<%
		session.removeAttribute("errorMessage");
		%>
	</c:if>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="table-responsive">
					<%-- Display the expense records --%>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Title</th>
								<th>Date</th>
								<th>Time</th>
								<th>Description</th>
								<th>Price</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							HttpSession session2 = request.getSession();
							Integer userId = (Integer) session2.getAttribute("userId");

							if (userId == null) {
								response.sendRedirect("login.jsp");
							} else {
								Connection con = null;
								PreparedStatement ps = null;
								ResultSet rs = null;

								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									con = DriverManager.getConnection("jdbc:mysql://localhost:3306/expenses", "root", "root");

									String query = "SELECT * FROM daily_expense WHERE user_id = ?";
									ps = con.prepareStatement(query);
									ps.setInt(1, userId);
									rs = ps.executeQuery();

									while (rs.next()) {
							%>
							<tr>
								<td><%=rs.getString("title")%></td>
								<td><%=rs.getDate("date")%></td>
								<td><%=rs.getTime("time")%></td>
								<td><%=rs.getString("description")%></td>
								<td><%=rs.getDouble("price")%></td>
								<td class="actions">
									<!-- Stylish Edit Button -->
									<a href="editExpense.jsp?expenseId=<%=rs.getInt("expense_id")%>">
										<button class="edit-btn">Edit</button>
									</a>
									| 
									<!-- Stylish Delete Button -->
									<a href="deleteExpense?expenseId=<%=rs.getInt("expense_id")%>"
									   onclick="return confirm('Are you sure you want to delete this expense?');">
										<button class="delete-btn">Delete</button>
									</a>
								</td>
							</tr>
							<%
									}
								} catch (Exception e) {
									e.printStackTrace();
									session.setAttribute("errorMessage", "Error fetching records: " + e.getMessage());
									response.sendRedirect("view.jsp");
								} finally {
									try {
										if (rs != null)
											rs.close();
										if (ps != null)
											ps.close();
										if (con != null)
											con.close();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
