<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="frmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <div class="row align-items-center">
                <div class="col">
                    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0"
                                    class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="${pageContext.request.contextPath}/resources/img/main_wall.jpg"
                                     class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3><spring:message code="message.main.headingCarousel.partition"/></h3>
                                    <p><spring:message code="message.main.textCarousel"/></p>
                                    <a href="${pageContext.request.contextPath}/catalog/?productType=partition"
                                       class="btn btn-warning animation-on-hover"><spring:message
                                            code="message.main.button.goToCatalog"/></a>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/resources/img/main_lining.jpg"
                                     class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3><spring:message code="message.main.headingCarousel.lining"/></h3>
                                    <p><spring:message code="message.main.textCarousel"/></p>
                                    <a href="${pageContext.request.contextPath}/catalog/?productType=lining"
                                       class="btn btn-warning animation-on-hover"><spring:message
                                            code="message.main.button.goToCatalog"/></a>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="${pageContext.request.contextPath}/resources/img/main_board.jpg"
                                     class="d-block w-100" alt="...">
                                <div class="carousel-caption d-none d-md-block">
                                    <h3><spring:message code="message.main.headingCarousel.board"/></h3>
                                    <p><spring:message code="message.main.textCarousel"/></p>
                                    <a href="${pageContext.request.contextPath}/catalog/?productType=board"
                                       class="btn btn-warning animation-on-hover"><spring:message
                                            code="message.main.button.goToCatalog"/></a>
                                </div>
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden"><spring:message code="message.main.carousel.prev"/></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden"><spring:message code="message.main.carousel.next"/></span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col-lg-2">
                </div>
                <div class="col-lg-8">
                    <div class="card" style="margin-top: 2rem">
                        <div class="card-header">
                            <h1 class="card-title text-center"><spring:message code="message.main.header"/></h1>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><spring:message code="message.main.headerParagraph1"/></p>
                            <p class="card-text"><spring:message code="message.main.headerParagraph2"/></p>
                            <p class="card-text"><spring:message code="message.main.headerParagraph3"/></p>
                            <p class="card-text"><spring:message code="message.main.headerParagraph4"/></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
                </div>
            </div>
            <div class="row align-items-center">
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/lining.jpg"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.main.catalogSection.lining"/></h4>
                            <a href="${pageContext.request.contextPath}/catalog/?productType=lining"
                               class="btn btn-simple btn-warning btn-one">
                                <span><spring:message code="message.main.button.goToCatalog"/> <i
                                        class="tim-icons icon-double-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/wall.png"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.main.catalogSection.partition"/></h4>
                            <a href="${pageContext.request.contextPath}/catalog/?productType=partition"
                               class="btn btn-simple btn-warning btn-one">
                                <span><spring:message code="message.main.button.goToCatalog"/> <i
                                        class="tim-icons icon-double-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/board.png"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.main.catalogSection.board"/></h4>
                            <a href="${pageContext.request.contextPath}/catalog/?productType=board"
                               class="btn btn-simple btn-warning btn-one">
                                <span><spring:message code="message.main.button.goToCatalog"/> <i
                                        class="tim-icons icon-double-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="card">
                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/wood.jpg"
                             alt="Card image cap">
                        <div class="card-body">
                            <h4 class="card-title"><spring:message code="message.main.catalogSection.wood"/></h4>
                            <a href="${pageContext.request.contextPath}/catalog/?productType=wood"
                               class="btn btn-simple btn-warning btn-one">
                                <span><spring:message code="message.main.button.goToCatalog"/> <i
                                        class="tim-icons icon-double-right"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-2">
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title text-center"><spring:message code="message.main.advantages.header"/></h3>
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center mb-3">
                                <div class="col-2">
                                    <div class="card-text"><img
                                            src="${pageContext.request.contextPath}/resources/img/img_1.png"
                                            alt="Card image cap">
                                    </div>
                                </div>
                                <div class="col-10">
                                    <h6 class="card-text">
                                        <spring:message code="message.main.advantages.line1"/>
                                    </h6>
                                    <p class="card-text">
                                        <spring:message code="message.main.advantages.line1.description"/>
                                    </p>
                                </div>
                            </div>
                            <div class="row align-items-center mb-3">
                                <div class="col-2">
                                    <div class="card-text">
                                        <img src="${pageContext.request.contextPath}/resources/img/wood.png"
                                             alt="Card image cap">
                                    </div>
                                </div>
                                <div class="col-10">
                                    <h6 class="card-text">
                                        <spring:message code="message.main.advantages.line2"/>
                                    </h6>
                                    <p class="card-text">
                                        <spring:message code="message.main.advantages.line2.description"/>
                                    </p>
                                </div>
                            </div>
                            <div class="row align-items-center mb-3">
                                <div class="col-2">
                                    <div class="card-text">
                                        <img src="${pageContext.request.contextPath}/resources/img/wood.png"
                                             alt="Card image cap">
                                    </div>
                                </div>
                                <div class="col-10">
                                    <h6 class="card-text">
                                        <spring:message code="message.main.advantages.line3"/>
                                    </h6>
                                    <p class="card-text">
                                        <spring:message code="message.main.advantages.line3.description"/>
                                    </p>
                                </div>
                            </div>
                            <div class="row align-items-center mb-3">
                                <div class="col-2">
                                    <div class="card-text">
                                        <img src="${pageContext.request.contextPath}/resources/img/board.png"
                                             alt="Card image cap">
                                    </div>
                                </div>
                                <div class="col-10">
                                    <h6 class="card-text">
                                        <spring:message code="message.main.advantages.line4"/>
                                    </h6>
                                    <p class="card-text">
                                        <spring:message code="message.main.advantages.line4.description"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title text-center"><spring:message code="message.main.acts.header"/></h3>
                        </div>
                        <div class="card-body">

                            <ul>
                                <li><spring:message code="message.main.acts.line1"/>
                                </li>
                                <li><spring:message code="message.main.acts.line2"/></li>
                                <li><spring:message code="message.main.acts.line3"/>
                                </li>
                                <li><spring:message code="message.main.acts.line4"/></li>
                                <li><spring:message code="message.main.acts.line5"/></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2">
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
<%--<!-- Black Dashboard DEMO methods, don't include it in your project! -->--%>
<%--<script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>--%>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/js/custom/bootstrap.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $("#footerGroup").load("/resources/pagesToLoad/footer.html #footer");
    });
</script>
</body>
</html>