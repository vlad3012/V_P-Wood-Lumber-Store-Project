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
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><spring:message code="message.navbar.section.catalogSettings"/></h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-lg-2 col-md-3 col-sm-4">
                                    <a href="${pageContext.request.contextPath}/catalog/settings/?productType=${activeType.name}"
                                       class="btn btn-success animation-on-hover"><spring:message
                                            code="message.form.button.add"/></a>
                                </div>
                                <div class="col-lg-10 col-md-9 col-sm-8">
                                    <ul class="nav nav-tabs justify-content-end">
                                        <c:forEach var="type" items="${productTypes}" varStatus="status">
                                            <c:if test="${!type.name.equals('glass')}">
                                                <c:choose>
                                                    <c:when test="${type==activeType}">
                                                        <c:set var="active" value="active"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="active" value=""/>
                                                    </c:otherwise>
                                                </c:choose>

                                                <li class="nav-item">
                                                    <a class="nav-link btn-primary btn-link ${active}"
                                                       href="${pageContext.request.contextPath}/catalog/settings/list?productType=${type.name}">
                                                        <spring:message
                                                                code="message.enum.productType.${type.name}.plural"/> </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card card-plain">
                        <div class="card-body">
                            <div class="row">

                                <c:forEach items="${listOfItems}" var="catalogItem" varStatus="status">
                                    <spring:url value="/catalog/settings/${catalogItem.id}" var="updateUrl"/>
                                    <spring:url value="/catalog/settings/${catalogItem.id}/delete" var="deleteUrl"/>

                                    <div class="col-lg-2 col-md-3 col-sm-4" id="catalogItem_${status.count}">
                                        <div class="card">
                                            <img class="card-img-top"
                                                 src="${pageContext.request.contextPath}/catalog/displayImage?id=${catalogItem.id}"
                                                 alt="Card image cap">
                                            <div class="card-body">
                                                <div class="card-text text-right">
                                                    <c:if test="${catalogItem.woodList.size()!=0}">
                                                         <span class="badge badge-primary"><i
                                                                 class="tim-icons icon-tag"></i></span>
                                                    </c:if>
                                                    <a href="${updateUrl}"
                                                       class="btn btn-success btn-link btn-icon animation-on-hover">
                                                        <i class="tim-icons icon-pencil"></i>
                                                    </a>
                                                    <button onclick="deleteCatalogItem('${deleteUrl}', this)"
                                                            class="btn btn-danger btn-link btn-icon animation-on-hover">
                                                        <i class="tim-icons icon-trash-simple"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
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
    messages['message.notification.loadingData.failure']="<spring:message code="message.notification.loadingData.failure" javaScriptEscape="true"/>";

</script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#catalogSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });

</script>
</body>
</html>
