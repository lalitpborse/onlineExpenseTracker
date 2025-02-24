<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>

<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../component/all_css.jsp"%>
<style>
.card-sh {
	box-shadow: 10px 10px 8px #888888;
}
</style>
</head>
<body class="bg-light">
	<%@include file="../component/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header text-center">
						<p class="fs-3">Add Expense</p>
						<c:if test="${not empty sessionScope.msg}">
							<div class="text-center alert alert-success">
								${sessionScope.msg}</div>
							<c:remove var="msg" scope="session" />
						</c:if>
					</div>
					<div class="card-body">
						<form action="add_Expense" method="post">
							<div class="mb-3">
								<label for="title">Title</label> <input type="text" id="title"
									name="title" class="form-control">
							</div>
							<div class="mb-3">
								<label for="date">Date</label> <input type="date" id="date"
									name="date" class="form-control">
							</div>
							<div class="mb-3">
								<label for="time">Time</label> <input type="time" id="time"
									name="time" class="form-control">
							</div>
							<div class="mb-3">
								<label for="Description">Description</label> <input type="text"
									id="time" name="description" class="form-control">
							</div>
							<div class="mb-3">
								<label for="Price">Price</label> <input type="text" id="time"
									name="price" class="form-control">
							</div>
							<div class="mb-3">
								<button type="submit" class="btn btn-primary col-md-12">Add
									Expense</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>