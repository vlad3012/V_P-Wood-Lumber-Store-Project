<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.08.2022
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<spring:message code="select.option.submit" var="submitValue"/>
<html>
<head>
    <title><spring:message code="product.update.title"/></title>
</head>
<body>
<b><spring:message code="product.update.headline"/></b>
<form method="post" action="/updateProduct">
    <spring:message code="product.update.headline"/>
    <br>
    <label><spring:message code="product.update.productById"/></label>
    <input name="id" type="text">
    <br>
    <label><spring:message code="product.update.newName"/></label>
    <input name="name" type="text">
    <br>
    <input type="submit" name=${submitValue}>
</form>
</body>
</html>
