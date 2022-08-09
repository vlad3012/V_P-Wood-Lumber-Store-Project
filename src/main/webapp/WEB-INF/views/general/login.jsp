<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%--    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/img/apple-icon.png">--%>
    <%--    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/favicon.png">--%>
    <title>
        Log in
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,600,700,800"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.6/css/all.css">
    <!-- Nucleo Icons -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/nucleo-icons.css"/>
    <!-- CSS Files -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/black-dashboard.css?v=1.0.0"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/custom/custom.css"/>
</head>
<body class="" style="">
<div class="wrapper">
    <div class="main-panel bg-image">
        <div id="navbar">
            <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/loginHeader.jsp"/>
        </div>
        <div class="row align-items-center" style="height: 100vh">
            <div class="col-lg-3"></div>
            <div class="col-lg-6">
                <div class="card card-login">
                    <div class="card-body">
                        <form method="post" action="/login" id="loginForm">
                            <div class="form-group">
                                ${requestScope.userPrincipal}
                                <label for="username"><spring:message code="message.form.login.label"/></label>
                                <div class="form-group ${param.error ? 'has-danger' : ''}">
                                    <input type="text" id="username" name="username" class="form-control ${param.error ? 'form-control-danger' : ''}"
                                           value="${username}" placeholder="<spring:message code="message.form.login.placeHolder"/>">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password"><spring:message code="message.form.password.label"/></label>
                                <div class="form-group ${param.error ? 'has-danger' : ''}">
                                    <input type="password" id="password" name="password" class="form-control ${param.error ? 'form-control-danger' : ''}"
                                           value="${password}" placeholder="<spring:message code="message.form.password.placeHolder"/>">
                                </div>
                            </div>
                            <c:if test="${param.error}">
                                <div id="error" class="form-group">
                                    <div class="form-text text-danger">
                                        <spring:message code="message.badCredentials">
                                        </spring:message>
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary animation-on-hover"><spring:message code="message.form.button.submitLogin"/></button>
                            </div>
                            <div class="form-group row">
                                <p class="form-text"><spring:message code="message.form.text.signUp"/>
                                    <a href="/signUp" class="btn btn-warning btn-link animation-on-hover"><spring:message code="message.navbar.button.signUp"/></a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-lg-3"></div>
        </div>
    </div>
</div>
<!--   Core JS Files   -->
<script src="${pageContext.request.contextPath}/resources/js/core/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- Chart JS -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/resources/js/black-dashboard.min.js?v=1.0.0"></script>
<!-- Black Dashboard DEMO methods, don't include it in your project! -->
<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>
</body>
</html>
