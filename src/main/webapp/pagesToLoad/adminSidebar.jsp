<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<body>
<div class="sidebar" id="sidebarAdmin">
    <div class="sidebar-wrapper rounded">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/order/all" class="simple-text logo-normal">
                <spring:message code="message.navbar.menu"/>
            </a>
        </div>
        <ul class="nav">
            <li id="orderSection">
                <a href="${pageContext.request.contextPath}/order/all">
                    <i class="tim-icons icon-chart-bar-32"></i>
                    <p><spring:message code="message.orders.heading"/></p>
                </a>
            </li>
            <li id="priceListSection">
                <a href="${pageContext.request.contextPath}/priceList/all">
                    <i class="tim-icons icon-paper"></i>
                    <p><spring:message code="message.navbar.section.priceLists"/> </p>
                </a>
            </li>
            <li id="componentSection">
                <a href="${pageContext.request.contextPath}/component/">
                    <i class="tim-icons icon-delivery-fast"></i>
                    <p><spring:message code="message.navbar.section.components"/></p>
                </a>
            </li>
            <li id="catalogSection">
                <a href="${pageContext.request.contextPath}/catalog/settings/list">
                    <i class="tim-icons icon-puzzle-10"></i>
                    <p><spring:message code="message.navbar.section.catalogSettings"/></p>
                </a>
            </li>
        </ul>
    </div>
</div>
</body>
</html>