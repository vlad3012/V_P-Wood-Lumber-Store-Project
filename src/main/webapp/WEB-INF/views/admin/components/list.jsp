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
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"><spring:message
                                    code="message.enum.componentType.${componentType.name}.plural"/></h4>
                        </div>
                        <div class="card-body">
                            <div>
                                <spring:url value="/component/${componentType.name}/add" var="componentAddUrl"/>
                                <a href="${componentAddUrl}" class="btn btn-primary animation-on-hover"><spring:message
                                        code="message.form.button.add"/></a>
                            </div>
                            <div class="table-full-width ps ps--active-y ps--scrolling-y">
                                <table class="table tablesorter">
                                    <thead>
                                    <tr>
                                        <c:if test="${componentType.name.equals('processing')}">
                                            <th><spring:message code="message.component.column.type"/></th>
                                        </c:if>
                                        <th><spring:message code="message.component.column.name"/></th>
                                        <c:if test="${componentType.name.equals('woodType')}">
                                            <th><spring:message code="message.component.column.thickness"/></th>
                                        </c:if>
                                        <c:if test="${componentType.name.equals('processing')}">
                                            <th><spring:message code="message.component.column.symbol"/></th>
                                        </c:if>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${componentList}" varStatus="counter">
                                        <tr>
                                            <td style="display:none;">${item.id}</td>
                                            <c:if test="${componentType.name.equals('processing')}">
                                                <td><spring:message code="message.enum.processingType.${item.type.name}"/></td>
                                            </c:if>
                                            <td>${item.name}</td>
                                            <c:if test="${componentType.name.equals('woodType')}">
                                                <td>${item.thickness}</td>
                                            </c:if>
                                            <c:if test="${componentType.name.equals('processing')}">
                                                <td>${item.symbol}</td>
                                            </c:if>
                                            <td class="td-actions text-right">
                                                <spring:url value="/component/${componentType.name}/${item.id}/delete"
                                                            var="deleteUrl"/>
                                                <spring:url value="/component/${componentType.name}/${item.id}/update"
                                                            var="updateUrl"/>
                                                <button type="button" rel="tooltip"
                                                        class="btn btn-link btn-success btn-sm btn-icon"
                                                        onclick="location.href='${updateUrl}'">
                                                    <i class="tim-icons icon-pencil"></i>
                                                </button>
                                                <button type="button" rel="tooltip"
                                                        class="btn btn-link btn-danger btn-sm btn-icon"
                                                        onclick="post('${deleteUrl}')">
                                                    <i class="tim-icons icon-simple-remove"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
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

<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>

<script type="text/javascript">
    $(document).ready(function () {
        $("#componentSection").addClass("active");
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });

    function post(path, params, method) {
        method = method || "post";

        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);

        for (var key in params) {
            if (params.hasOwnProperty(key)) {
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", key);
                hiddenField.setAttribute("value", params[key]);

                form.appendChild(hiddenField);
            }
        }

        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>
