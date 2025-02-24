<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%><style>
.icon-padd {
	padding-right: 6px;
	/*     border: 1px solid black;
 */
	margin-top: 5px;
}
</style>
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
	<div class="container-fluid">
		<a class="navbar-brand" href="#"><i class="fa-solid fa-book icon-padd"></i> Expense Tracker </a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="index.jsp"><i
						class="fa-solid fa-house icon-padd"></i>Home</a></li>

				<c:if test="${not empty sessionScope.userName}">
					<li class="nav-item"><a class="nav-link active"
						href="add_expense.jsp"> <i class="fa-solid fa-plus icon-padd"></i>Add
							Expense
					</a></li>

					<li class="nav-item"><a class="nav-link active "
						href="view.jsp" tabindex="-1"> <i
							class="fa-solid fa-receipt icon-padd"></i>View Expense
					</a></li>
				</c:if>
				<c:if test="${empty sessionScope.userName}"></c:if>


			</ul>
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">

				<c:if test="${not empty sessionScope.userName}">
					<li class="nav-item"><a class="nav-link active" href="#">
							<i class="fa-solid fa-user icon-padd"></i>${sessionScope.userName}
					</a></li>

					<li class="nav-item"><a class="nav-link active "
						href="logout.jsp" tabindex="-1"> <i
							class="fa-solid fa-right-to-bracket icon-padd"></i>Logout
					</a></li>
				</c:if>

				<c:if test="${empty sessionScope.userName}">
					<li class="nav-item"><a class="nav-link active"
						href="login.jsp"> <i
							class="fa-solid fa-right-to-bracket icon-padd"></i>Login
					</a></li>

					<li class="nav-item"><a class="nav-link active "
						href="register.jsp" tabindex="-1"> <i
							class="fa-solid fa-user-plus icon-padd"></i>Register
					</a></li>
				</c:if>

			</ul>
		</div>
	</div>
</nav>

