<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<body>
<nav class="navbar navbar-expand-lg navbar-absolute navbar-transparent" id="navbarAdmin">
    <div class="container-fluid">
        <div class="navbar-wrapper">
            <div class="navbar-toggle d-inline">
                <button type="button" class="navbar-toggler">
                    <span class="navbar-toggler-bar bar1"></span>
                    <span class="navbar-toggler-bar bar2"></span>
                    <span class="navbar-toggler-bar bar3"></span>
                </button>
            </div>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/order/all"><spring:message
                    code="message.navbar.button.adminDashboard"/></a>
        </div>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
        </button>
        <div class="collapse navbar-collapse" id="navigation">
            <ul class="navbar-nav ml-auto">
                <li class="dropdown nav-item">
                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                        <i class="tim-icons icon-world"></i>
                        <p class="d-lg-none">
                            <spring:message code="message.navbar.lang.heading"/>
                        </p>
                    </a>
                    <ul class="dropdown-menu dropdown-navbar">
                        <li class="nav-link">
                            <a href="?lang=en" class="nav-item dropdown-item">
                                <div class="photo">
                                    <img src="${pageContext.request.contextPath}/resources/img/united-kingdom.png"
                                         alt="En" id="englishIcon">
                                </div>
                                <spring:message code="message.navbar.lang.en"/>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="?lang=ru" class="nav-item dropdown-item">
                                <div class="photo">
                                    <img src="${pageContext.request.contextPath}/resources/img/russia.png" alt="Ru"
                                         id="russianIcon">
                                </div>
                                <spring:message code="message.navbar.lang.ru"/>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown nav-item">
                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                        <i class="tim-icons icon-single-02"></i>
                        <p class="d-lg-none">
                            <spring:message code="message.navbar.button.user"/>
                        </p>
                    </a>
                    <ul class="dropdown-menu dropdown-navbar">
                        <li class="nav-link"><a href="${pageContext.request.contextPath}/main"
                                                class="nav-item dropdown-item"><spring:message
                                code="message.navbar.section.onlineStore"/></a>
                        </li>
                        <li class="dropdown-divider"></li>
                        <li class="nav-link"><a href="${pageContext.request.contextPath}/logout"
                                                class="nav-item dropdown-item"><spring:message
                                code="message.navbar.button.logOut"/></a></li>
                    </ul>
                </li>
                <li class="separator d-lg-none"></li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>