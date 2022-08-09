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
                                    code="message.navbar.section.cart"/></li>
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
                            <h4 class="card-title"><spring:message code="message.orders.heading"/></h4>
                        </div>
                        <div class="card-body">
                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                <button type="button" class="btn btn-primary btn-simple btn-sm"
                                        id="order_selectAll">
                                    <spring:message code="message.form.button.selectAll"/>
                                </button>
                                <table class="table tablesorter">
                                    <thead>
                                    <tr>
                                        <th>
                                        </th>
                                        <th class="text-center"><spring:message
                                                code="message.orders.column.orderList"/></th>
                                        <th><spring:message code="message.orders.column.cost"/></th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody id="order">
                                    <c:forEach var="order" items="${orders}" varStatus="counter">
                                        <tr>
                                            <input type="hidden" id="id_${counter.count}" value="${order.id}">
                                            <td>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox"
                                                               id="selected_${counter.count}"
                                                               onclick="calculateCost(this)">
                                                        <span class="form-check-sign"><span
                                                                class="check"></span></span>
                                                    </label>
                                                </div>
                                            </td>
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
                                                            <td class="text-left">
                                                                <c:forEach var="processing"
                                                                           items="${wood.processingList}"
                                                                           varStatus="status">
                                                                    <c:if test="${status.index!=0}">${", "}</c:if>
                                                                    ${processing.name}
                                                                </c:forEach>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:forEach var="accessory" items="${order.accessories}">
                                                        <tr>
                                                            <td class="text-left" colspan="2">- ${accessory.component.name} - ${accessory.amount}шт.</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${order.installation}">
                                                        <tr>
                                                            <td>
                                                                - <spring:message code="message.orders.column.installation"/>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td id="cost_${counter.count}">
                                                    ${order.cost}
                                            </td>
                                            <td class="td-actions text-right">
                                                <spring:url value="/cart/${order.id}/delete" var="deleteUrl"/>

                                                <button type="button" rel="tooltip"
                                                        class="btn btn-link btn-danger btn-sm btn-icon"
                                                        onclick="deleteCartOrder('${deleteUrl}',this)">
                                                    <i class="tim-icons icon-simple-remove"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <button class="btn btn-success animation-on-hover" id="formOrder"><spring:message
                                    code="message.orders.button.formOrder"/></button>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title"><i class="text-info tim-icons icon-money-coins"></i> <spring:message
                                    code="message.orders.total"/><span id="total"
                                                                       style="padding-left: 0.7rem; font-size: 1.2rem">0</span>
                            </h4>
                            <small class="form-text text-muted"><spring:message
                                    code="message.orders.total.text"/></small>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.orders.deliveryMethod"/></h4>
                            <div class="form-row">
                                <div class="form-group col">
                                    <div class="form-check form-check-radio form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="delivery"
                                                   value="delivery" checked>
                                            <spring:message code="message.orders.deliveryMethod.delivery"/>
                                            <span class="form-check-sign"></span>
                                        </label>
                                    </div>
                                    <div class="form-check form-check-radio form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="delivery"
                                                   value="pickUp">
                                            <spring:message code="message.orders.deliveryMethod.pickUp"/>
                                            <span class="form-check-sign"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row" id="deliveryInfo">
                                <div class="form-group col">
                                    <label for="address"><spring:message code="message.form.address.label"/></label>
                                    <input type="text" id="address" class="form-control" value="${address}"
                                           placeholder="<spring:message code="message.form.address.placeholder"/>"
                                           aria-describedby="addressHelp"/>
                                    <small id="addressHelp" class="form-text text-muted"><spring:message
                                            code="message.orders.address.text"/></small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.orders.paymentMethod"/></h4>
                            <div class="form-row">
                                <div class="form-group col">
                                    <div class="form-check form-check-radio form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="payment"
                                                   value="cash" checked>
                                            <spring:message code="message.orders.paymentMethod.cash"/>
                                            <span class="form-check-sign"></span>
                                        </label>
                                    </div>
                                    <div class="form-check form-check-radio form-check-inline">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" name="payment"
                                                   value="card">
                                            <spring:message code="message.orders.paymentMethod.card"/>
                                            <span class="form-check-sign"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary animation-on-hover" id="payForOrder" style="display: none">
                                <spring:message
                                        code="message.orders.button.formAndPayOrder"/></button>
                        </div>
                    </div>
                    <div class="card" id="cardInfo" style="display: none">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message code="message.cart.paymentInfo.header"/></h4>
                        </div>
                        <div class="card-body credit-card">
                            <div class="form-group">
                                <label><spring:message code="message.cart.paymentInfo.cardNumber"/></label>
                                <div class="form-group">
                                    <input id="cardNumber" class="form-control" type="text"
                                           placeholder="0000-0000-0000-0000">
                                </div>
                            </div>
                            <div class="form-group">
                                <label><spring:message code="message.cart.paymentInfo.YourName"/></label>
                                <div class="form-group">
                                    <input id="cardName" class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="form-group col">
                                    <label><spring:message code="message.cart.paymentInfo.Expired"/></label>
                                    <div class="form-group">
                                        <input id="expired" class="form-control" type="text" placeholder="MM/YYYY">
                                    </div>
                                </div>
                                <div class="form-group col">
                                    <label>CVV</label>
                                    <div class="form-group">
                                        <input id="cvv" class="form-control" type="password" placeholder="***">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2"></div>
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
<!-- Black Dashboard DEMO methods, don't include it in your project! -->
<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/js/custom/bootstrap.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/custom/cart.js"></script>

<script type="text/javascript">

    let messages = {};
    messages['message.notification.loadingData.failure']="<spring:message code="message.notification.loadingData.failure" javaScriptEscape="true"/>";
    messages['message.notification.cart.orderSelect']="<spring:message code="message.notification.cart.orderSelect" javaScriptEscape="true"/>";
    messages['message.cart.paymentInfo.failure']="<spring:message code="message.cart.paymentInfo.failure" javaScriptEscape="true"/>";

</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>

</body>
</html>