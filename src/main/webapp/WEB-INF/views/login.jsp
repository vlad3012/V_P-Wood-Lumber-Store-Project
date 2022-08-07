<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 06.08.2022
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Log in with your account</title>
</head>

<body>
<sec:authorize access="isAuthenticated()">
    <% response.sendRedirect("/"); %>
</sec:authorize>
<head>
  <title>Spring Security Example</title>
</head>
<body>
<div if="${param.error}">
  <p text="${session.error}" unless="${session == null}"></p>
</div>
<div if="${param.logout}">You have been logged out.</div>
<form action="/login" method="post">
  <div>
    <label> User Name : <input type="text" name="username"/> </label>
  </div>
  <div>
    <label> Password: <input type="password" name="password"/> </label>
  </div>
  <div>
    <input type="submit" value="Sign In"/></div>
</form>
<form action="/register" method="get">
  <input type="submit" value="Register"/></div>
</form>
</body>
</html>