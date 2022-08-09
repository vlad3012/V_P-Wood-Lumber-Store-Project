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
                            <li class="breadcrumb-item"><a class="btn-primary btn-link"
                                                           href="${pageContext.request.contextPath}/profile/"><spring:message
                                    code="message.navbar.button.profile"/></a></li>
                            <li class="breadcrumb-item active" aria-current="page"><spring:message
                                    code="message.orders.history.heading"/></li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-2"></div>
            </div>
            <div class="row">
                <div class="col-lg-2"></div>
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="title"><spring:message code="message.orders.history.heading"/></h4>
                        </div>
                        <div class="card-body">
                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th><spring:message code="message.orders.column.status"/></th>
                                        <th><spring:message code="message.orders.column.date"/></th>
                                        <th class="text-center"><spring:message
                                                code="message.orders.column.orderList"/></th>
                                        <th><spring:message code="message.orders.column.cost"/></th>
                                        <th><spring:message code="message.orders.column.deadline"/></th>
                                        <th><spring:message code="message.orders.column.installation"/></th>
                                        <th><spring:message code="message.orders.column.delivery"/></th>
                                        <th><spring:message code="message.orders.column.payment"/></th>
                                    </tr>
                                    </thead>
                                    <tbody id="order">
                                    <c:forEach var="order" items="${orders.pageList}" varStatus="counter">
                                        <tr>
                                            <td class="text-center">${(orders.firstElementOnPage+counter.count)}</td>
                                            <c:choose>
                                                <c:when test="${order.status.name.equals('active')}">
                                                    <c:set var="color" value="badge-info"/>
                                                </c:when>
                                                <c:when test="${order.status.name.equals('paid')}">
                                                    <c:set var="color" value="badge-warning"/>
                                                </c:when>
                                                <c:when test="${order.status.name.equals('closed')}">
                                                    <c:set var="color" value="badge-primary"/>
                                                </c:when>
                                            </c:choose>
                                            <td><span class="badge ${color}"> <spring:message
                                                    code="message.enum.orderStatus.${order.status.name}"/></span></td>
                                            <td>${order.creationDateFormat}</td>
                                            <td>
                                                <table class="table table-borderless">
                                                    <tbody>
                                                    <tr>
                                                        <td style="color:#00f2c3 !important">
                                                            <spring:message
                                                                    code="message.enum.productType.${order.productType.name}"/>
                                                        </td>
                                                    </tr>
                                                    <c:forEach var="wood" items="${order.woodList}">
                                                        <tr>
                                                            <td class="text-left"
                                                                style="width: 8rem">- ${wood.woodType.name}-${wood.woodType.diameter}</td>
                                                            <td style="width: 8rem">${wood.width}x${wood.height}-${wood.amount}</td>
                                                            <td class="text-left"><c:forEach var="processing"
                                                                                             items="${wood.processingList}"
                                                                                             varStatus="status">
                                                                <c:if test="${status.index!=0}">${" "}</c:if>
                                                                ${processing.name}
                                                            </c:forEach></td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:forEach var="accessory" items="${order.accessories}">
                                                        <tr>
                                                            <td class="text-left" colspan="2">- ${accessory.component.name} - ${accessory.amount}шт.</td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td id="cost_${counter.count}">${order.cost} </td>
                                            <td class="${order.expired ? 'text-danger' : ''}">${order.deadlineFormat}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${order.installation}">
                                                        ✓
                                                    </c:when>
                                                    <c:otherwise>
                                                        x
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${order.delivery}">
                                                        ${order.deliveryAddress}
                                                    </c:when>
                                                    <c:otherwise>
                                                        x
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><spring:message
                                                    code="message.enum.payment.${order.paymentMethod.name}"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer">
                            <ul class="pagination">
                                <c:forEach begin="1" end="${orders.pageCount}" step="1" varStatus="tagStatus">
                                    <li class="page-item ${tagStatus.current==(orders.page+1) ? 'active' : ''}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/order/history?page=${tagStatus.current}">${tagStatus.current}</a>
                                    </li>
                                </c:forEach>
                            </ul>
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
