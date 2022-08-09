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
                                #${catalog.id}
                            </h4>
                        </div>
                        <div class="card-body">
                            <input type="hidden" id="catalog_id" value="${catalog.id}">
                            <p class="text-left"><label><spring:message
                                    code="message.form.productType.label"/>: </label>
                                <span class="text-primary"><spring:message
                                        code="message.enum.productType.${catalog.productType.name}"/></span></p>
                            <h4 class="card-title" style="margin-top: 2.75rem"><spring:message
                                    code="message.orders.glass.heading"/>
                            </h4>
                            <c:if test="${catalog.id!=null}">
                                <spring:url value="/catalog/settings/${catalog.id}/updateWood" var="editUrl"/>
                            </c:if>
                            <a href="${editUrl}" class="btn btn-success btn-simple" id="updateWood"><spring:message
                                    code="message.form.button.edit"/></a>
                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th style="width:8rem"><spring:message code="message.wood.column.type"/></th>
                                        <th style="width:8rem"><spring:message code="message.wood.column.size"/></th>
                                        <th style="width:8rem"><spring:message code="message.wood.column.amount"/></th>
                                        <th><spring:message code="message.wood.column.processing"/></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="wood" items="${catalog.woodList}" varStatus="status">
                                        <tr>
                                            <td class="text-center">${status.count}</td>
                                            <td>${glass.glassType.name}-${glass.glassType.thickness}</td>
                                            <td>${glass.width} x ${glass.height}</td>
                                            <td>${glass.amount}</td>
                                            <td>
                                                <c:forEach var="processing"
                                                           items="${wood.processingList}"
                                                           varStatus="status">
                                                    <c:if test="${status.index!=0}">${", "}</c:if>
                                                    ${processing.symbol} ${processing.quantity}
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.enum.componentType.accessory.plural"/></h4>
                        </div>
                        <div class="card-body">
                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th><spring:message code="message.component.column.name"/></th>
                                        <th><spring:message code="message.glass.column.amount"/></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="accessory" items="${catalog.accessories}" varStatus="status">
                                        <tr>
                                            <td class="text-center">${status.count}</td>
                                            <td>${accessory.component.name}</td>
                                            <td>${accessory.amount}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card">
                        <spring:url value="/catalog/displayImage?id=${catalog.id}" var="imageUrl"/>

                        <img class="card-img-top"
                             src="${imageUrl}"
                             alt="Card image cap" id="my_image">
                        <div class="card-body">
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
<!--  Google Maps Plugin    -->
<!-- Place this tag in your head or just before your close body tag. -->
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Chart JS -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/chartjs.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${pageContext.request.contextPath}/resources/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Black Dashboard: parallax effects, scripts for the example pages etc -->
<script src="${pageContext.request.contextPath}/resources/js/black-dashboard.min.js?v=1.0.0"></script>

<script src="${pageContext.request.contextPath}/resources/js/custom/notification.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/custom/catalog.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#catalogSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>
