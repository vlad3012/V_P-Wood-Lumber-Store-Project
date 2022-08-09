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
    <title>Catalog settings</title>
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
<body>
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
                <div class="col-lg-8 col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.catalog.settings.heading"/>
                            </h4>
                        </div>
                        <div class="card-body">
                            <input type="hidden" id="catalog_id">
                            <div class="form-group">
                                <label for="productType"><spring:message code="message.form.productType.label"/></label>
                                <select type="text" id="productType" class="form-control" name="productType">
                                    <c:forEach var="type" items="${productTypes}">
                                        <c:if test="${!type.name.equals('glass')}">
                                            <c:set var="selected" value=""/>
                                            <c:if test="${type==activeType}">
                                                <c:set var="selected" value="selected"/>
                                            </c:if>
                                            <option value="${type.name}" ${selected}><spring:message
                                                    code="message.enum.productType.${type.name}"/></option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-success animation-on-hover" id="save"><spring:message
                                        code="message.form.button.save"/></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <spring:url value="${pageContext.request.contextPath}/resources/img/empty_photo.jpg"
                                    var="imageUrl"/>

                        <img class="card-img-top"
                             src="${imageUrl}"
                             alt="Card image cap" id="my_image">
                        <div class="card-body">
                            <div class="file-input-custom">
                                <div class="form-group">
                                    <label class="label">
                                            <span><i class="tim-icons icon-attach-87"></i>
                                        <span class="title"><spring:message code="message.form.button.addFile"/></span>
                                        <input type="file" name="file" id="file_upload">
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <p class="card-text" id="file_upload_name"></p>
                        </div>
                    </div>
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
<!-- Chart JS -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/resources/js/black-dashboard.min.js?v=1.0.0"></script>

<script src="${pageContext.request.contextPath}/resources/js/custom/notification.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/custom/catalog.js"></script>

<script type="text/javascript">

    let messages = {};
    messages['message.notification.catalog.upload.validate'] = "<spring:message code="message.notification.catalog.upload.validate" javaScriptEscape="true"/>";
    messages['message.notification.catalog.upload.failure'] = "<spring:message code="message.notification.catalog.upload.failure" javaScriptEscape="true"/>";

</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#catalogSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>
