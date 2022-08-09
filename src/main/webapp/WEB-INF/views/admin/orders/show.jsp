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
    <title>Order</title>
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
    <div class="main-panel bg-image-main">
        <div id="navbar">
            <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/adminHeader.jsp"/>
        </div>
        <div class="content">
            <div class="row">
                <div class="col-lg-8 col-md-12">
                    <div class="card card-plain">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.orders.heading.single"/> #${order.id}
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
                                <span class="badge badge-pill ${color}"><spring:message
                                        code="message.enum.orderStatus.${order.status.name}"/></span>
                            </h4>
                        </div>
                        <div class="card-body">
                            <input type="hidden" id="orderId" value="${order.id}">
                            <div class="table-full-width table-responsive table-wrapper-scroll-y my-custom-scrollbar">
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td style="width: 10rem"><label><spring:message
                                                code="message.orders.column.date"/>:</label></td>
                                        <td class="text-left">${order.creationDateFormat}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10rem"><label><spring:message
                                                code="message.orders.column.deadline"/>:</label></td>
                                        <td class="text-left">${order.deadlineFormat}</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10rem"><label><spring:message
                                                code="message.orders.column.product"/>:</label></td>
                                        <td class="text-left"><spring:message
                                                code="message.enum.productType.${order.productType.name}"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10rem"><label><spring:message
                                                code="message.orders.column.payment"/>:</label></td>
                                        <td class="text-left"><spring:message
                                                code="message.enum.payment.${order.paymentMethod.name}"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10rem"><label><spring:message
                                                code="message.orders.column.service"/>:</label></td>
                                        <td class="text-left">
                                            <c:if test="${order.delivery}">
                                                <spring:message code="message.orders.column.delivery"/>
                                            </c:if>
                                            <c:if test="${order.installation}">
                                                <spring:message code="message.orders.column.installation"/>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10rem"><label class="text-primary"><spring:message
                                                code="message.orders.column.cost"/>:</label></td>
                                        <td class="text-left t"><span class="text-primary">${order.cost}</span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${!order.status.name.equals('closed')}">
                                <spring:url value="/order/${order.id}/status?status=CLOSED" var="closedUrl"/>
                                <spring:url value="/order/${order.id}/status?status=PAID" var="paidUrl"/>
                                <spring:url value="/order/${order.id}/update" var="updateUrl"/>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <a href="/order/${order.id}/update" class="btn btn-success animation-on-hover"><spring:message
                                                code="message.form.button.update"/></a>
                                        <c:if test="${!order.status.name.equals('paid')}">
                                            <button onclick="post('${paidUrl}')" class="btn btn-warning animation-on-hover"
                                                    id="payForOrder"><i class="tim-icons icon-money-coins"></i> <spring:message
                                                    code="message.form.button.pay"/></button>
                                        </c:if>
                                        <button onclick="post('${closedUrl}')" class="btn btn-primary animation-on-hover"
                                                id="closeOrder"><i class="tim-icons icon-button-power"></i> <spring:message
                                                code="message.form.button.close"/></button>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.orders.wood.heading"/></h4>
                        </div>
                        <div class="card-body">
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
                                    <c:forEach var="wood" items="${order.woodList}" varStatus="status">
                                        <tr>
                                            <td class="text-center">${status.count}</td>
                                            <td>${wood.woodType.name}-${wood.woodType.diameter}</td>
                                            <td>${wood.width} x ${wood.height}</td>
                                            <td>${wood.amount}</td>
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
                                        <th><spring:message code="message.wood.column.amount"/></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="accessory" items="${order.accessories}" varStatus="status">
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
                <div class="col-lg-4 col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                <i class="tim-icons icon-single-02 text-success"></i>
                                <spring:message code="message.customer.contacts"/></h4>
                        </div>
                        <div class="card-body">
                            <div class="table-full-width table-responsive table-wrapper-scroll-y my-custom-scrollbar">
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td><label><spring:message code="message.form.name.label"/>: </label></td>
                                        <td>${order.customer.name}</td>
                                    </tr>
                                    <tr>
                                        <td><label><spring:message code="message.form.phone.label"/>: </label></td>
                                        <td>${order.customer.phone}</td>
                                    </tr>
                                    <tr>
                                        <td><label><spring:message code="message.form.email.label"/>: </label></td>
                                        <td>${order.customer.email}</td>
                                    </tr>
                                    <tr>
                                        <td><label><spring:message code="message.form.address.label"/>: </label></td>
                                        <td>${order.deliveryAddress}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 col-md-12">

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
<script src="${pageContext.request.contextPath}/resources/js/custom/order.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#orderSection").addClass("active");
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
