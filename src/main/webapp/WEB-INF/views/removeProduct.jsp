<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.08.2022
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<spring:message code="select.option.submit" var="submitValue"/>
<html>
<head>
  <title><spring:message code="product.remove.title"/></title>
</head>
<body>
<form method="post" action="/removeProduct">
  <b><spring:message code="product.remove.head"/></b>
  <br>
  <label><spring:message code="product.remove.input"/></label>
  <input type="text" name="productId">
  <input type="submit" value=${submitValue}>
</form>
</body>
</html>
