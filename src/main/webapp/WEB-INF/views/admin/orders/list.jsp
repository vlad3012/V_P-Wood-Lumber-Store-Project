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
    <%--    <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/resources/img/apple-icon.png">--%>
    <%--    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/img/favicon.png">--%>
    <title>
        Orders
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
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><spring:message code="message.orders.heading"/></h3>
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-lg-12">
                                    <label style="margin-right: 1rem"><spring:message
                                            code="message.orders.filter.label"/></label>
                                    <a type="button" class="btn btn-success btn-link"
                                       href="${pageContext.request.contextPath}/order/all?filter=all">
                                            <span>
                                                <i class="tim-icons icon-bullet-list-67"></i> <spring:message
                                                    code="message.orders.filter.all"/>
                                                <c:if test="${orderStatusCount.all != 0}">
                                                    <span class="badge badge-default">${orderStatusCount.all}</span>
                                                </c:if>
                                            </span>
                                    </a>
                                    <a type="button" class="btn btn-info btn-link"
                                       href="${pageContext.request.contextPath}/order/all?filter=active">
                                            <span>
                                                <i class="tim-icons icon-chart-pie-36"></i> <spring:message
                                                    code="message.orders.filter.active"/>
                                                <c:if test="${orderStatusCount.active != 0}">
                                                    <span class="badge badge-default">${orderStatusCount.active}</span>
                                                </c:if>
                                            </span>
                                    </a>
                                    <a type="button" class="btn btn-warning btn-link"
                                       href="${pageContext.request.contextPath}/order/all?filter=paid">
                                            <span>
                                                <i class="tim-icons icon-money-coins"></i> <spring:message
                                                    code="message.orders.filter.paid"/>
                                                <c:if test="${orderStatusCount.paid != 0}">
                                                    <span class="badge badge-default">${orderStatusCount.paid}</span>
                                                </c:if>
                                             </span>
                                    </a>
                                    <a type="button" class="btn btn-danger btn-link"
                                       href="${pageContext.request.contextPath}/order/all?filter=expired">
                                            <span>
                                                <i class="tim-icons icon-alert-circle-exc"></i> <spring:message
                                                    code="message.orders.filter.expired"/>
                                                <c:if test="${expiredOrderCount != 0}">
                                                    <span class="badge badge-default">${expiredOrderCount}</span>
                                                </c:if>
                                            </span>
                                    </a>
                                    <a type="button" class="btn btn-primary btn-link"
                                       href="${pageContext.request.contextPath}/order/all?filter=closed">
                                            <span>
                                                <i class="tim-icons icon-button-power"></i> <spring:message
                                                    code="message.orders.filter.closed"/>
                                                <c:if test="${orderStatusCount.closed != 0}">
                                                    <span class="badge badge-default">${orderStatusCount.closed}</span>
                                                </c:if>
                                            </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <div>
                                <a href="${pageContext.request.contextPath}/order/"
                                   class="btn btn-primary animation-on-hover"><spring:message
                                        code="message.form.button.add"/></a>
                            </div>
                            <div class="table-full-width table-responsive ps ps--active-y ps--scrolling-y">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center">#</th>
                                        <th><spring:message code="message.orders.column.name"/></th>
                                        <th><spring:message code="message.orders.column.product"/></th>
                                        <th><spring:message code="message.orders.column.status"/></th>
                                        <th><spring:message code="message.orders.column.date"/></th>
                                        <th><spring:message code="message.orders.column.deadline"/></th>
                                        <th class="text-right"><spring:message code="message.orders.column.cost"/></th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="order" items="${orders.pageList}" varStatus="status">
                                        <tr>
                                            <td class="text-center">${(orders.firstElementOnPage+status.count)}</td>
                                            <td>${order.customer.name}</td>
                                            <td><spring:message
                                                    code="message.enum.productType.${order.productType.name}"/></td>
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
                                                    code="message.enum.orderStatus.${order.status.name}"/></span>
                                            </td>
                                            <td>${order.creationDateFormat}</td>
                                            <td class="${order.expired ? 'text-danger' : ''}">${order.deadlineFormat}</td>
                                            <td class="text-right">${order.cost}</td>
                                            <td class="td-actions text-right">
                                                <spring:url value="/order/${order.id}" var="orderUrl"/>
                                                <spring:url
                                                        value="/order/${order.id}/delete?filter=${param.filter}&page=${orders.page+1}"
                                                        var="deleteUrl"/>
                                                <spring:url value="/order/${order.id}/update" var="updateUrl"/>

                                                <button type="button" rel="tooltip"
                                                        class="btn btn-link btn-primary btn-sm btn-icon"
                                                        onclick="location.href='${orderUrl}'">
                                                    <i class="tim-icons icon-tap-02"></i>
                                                </button>
                                                <c:if test="${!order.status.name.equals('closed')}">
                                                    <button type="button" rel="tooltip"
                                                            class="btn btn-link btn-success btn-sm btn-icon"
                                                            onclick="location.href='${updateUrl}'">
                                                        <i class="tim-icons icon-pencil"></i>
                                                    </button>
                                                </c:if>
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
                        <div class="card-footer">
                            <ul class="pagination">
                                <c:forEach begin="1" end="${orders.pageCount}" step="1" varStatus="tagStatus">
                                    <li class="page-item ${tagStatus.current==(orders.page+1) ? 'active' : ''}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/order/all?filter=${param.filter}&page=${tagStatus.current}">${tagStatus.current}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footerGroup"></div>
        </div>

    </div>
</div>
<div class="fixed-plugin">
    <div class="dropdown show-dropdown">
        <a href="#" data-toggle="dropdown">
            <i class="fa fa-cog fa-2x"> </i>
        </a>
        <ul class="dropdown-menu">
            <li class="header-title"> Sidebar Background</li>
            <li class="adjustments-line text-center color-change">
                <span class="color-label">LIGHT MODE</span>
                <span class="badge light-badge mr-2"></span>
                <span class="badge dark-badge ml-2"></span>
                <span class="color-label">DARK MODE</span>
            </li>
        </ul>
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

        $().ready(function () {
            $sidebar = $('.sidebar');
            $navbar = $('.navbar');
            $main_panel = $('.main-panel');

            $full_page = $('.full-page');

            $sidebar_responsive = $('body > .navbar-collapse');
            sidebar_mini_active = true;
            white_color = false;

            window_width = $(window).width();

            fixed_plugin_open = $('.sidebar .sidebar-wrapper .nav li.active a p').html();


            $('.fixed-plugin a').click(function (event) {
                if ($(this).hasClass('switch-trigger')) {
                    if (event.stopPropagation) {
                        event.stopPropagation();
                    } else if (window.event) {
                        window.event.cancelBubble = true;
                    }
                }
            });

            $('.fixed-plugin .background-color span').click(function () {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');

                var new_color = $(this).data('color');

                if ($sidebar.length != 0) {
                    $sidebar.attr('data', new_color);
                }

                if ($main_panel.length != 0) {
                    $main_panel.attr('data', new_color);
                }

                if ($full_page.length != 0) {
                    $full_page.attr('filter-color', new_color);
                }

                if ($sidebar_responsive.length != 0) {
                    $sidebar_responsive.attr('data', new_color);
                }
            });

            $('.switch-sidebar-mini input').on("switchChange.bootstrapSwitch", function () {
                var $btn = $(this);

                if (sidebar_mini_active == true) {
                    $('body').removeClass('sidebar-mini');
                    sidebar_mini_active = false;
                    blackDashboard.showSidebarMessage('Sidebar mini deactivated...');
                } else {
                    $('body').addClass('sidebar-mini');
                    sidebar_mini_active = true;
                    blackDashboard.showSidebarMessage('Sidebar mini activated...');
                }

                // we simulate the window Resize so the charts will get updated in realtime.
                var simulateWindowResize = setInterval(function () {
                    window.dispatchEvent(new Event('resize'));
                }, 180);

                // we stop the simulation of Window Resize after the animations are completed
                setTimeout(function () {
                    clearInterval(simulateWindowResize);
                }, 1000);
            });

            $('.switch-change-color input').on("switchChange.bootstrapSwitch", function () {
                var $btn = $(this);

                if (white_color == true) {

                    $('body').addClass('change-background');
                    setTimeout(function () {
                        $('body').removeClass('change-background');
                        $('body').removeClass('white-content');
                    }, 900);
                    white_color = false;
                } else {

                    $('body').addClass('change-background');
                    setTimeout(function () {
                        $('body').removeClass('change-background');
                        $('body').addClass('white-content');
                    }, 900);

                    white_color = true;
                }


            });

            $('.light-badge').click(function () {
                $('body').addClass('white-content');
            });

            $('.dark-badge').click(function () {
                $('body').removeClass('white-content');
            });
        });
    });
</script>
</body>

</html>
