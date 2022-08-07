<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 07.08.2022
  Time: 18:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<spring:message code="select.option.submit" var="submitValue"/>
<html>
<head>
    <title><spring:message code="product.create.title"/></title>
</head>
<body>
<b><spring:message code="product.create.headline"/></b>
<form method="post" action="/createProduct">
    <br>
    <label><spring:message code="product.create.name"/></label>
    <input type="text" name="name"/>
    <br>
    <input type="submit" name=${submitValue}>

</form>
</body>
</html>
