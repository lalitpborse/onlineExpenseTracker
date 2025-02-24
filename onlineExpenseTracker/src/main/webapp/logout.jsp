<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
</head>
<body>
<%
    // Invalidate the session
    session.invalidate(); // This will remove the user from the session

    // Redirect to the home page (or any other page you want after logout)
    response.sendRedirect("index.jsp");
%>
</body>
</html>
