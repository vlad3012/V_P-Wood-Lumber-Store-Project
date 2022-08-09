<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.example.lumberstore.additional.enums.ComponentType" %>
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
    <title>Component</title>
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
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title"><spring:message
                            code="message.enum.componentType.${componentType.name}.info"/></h4>
                </div>
                <div class="card-body">
                    <spring:url value="/component/${componentType.name}/save" var="componentAdd"/>
                    <form:form method="post" action="${componentAdd}">
                        <input name="id" value="${component.id}" type="hidden" class="form-control" id="id"/>
                        <c:if test="${componentType.name.equals('processing')}">
                            <div class="form-group col-lg-6">
                                <label for="name"><spring:message code="message.component.column.type"/></label>
                                <select name="type" type="text"
                                        class="form-control" id="type">

                                    <c:forEach items="${processingTypes}" var="type">
                                        <c:set var="selected" value=""/>
                                        <c:if test="${type.name.equals(component.type.name)}">
                                            <c:set var="selected" value="selected"/>
                                        </c:if>
                                        <option value="${type.name}" ${selected}><spring:message
                                                code="message.enum.processingType.${type.name}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </c:if>
                        <div class="form-group col-lg-6">
                            <label for="name"><spring:message code="message.form.nameComponent.label"/></label>
                            <input name="name" value="${component.name}" type="text" class="form-control" id="name"
                                   placeholder="<spring:message code="message.form.nameComponent.placeholder"/>"/>
                        </div>
                        <c:if test="${componentType.name.equals('woodType')}">
                            <div class="form-group col-lg-6">
                                <label for="name"><spring:message code="message.form.thickness.label"/></label>
                                <input name="diameter" value="${component.thickness}" type="number"
                                       class="form-control" id="diameter"
                                       placeholder="<spring:message code="message.form.thickness.placeholder"/>"/>
                            </div>
                        </c:if>
                        <c:if test="${componentType.name.equals('processing')}">
                            <div class="form-group col-lg-6">
                                <label for="name"><spring:message code="message.form.symbol.label"/></label>
                                <input name="symbol" value="${component.symbol}" type="text" class="form-control"
                                       id="symbol"
                                       placeholder="<spring:message code="message.form.symbol.placeholder"/>"/>
                            </div>
                        </c:if>
                        <button type="submit" class="btn btn-primary animation-on-hover"><spring:message
                                code="message.form.button.save"/></button>
                    </form:form>
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
