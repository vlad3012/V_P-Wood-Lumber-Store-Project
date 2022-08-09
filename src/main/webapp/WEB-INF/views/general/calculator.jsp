8
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
    <security:authorize access="!hasRole('ADMIN')">
        <link rel="apple-touch-icon" sizes="76x76"
              href="${pageContext.request.contextPath}/resources/img/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/favicon.png">
        <title>STEKLO.BY</title>
    </security:authorize>
    <security:authorize access="hasRole('ADMIN')">
        <title>Calculator</title>
    </security:authorize>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" \>
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
<body clas="">
<div class="wrapper">
    <div id="sidebar">
        <security:authorize access="hasRole('ADMIN')">
            <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/adminSidebar.jsp"/>
        </security:authorize>
    </div>
    <div class="main-panel bg-image-main">
        <div id="navbar">
            <security:authorize access="!hasRole('ADMIN')">
                <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/userHeader.jsp"/>
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">
                <jsp:include page="${pageContext.request.contextPath}/resources/pagesToLoad/adminHeader.jsp"/>
            </security:authorize>
        </div>
        <security:authorize access="!hasRole('ADMIN')">
            <c:set var="contentClass" value="content-user"/>
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">
            <c:set var="contentClass" value="content"/>
        </security:authorize>
        <div class="${contentClass}">
            <security:authorize access="!hasRole('ADMIN')">
                <div class="row">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-8">
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a class="btn-primary btn-link" href="/main"><spring:message
                                        code="message.navbar.section.home"/></a></li>
                                <li class="breadcrumb-item active" aria-current="page"><spring:message
                                        code="message.navbar.section.calculator"/></li>
                            </ol>
                        </nav>
                    </div>
                    <div class="col-lg-2"></div>
                </div>
            </security:authorize>
            <div class="row">
                <security:authorize access="!hasRole('ADMIN')">
                    <div class="col-lg-2">
                    </div>
                    <c:set var="colSizeLg" value="col-lg-8"/>
                </security:authorize>
                <security:authorize access="hasRole('ADMIN')">
                    <c:set var="colSizeLg" value="col-lg-12"/>
                </security:authorize>
                <div class="${colSizeLg} col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <c:choose>
                                <c:when test="${isForTemplate}">
                                    <h4 class="card-title"><spring:message code="message.calculator.template"/>
                                        #${model.id}</h4>
                                </c:when>
                                <c:otherwise>
                                    <h4 class="card-title"><spring:message
                                            code="message.navbar.section.calculator"/></h4>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <form id="calculatorForm" method="post" action="${formUrl}" modelAttribute="model">

                                <security:authorize access="hasRole('ADMIN')">
                                    <c:if test="${!isForTemplate || isForTemplate==null}">
                                        <c:if test="${model.id != null}">
                                            <div class="form-row">
                                                <div class="form-group col-lg-6">
                                                    <p class="text-primary"><spring:message
                                                            code="message.orders.heading.single"/> #${model.id}
                                                    </p>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group col-lg-6">
                                                    <p class="text-success"><spring:message
                                                            code="message.calculator.customer"/>: ${model.customer.name}</p>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:if>
                                    <input id="id" type="hidden" value="${model.id}"/>
                                </security:authorize>

                                <div class="form-row">
                                    <div class="form-group col-lg-6 col-md-12">
                                        <label for="productType"><spring:message
                                                code="message.form.productType.label"/></label>
                                        <div class="form-group ${status.error ? 'has-danger' : ''}">
                                            <select id="productType"
                                                    class="form-control ${status.error ? 'form-control-danger' : ''}">
                                                <c:forEach items="${productTypes}" var="type">
                                                    <c:set var="selected" value=""/>
                                                    <c:if test="${type==model.productType}">
                                                        <c:set var="selected" value="selected"/>
                                                    </c:if>
                                                    <spring:message code="message.enum.productType.${type.name}"
                                                                    var="typeLabel"/>
                                                    <option value="${type}" ${selected}>${typeLabel}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <c:if test="${!isForTemplate || isForTemplate==null}">
                                        <div class="form-group col-lg-6 col-md-12 align-self-center">
                                            <div class="form-check">
                                                <label class="form-check-label">
                                                    <input class="form-check-input" type="checkbox" id="installation"
                                                           value="${model.installation}">
                                                    <spring:message code="message.orders.column.installation"/>
                                                    <span class="form-check-sign"><span
                                                            class="check"></span>
                                                </span>
                                                </label>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col">
                                        <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                            <table class="table">
                                                <thead>
                                                <th style="width: 20px"><spring:message
                                                        code="message.orders.wood.heading"/></th>
                                                <th>
                                                    <button type="button"
                                                            class="btn btn-primary btn-simple btn-sm"
                                                            id="addRaw">
                                                        <spring:message code="message.form.button.add"/>
                                                    </button>
                                                </th>
                                                <th><spring:message code="message.wood.column.processing"/></th>
                                                </thead>
                                                <tbody id="wood">
                                                <c:forEach var="wood" items="${model.woodList}" varStatus="status">
                                                    <tr id="row_${status.count}">
                                                        <td class="td-action">
                                                            <button type="button" id="delete" type="button"
                                                                    rel="tooltip"
                                                                    class="btn btn-link btn-danger btn-sm btn-icon">
                                                                <i class="tim-icons icon-trash-simple"></i>
                                                            </button>
                                                        </td>
                                                        <td style="width:50%">
                                                            <div class="form-row">
                                                                <div class="form-group col">
                                                                    <label><spring:message
                                                                            code="message.calculator.shape.label"/></label>
                                                                    <select class="form-control" id="shape">
                                                                        <c:forEach var="shape" items="${shapes}">
                                                                            <c:set var="selected" value=""/>
                                                                            <c:if test="${shape==wood.shape}">
                                                                                <c:set var="selected" value="selected"/>
                                                                            </c:if>
                                                                            <option ${selected} value="${shape}">
                                                                                <spring:message
                                                                                        code="message.enum.shape.${shape.name}"/></option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>

                                                            <div class="form-row">
                                                                <div class="form-group col-lg-8 col-md-12">
                                                                    <select class="form-control" id="glassType">
                                                                        <option selected
                                                                                value="${wood.woodType.name}">${wood.woodType.name}</option>
                                                                    </select>
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-12">
                                                                    <select class="form-control" id="thickness">
                                                                        <option selected
                                                                                value="${wood.woodType.id}">${wood.woodType.diameter}</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-row">
                                                                <div class="form-group col-lg-4 col-md-12">
                                                                    <input class="form-control" type="number" id="width"
                                                                           placeholder="<spring:message code="message.form.width.placeholder"/>"
                                                                           value="${wood.width}">
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-12">
                                                                    <input class="form-control" type="number"
                                                                           id="height"
                                                                           placeholder="<spring:message code="message.form.height.placeholder"/>"
                                                                           value="${wood.height}">
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-12">
                                                                    <input class="form-control" type="number"
                                                                           id="amount"
                                                                           placeholder="<spring:message code="message.form.amount.placeholder"/>"
                                                                           value="${wood.amount}">
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="td-action" style="width:50%">
                                                            <button type="button" id="addProcessing" type="button"
                                                                    rel="tooltip"
                                                                    class="btn btn-link btn-success btn-sm btn-icon">
                                                                <i class="tim-icons icon-simple-add"></i>
                                                            </button>
                                                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                                                <table class="table table-borderless">
                                                                    <tbody id="processing">
                                                                    <c:forEach var="processing"
                                                                               items="${wood.processingList}"
                                                                               varStatus="status">
                                                                        <tr id="row_${status.count}">
                                                                            <td class="td-action">
                                                                                <button type="button" id="delete"
                                                                                        type="button"
                                                                                        rel="tooltip"
                                                                                        class="btn btn-link btn-danger btn-sm btn-icon">
                                                                                    <i class="tim-icons icon-trash-simple"></i>
                                                                                </button>
                                                                            </td>
                                                                            <td>
                                                                                <div class="form-row">
                                                                                    <div class="form-group col-lg-6 col-md-12">
                                                                                        <select class="form-control"
                                                                                                id="type">
                                                                                            <option selected
                                                                                                    value="${processing.type}">
                                                                                                <spring:message
                                                                                                        code="message.enum.processingType.${processing.type.name}"/></option>
                                                                                        </select>
                                                                                    </div>
                                                                                    <div class="form-group col-lg-6 col-md-12">
                                                                                        <select class="form-control"
                                                                                                id="name">
                                                                                            <option selected
                                                                                                    value="${processing.id}">${processing.name}</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-row">
                                                                                    <div class="form-group col-lg-6 col-md-12">
                                                                                        <input class="form-control"
                                                                                               type="number"
                                                                                               id="quantity"
                                                                                               placeholder="<spring:message code="message.form.amount.placeholder"/>"
                                                                                               value="${processing.quantity}">
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                            <table class="table">
                                                <thead>
                                                <th style="width: 20px"><spring:message
                                                        code="message.enum.componentType.accessory.plural"/></th>
                                                <th>
                                                    <button type="button"
                                                            class="btn btn-primary btn-simple btn-sm"
                                                            id="addAccessoryRaw">
                                                        <spring:message code="message.form.button.add"/>
                                                    </button>
                                                </th>
                                                <tbody id="accessories">
                                                <c:forEach var="accessory" items="${model.accessories}"
                                                           varStatus="status">
                                                    <tr id="row_${status.count}">
                                                        <td class="td-action">
                                                            <button type="button" id="delete" type="button"
                                                                    rel="tooltip"
                                                                    class="btn btn-link btn-danger btn-sm btn-icon">
                                                                <i class="tim-icons icon-trash-simple"></i>
                                                            </button>
                                                        </td>
                                                        <td>
                                                            <div class="form-row">
                                                                <div class="form-group col-lg-8 col-md-12">
                                                                    <select class="form-control" id="accessory">
                                                                        <option selected
                                                                                value="${accessory.component.id}">${accessory.component.name}</option>
                                                                    </select>
                                                                </div>
                                                                <div class="form-group col-lg-4 col-md-12">
                                                                    <input class="form-control" id="amountAccessory"
                                                                           placeholder="<spring:message code="message.form.amount.placeholder"/>"
                                                                           type="number"
                                                                           value="${accessory.amount}"/>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${!isForTemplate || isForTemplate==null}">
                                    <div class="form-row">
                                        <div class="form-group col-lg-4 col-md-6">
                                            <label for="cost"><spring:message
                                                    code="message.orders.column.cost"/></label>
                                            <security:authorize access="hasRole('ADMIN')">
                                                <div class="form-group " id="group_cost">
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <div class="input-group-text">
                                                                <i class="tim-icons icon-coins text-primary"></i>
                                                            </div>
                                                        </div>
                                                        <input id="cost" type="number"
                                                               class="form-control"
                                                               name="cost" value="${model.cost}"/>
                                                    </div>
                                                    <div class="form-text text-danger" id="error_cost"></div>
                                                </div>
                                            </security:authorize>
                                            <security:authorize access="!hasRole('ADMIN')">
                                                <div class="form-group">
                                                    <h3>
                                                        <i class="tim-icons icon-coins text-primary"></i>
                                                        <span id="costCart">${model.cost}</span>
                                                    </h3>
                                                    <div class="form-text text-danger" id="error_cost"></div>
                                                </div>
                                            </security:authorize>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="form-row">
                                    <div class="form-group col">
                                        <c:if test="${!isForTemplate || isForTemplate==null}">
                                            <button type="button" class="btn btn-primary animation-on-hover"
                                                    id="calculate">
                                                <spring:message code="message.form.button.calculate"/>
                                            </button>
                                        </c:if>
                                        <security:authorize access="!isAuthenticated()">
                                            <button type="button" class="btn btn-success animation-on-hover"
                                                    id="formOrder" data-toggle="modal"
                                                    data-target="#exampleModal"><spring:message
                                                    code="message.orders.button.formOrder"/>
                                            </button>
                                        </security:authorize>
                                        <security:authorize access="hasRole('USER')">
                                            <button type="button" class="btn btn-success animation-on-hover"
                                                    id="addToCart"><spring:message
                                                    code="message.form.button.addToCart"/>
                                            </button>
                                        </security:authorize>
                                        <security:authorize access="hasRole('ADMIN')">
                                            <c:choose>
                                                <c:when test="${isForTemplate}">
                                                    <button type="button" class="btn btn-success animation-on-hover"
                                                            id="addTemplate"><spring:message
                                                            code="message.form.button.save"/>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="btn btn-success animation-on-hover"
                                                            id="addOrder"><spring:message
                                                            code="message.form.button.save"/>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </security:authorize>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="form-row align-items-center">
                        <div class="form-group col-lg-8 col-md-12">
                            <div id="placeholderFormOrder">
                            </div>
                        </div>
                    </div>
                </div>
                <security:authorize access="!hasRole('ADMIN')">
                    <div class="col-lg-2">
                    </div>
                </security:authorize>
            </div>
            <div id="footerGroup">
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
<!-- Black Dashboard DEMO methods, don't include it in your project! -->
<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>
<script type="text/javascript">

    messages = {};
    messages['placeholderAmount'] = "<spring:message code="message.form.amount.placeholder" javaScriptEscape="true"/>";
    messages['processing_processing'] = "<spring:message code="message.enum.processingType.processing" javaScriptEscape="true"/>";
    messages['processing_facet'] = "<spring:message code="message.enum.processingType.facet" javaScriptEscape="true"/>";
    messages['processing_hole'] = "<spring:message code="message.enum.processingType.hole" javaScriptEscape="true"/>";
    messages["loadingData"] = "<spring:message code="message.notification.loadingData.failure" javaScriptEscape="true"/>";
    messages["firstRow"] = "<spring:message code="message.notification.firstRow" javaScriptEscape="true"/>";
    messages["message.notEmpty.calculator.cost"] = "<spring:message code="message.notEmpty.calculator.cost" javaScriptEscape="true"/>";
    messages["successCreation"] = "<spring:message code="message.order.successCreation" javaScriptEscape="true"/>";

    messages['successfulRequest'] = "<spring:message code="message.notification.modalSend.success" javaScriptEscape="true"/>";
    messages['failRequest'] = "<spring:message code="message.notification.modalSend.failure" javaScriptEscape="true"/>";
    messages["message.notEmpty.customer.name"] = "<spring:message code="message.notEmpty.customer.name" javaScriptEscape="true"/>";
    messages["message.notEmpty.customer.phone"] = "<spring:message code="message.notEmpty.customer.phone" javaScriptEscape="true"/>";
    messages["message.notEmpty.modal.message"] = "<spring:message code="message.notEmpty.modal.message" javaScriptEscape="true"/>";
    messages["message.notMatches.customer.phone"] = "<spring:message code="message.notMatches.customer.phone" javaScriptEscape="true"/>";

</script>
<script src="${pageContext.request.contextPath}/resources/js/custom/notification.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/custom/calculator.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        <security:authorize access="hasRole('ADMIN')">
        <c:choose>
        <c:when test="${isForTemplate}">
        $("#catalogSection").addClass("active");
        </c:when>
        <c:otherwise>
        $("#orderSection").addClass("active");
        </c:otherwise>
        </c:choose>
        </security:authorize>
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>
