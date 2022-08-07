<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.08.2022
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<spring:message code="select.option.submit" var="submitValue"/>
<html>
<head>
    <title><spring:message code="product.info.title"/></title>
</head>
<body>
<h1><spring:message code="product.info.headline"/></h1>
<form action="/getProduct">
    <br/><spring:message code="product.info.inputId"/>
    <input name="productId" type="text">
    <input type="submit" name=${submitValue}>;
</form>
</body>
</html>
