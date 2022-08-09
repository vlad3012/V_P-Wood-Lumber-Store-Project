<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<body>
<div class="modal fade modal-black" id="exampleModal" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel"><spring:message code="message.navbar.modal.header"/></h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    <i class="tim-icons icon-simple-remove"></i>
                </button>
            </div>
            <div class="modal-body">
                <form id="questionForm">
                    <div class="form-group" id="group_name">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text text-primary">
                                    <i class="tim-icons icon-single-02"></i>
                                </div>
                            </div>
                            <input type="email" class="form-control" id="name"
                                   placeholder="<spring:message code="message.form.nameModal.placeHolder"/>">
                        </div>
                        <div class="form-text text-danger" id="error_name"></div>
                    </div>
                    <div class="form-group" id="group_email">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text text-primary">
                                    <i class="tim-icons icon-email-85"></i>
                                </div>
                            </div>
                            <input type="email" class="form-control" id="email"
                                   placeholder="<spring:message code="message.form.email.placeHolder"/>">
                        </div>
                        <div class="form-text text-danger" id="error_email"></div>
                    </div>
                    <div class="form-group" id="group_phone">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text text-primary">
                                    <i class="tim-icons icon-mobile"></i>
                                </div>
                            </div>
                            <input type="text" class="form-control" id="phone"
                                   placeholder="+375(99) 999-99-99">
                        </div>
                        <div class="form-text text-danger" id="error_phone"></div>
                    </div>
                    <div class="form-group" id="group_topic">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text text-primary">
                                    <i class="tim-icons icon-notes"></i>
                                </div>
                            </div>

                            <input type="text" class="form-control" id="topic"
                                   placeholder=" <spring:message code="message.form.topic.placeholder"/>">
                        </div>
                        <div class="form-text text-danger" id="error_topic"></div>
                    </div>
                    <div class="form-group" id="group_message">
                        <textarea class="form-control" id="message" rows="3"
                                  placeholder="<spring:message code="message.form.message.placeholder"/>"></textarea>
                        <div class="form-text text-danger" id="error_message"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary animation-on-hover"
                        id="sendRequest"
                        onclick="sendMessage()"><spring:message
                        code="message.navbar.modal.button.send"/>
                </button>
            </div>
        </div>
    </div>
</div>
<nav class="navbar navbar-expand-lg navbar-absolute navbar-transparent">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/main">WOOD.BY</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
            <span class="navbar-toggler-bar navbar-kebab"></span>
        </button>
        <div class="collapse navbar-collapse" id="navigation">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="${pageContext.request.contextPath}/main"><spring:message
                                    code="message.navbar.section.home"/><span class="sr-only">(current)</span></a>
                        </li>
                        <security:authorize access="!hasRole('ADMIN')">
                            <li class="nav-item">
                                <a class="nav-link"
                                   href="${pageContext.request.contextPath}/calculator/"><spring:message
                                        code="message.navbar.section.calculator"/></a>
                            </li>
                        </security:authorize>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/catalog/"><spring:message
                                    code="message.navbar.section.catalog"/></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/contacts"><spring:message
                                    code="message.navbar.section.contacts"/></a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown nav-item">
                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                        <i class="tim-icons icon-world"></i>
                        <p class="d-lg-none">
                            <spring:message code="message.navbar.lang.heading"/>
                        </p>
                    </a>
                    <ul class="dropdown-menu dropdown-navbar">
                        <li class="nav-link">
                            <a href="?lang=en" class="nav-item dropdown-item">
                                <div class="photo">
                                    <img src="${pageContext.request.contextPath}/resources/img/united-kingdom.png"
                                         alt="En" id="englishIcon">
                                </div>
                                <spring:message code="message.navbar.lang.en"/>
                            </a>
                        </li>
                        <li class="nav-link">
                            <a href="?lang=ru" class="nav-item dropdown-item">
                                <div class="photo">
                                    <img src="${pageContext.request.contextPath}/resources/img/russia.png"
                                         alt="Ru" id="russianIcon">
                                </div>
                                <spring:message code="message.navbar.lang.ru"/>
                            </a>
                        </li>
                    </ul>
                </li>
                <security:authorize access="hasRole('USER')">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/cart/"
                           class="btn btn-primary btn-round animation-on-hover">
                            <i class="tim-icons icon-cart"></i> <spring:message code="message.navbar.section.cart"/>
                        </a>
                    </li>
                </security:authorize>
                <security:authorize access="!hasRole('ADMIN')">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/main/#questionForm" class="btn btn-info btn-simple"
                           data-toggle="modal"
                           data-target="#exampleModal"><spring:message code="message.navbar.button.callRequest"/></a>
                    </li>
                </security:authorize>
                <security:authorize access="!isAuthenticated()">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/login"
                           class="btn btn-primary btn-simple"><spring:message code="message.navbar.button.logIn"/></a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/signUp"
                           class="btn btn-warning btn-simple"><spring:message code="message.navbar.button.signUp"/></a>
                    </li>
                </security:authorize>
                <security:authorize access="isAuthenticated()">
                    <li class="dropdown nav-item">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                            <i class="tim-icons icon-single-02"></i>
                            <p class="d-lg-none">
                                <spring:message code="message.navbar.button.user"/>
                            </p>
                        </a>
                        <ul class="dropdown-menu dropdown-navbar">
                            <security:authorize access="hasRole('USER')">
                                <li class="nav-link"><a href="${pageContext.request.contextPath}/profile/"
                                                        class="nav-item dropdown-item"><spring:message
                                        code="message.navbar.button.profile"/></a></li>
                            </security:authorize>
                            <security:authorize access="hasRole('ADMIN')">
                                <li class="nav-link"><a href="${pageContext.request.contextPath}/order/all"
                                                        class="nav-item dropdown-item text-wrap"><spring:message
                                        code="message.navbar.button.adminDashboard"/></a>
                                </li>
                            </security:authorize>
                            <li class="dropdown-divider"></li>
                            <li class="nav-link"><a href="${pageContext.request.contextPath}/logout"
                                                    class="nav-item dropdown-item"> <spring:message
                                    code="message.navbar.button.logOut"/></a></li>
                        </ul>
                    </li>
                </security:authorize>
                <li class="separator d-lg-none"></li>
            </ul>
        </div>
    </div>
</nav>
<script src="${pageContext.request.contextPath}/resources/js/core/jquery.min.js"></script>
<script type="text/javascript">
</script>
<script src="${pageContext.request.contextPath}/resources/js/custom/notification.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/custom/callRequest.js"></script>
</body>
</html>
