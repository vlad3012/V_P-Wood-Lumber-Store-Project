<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
                                    code="message.navbar.button.profile"/></li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-2"></div>
            </div>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="title"><spring:message code="message.profile.heading"/></h4>
                        </div>
                        <form:form modelAttribute="customer" method="post" action="/profile/">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <form:input path="id" type="hidden"/>
                                        <div class="form-group">
                                            <label><spring:message code="message.form.name.label"/></label>
                                            <spring:bind path="name">
                                                <div class="form-group ${status.error ? 'has-danger' : ''}">
                                                    <spring:message code="message.form.name.placeHolder"
                                                                    var="namePlaceholder"/>
                                                    <form:input path="name" type="text"
                                                                class="form-control ${status.error ? 'form-control-danger' : ''}"
                                                                placeholder="${namePlaceholder}"/>
                                                    <form:errors path="name" class="form-text text-danger"/>
                                                </div>
                                            </spring:bind>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label><spring:message code="message.form.username.label"/></label>
                                            <input type="text" class="form-control" disabled
                                                   placeholder="<spring:message code="message.form.username.placeHolder"/>"
                                                   value="${username}">
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1"><spring:message
                                                    code="message.form.email.label"/> </label>
                                            <spring:bind path="email">
                                                <div class="form-group ${status.error ? 'has-danger' : ''}">
                                                    <spring:message code="message.form.email.placeHolder"
                                                                    var="emailPlaceholder"/>
                                                    <form:input path="email" type="email" id="exampleInputEmail1"
                                                                class="form-control ${status.error ? 'form-control-danger' : ''}"
                                                                placeholder="${emailPlaceholder}"/>
                                                    <form:errors path="email" class="form-text text-danger"/>
                                                </div>
                                            </spring:bind>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label><spring:message code="message.form.phone.label"/></label>
                                            <spring:bind path="phone">
                                                <div class="form-group ${status.error ? 'has-danger' : ''}">
                                                    <spring:message code="message.form.phone.placeholder"
                                                                    var="phonePlaceholder"/>
                                                    <form:input path="phone" type="text"
                                                                class="form-control ${status.error ? 'form-control-danger' : ''}"
                                                                placeholder="${phonePlaceholder}"/>
                                                    <form:errors path="phone" class="form-text text-danger"/>
                                                </div>
                                            </spring:bind>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div class="form-group">
                                            <label><spring:message code="message.form.address.label"/></label>
                                            <spring:bind path="address">
                                                <div class="form-group ${status.error ? 'has-danger' : ''}">
                                                    <spring:message code="message.form.address.placeholder"
                                                                    var="addressPlaceholder"/>
                                                    <form:input path="address" type="text" class="form-control"
                                                                placeholder="${addressPlaceholder}"/>
                                                    <form:errors path="address" class="form-text text-danger"/>
                                                </div>
                                            </spring:bind>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button type="submit" class="btn btn-fill btn-success animation-on-hover">
                                    <spring:message
                                            code="message.form.button.save"/></button>
                            </div>
                        </form:form>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card-plain" style="margin-bottom: 1rem">
                        <a href="/order/history" type="button" class="btn btn-success btn-simple animation-on-hover">
                            <spring:message code="message.profile.button.ordersHistory"/>
                        </a>
                    </div>
                    <div class="card card-user">
                        <div class="card-body">
                            <p class="card-text">
                            </p>
                            <div class="author">
                                <div class="block block-one"></div>
                                <div class="block block-two"></div>
                                <div class="block block-three"></div>
                                <div class="block block-four"></div>
                                <img class="avatar"
                                     src="${pageContext.request.contextPath}/resources/img/default-avatar.png"
                                     alt="Photo">
                                <h5 class="title">${customer.name}</h5>
                            </div>
                            <p></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2"></div>
            </div>
            <div id="footerGroup"></div>
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
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/js/custom/bootstrap.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");

        <c:if test="${not empty message}">
        let message = "${message}";
        let status = "${status}";
        if (status == null) {
            status = "warning";
        }
        showNotification(message, status);
        </c:if>
    });
</script>
</body>
</html>
