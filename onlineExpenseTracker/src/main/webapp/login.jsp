<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@include file="component/all_css.jsp"%>
<style>
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
                        <p class="text-center fs-3">Login Page</p>
                        
                        <!-- Error Message Display -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger text-center">
                                ${errorMessage}
                            </div>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form action="userLogin" method="POST">
                            <div class="mb-3">
                                <label for="email">Email</label>
                                <input type="email" name="email" id="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="password">Password</label>
                                <input type="password" name="password" id="password" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <button type="submit" class="btn btn-success col-md-12">Login</button>
                                <div class="text-center mt-2">
                                    Don't have an account? <a href="register.jsp" class="text-decoration-none">Create one</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
