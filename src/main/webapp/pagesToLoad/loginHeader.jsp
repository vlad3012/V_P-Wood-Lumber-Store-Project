<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Title</title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.6/css/all.css">
    <!-- Nucleo Icons -->
    <link rel="stylesheet" type="text/css" href="../css/nucleo-icons.css"/>
    <!-- CSS Files -->
    <link rel="stylesheet" type="text/css"
          href="../css/black-dashboard.css?v=1.0.0"/>
    <link rel="stylesheet" type="text/css" href="../css/custom/custom.css"/>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-absolute navbar-transparent" id="navbarLogin">
    <div class="container-fluid">
        <a class="navbar-brand" href="/main">STEKLO.BY</a>
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
                                    <img src="${pageContext.request.contextPath}/resources/img/russia.png"
                                         alt="Ru" id="russianIcon">
                                </div>
                                <spring:message code="message.navbar.lang.ru"/>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
</body>
</html>