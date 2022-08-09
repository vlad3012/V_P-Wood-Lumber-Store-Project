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
    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/img/apple-icon.png">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/favicon.png">
    <title>
        STEKLO.BY
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
    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/custom/carousel.css"/>
</head>
<body>
<div class="wrapper">
    <div class="main-panel bg-image-main">
        <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/userHeader.jsp"/>
        <div class="content-user">
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <nav aria-label="breadcrumb" role="navigation">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a class="btn-primary btn-link"
                                                           href="${pageContext.request.contextPath}/main"><spring:message
                                    code="message.navbar.section.home"/></a></li>
                            <li class="breadcrumb-item active" aria-current="page"><spring:message
                                    code="message.navbar.section.contacts"/></li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-2"></div>
            </div>
            <div class="row">
                <div class="col-lg-2">
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3A6b0a9c2451ef923858442f47e705a14f0a4ba7bef5952126db1339304821ecf5&amp;source=constructor"
                                    width="460" height="400" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.contacts.heading"/></h4>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><spring:message code="message.contacts.workingHours"/></p>
                            <p class="card-text"><spring:message code="message.contacts.weekends"/></p>
                            <p class="card-text"><spring:message code="message.contacts.address"/></p>
                            <p class="card-text"><spring:message code="message.contacts.phone.heading"/></p>
                            <p class="card-text"><spring:message code="message.contacts.phone1"/></p>
                            <p class="card-text"><spring:message code="message.contacts.phone2"/></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div id="footerGroup">
            </div>
        </div>
    </div>
</div>
<!-- Core JS Files -->
<script src="${pageContext.request.contextPath}/resources/js/core/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!-- Chart JS -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/chartjs.min.js"></script>
<!-- Notifications Plugin -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/resources/js/black-dashboard.min.js?v=1.0.0"></script>
<!-- Black Dashboard DEMO methods, don't include it in your project! -->
<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/js/custom/bootstrap.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>

</body>
</html>
