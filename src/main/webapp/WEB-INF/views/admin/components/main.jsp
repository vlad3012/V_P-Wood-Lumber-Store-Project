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
    <title>Components</title>
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
<body class="">
<div class="wrapper">
    <div id="sidebar">
        <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/adminSidebar.jsp"/>
    </div>
    <div class="bg-image-main main-panel">
        <div id="navbar">
            <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/adminHeader.jsp"/>
        </div>
        <div class="content">
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><spring:message code="message.navbar.section.components"/></h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/woodType1.jpg"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message
                                    code="message.enum.componentType.woodType.plural"/></h4>
                            <p class="card-text"><spring:message code="message.component.section.woodType.text"/></p>
                            <a href="${pageContext.request.contextPath}/component/glassType/all"
                               class="btn btn-primary animation-on-hover"><spring:message
                                    code="message.form.button.open"/></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/processing.jpg"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.enum.componentType.processing"/></h4>
                            <p class="card-text"><spring:message code="message.component.section.processing.text"/></p>
                                <a href="${pageContext.request.contextPath}/component/processing/all"
                                   class="btn btn-primary animation-on-hover"><spring:message code="message.form.button.open"/></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/accessory1.jpg"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.enum.componentType.accessory.plural"/></h4>
                            <p class="card-text"><spring:message code="message.component.section.accessory.text"/></p>
                            <a href="${pageContext.request.contextPath}/component/accessory/all"
                               class="btn btn-primary animation-on-hover"><spring:message code="message.form.button.open"/></a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footerGroup"></div>
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

<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>

<script type="text/javascript">
    $(document).ready(function () {
        $("#componentSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>
