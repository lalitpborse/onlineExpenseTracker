<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="component/all_css.jsp"%>
<style type="text/css">
.card-sh {
	box-shadow: 10px 10px 8px #888888;
}
</style>
</head>
<body class="bg-light">
	<%@include file="component/navbar.jsp"%>
	<div class="container p-5">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card card-sh">
					<div class="card-header">
						<p class="text-center fs-3">Register Page</p>
						<c:if test="${not empty sessionScope.msg}">
							<div class="text-center alert alert-success">
								${sessionScope.msg}</div>
							<c:remove var="msg" scope="session" />
						</c:if>
					</div>
					<div class="card-body">
						<form action="userRegister" method="POST">
							<div class="mb-3">
								<label for="fullName">Enter Name</label> <input type="text"
									name="fullName" id="fullName" class="form-control" required>
							</div>

							<div class="mb-3">
								<label for="email">Email</label> <input type="email"
									name="email" id="email" class="form-control" required>
							</div>

							<div class="mb-3">
								<label for="password">Password</label> <input type="password"
									name="password" id="password" class="form-control" required>
							</div>

							<div class="mb-3">
								<label for="about">About</label> <input type="text" name="about"
									id="about" class="form-control">
							</div>
							

							<div class="mb-3">
								<button type="submit" class="btn btn-success col-md-12">Register</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>