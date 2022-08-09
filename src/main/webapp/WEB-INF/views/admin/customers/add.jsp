<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sprin" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Customer</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><spring:message code="message.customer.heading"/></h4>
                </div>
                <div class="card-body">
                    <spring:url value="/customer/?orderId=${orderId}" var="customerSave"/>
                    <form:form method="post" action="${customerSave}" modelAttribute="customer">
                        <spring:bind path="name">
                            <div class="form-group ${status.error ? 'has-danger' : ''}">
                                <label for="name"><spring:message code="message.form.name.label"/></label>
                                <spring:message code="message.form.name.placeHolder" var="namePlaceholder"/>
                                <form:input path="name" type="text"
                                            class="form-control ${status.error ? 'form-control-danger' : ''}" id="name"
                                            placeholder="${namePlaceholder}"/>
                                <form:errors path="name" class="form-text text-danger"/>
                            </div>
                        </spring:bind>
                        <spring:bind path="email">
                            <div class="form-group ${status.error ? 'has-danger' : ''}">
                                <label for="email"><spring:message code="message.form.email.label"/></label>
                                <spring:message code="message.form.email.placeHolder" var="emailPlaceholder"/>
                                <form:input path="email" type="email"
                                            class="form-control ${status.error ? 'form-control-danger' : ''}" id="email"
                                            placeholder="${emailPlaceholder}"/>
                                <form:errors path="email" class="form-text text-danger"/>
                            </div>
                        </spring:bind>
                        <spring:bind path="phone">
                            <div class="form-group ${status.error ? 'has-danger' : ''}">
                                <label for="phone"><spring:message code="message.form.phone.label"/></label>
                                <spring:message code="message.form.phone.placeholder" var="phonePlaceholder"/>
                                <form:input path="phone" type="phone"
                                            class="form-control ${status.error ? 'form-control-danger' : ''}" id="phone"
                                            placeholder="${phonePlaceholder}"/>
                                <form:errors path="phone" class="form-text text-danger"/>
                            </div>
                        </spring:bind>
                        <div class="form-group">
                            <label for="address"><spring:message code="message.form.address.label"/></label>
                            <spring:message code="message.form.address.placeholder" var="addressPlaceholder"/>
                            <form:input path="address" class="form-control" id="address"
                                        placeholder="${addressPlaceholder}"/>
                        </div>
                        <button type="submit" class="btn btn-primary animation-on-hover"><spring:message
                                code="message.form.button.save"/></button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<!--   Core JS Files   -->
<script src="${pageContext.request.contextPath}/resources/js/core/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Google Maps Plugin    -->
<!-- Place this tag in your head or just before your close body tag. -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Chart JS -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/resources/js/black-dashboard.min.js?v=1.0.0"></script>
<!-- Black Dashboard DEMO methods, don't include it in your project! -->
<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>
<script src="${pageContext.request.contextPath}/resources/js/custom/calculator.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#orderSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>
