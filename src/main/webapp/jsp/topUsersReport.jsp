<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Top users</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png" type="image/x-icon">
    <meta name="description" content="">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic&amp;subset=latin">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,700">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/et-line-font-plugin/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/bootstrap-material-design-font/css/material.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tether/tether.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/socicon/css/socicon.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css/animate.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dropdown/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mobirise/css/mbr-additional.css"
          type="text/css">

    <script src="${pageContext.request.contextPath}/js/web/assets/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/dropdown/script.min.js"></script>
</head>
<body>
<jsp:useBean id="user" class="entity.User" scope="session"/>
<c:choose>
    <c:when test="${user.getUsername() == null}">
        <c:redirect url="/"/>
    </c:when>
    <c:when test="${user.isAdmin()}">
        <jsp:include page="adminNavBar.jsp"/>
    </c:when>
    <c:when test="${user.isSimpleUser()}">
        <c:redirect url="/"/>
    </c:when>
</c:choose>

<%--<section id="ext_menu-9">--%>
    <%--<nav class="navbar navbar-dropdown">--%>
        <%--<div class="container">--%>
            <%--<div class="mbr-table">--%>
                <%--<div class="mbr-table-cell">--%>
                    <%--<div class="navbar-brand">--%>
                        <%--<a href="${pageContext.request.contextPath}" class="navbar-logo"><img--%>
                                <%--src="${pageContext.request.contextPath}/images/stork-express-logo-138x128-21.png"--%>
                                <%--alt="Stork Express"></a>--%>
                        <%--<a class="navbar-caption" href="${pageContext.request.contextPath}">Stork Express</a>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="mbr-table-cell">--%>
                    <%--<button class="navbar-toggler pull-xs-right hidden-md-up" type="button" data-toggle="collapse"--%>
                            <%--data-target="#exCollapsingNavbar">--%>
                        <%--<div class="hamburger-icon"></div>--%>
                    <%--</button>--%>
                    <%--<ul class="nav-dropdown collapse pull-xs-right nav navbar-nav navbar-toggleable-sm"--%>
                        <%--id="exCollapsingNavbar">--%>
                        <%--<li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/jsp/account.jsp">ACCOUNT</a></li>--%>
                        <%--<li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/ShowUsers">USERS</a></li>--%>
                        <%--<li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/ShowParcels">PARCELS</a></li>--%>
                        <%--&lt;%&ndash;<li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/jsp/about.jsp">ABOUT US</a></li>&ndash;%&gt;--%>
                        <%--<li class="nav-item dropdown">--%>
                            <%--<a class="dropdown-toggle nav-link link" style="background: transparent;"--%>
                               <%--data-toggle="dropdown" href="#">REPORTS--%>
                                <%--<span class="caret"></span></a>--%>
                            <%--<ul class="dropdown-menu" style="min-width: 100%;background: #282828;padding: 10px 10px 10px 20px;border-radius: 5px;">--%>
                                <%--<li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/TopUsers">TOP 20 USERS</a></li>--%>
                                <%--<li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/jsp/ordersOnDateReport.jsp">ORDERS ON DATE</a></li>--%>
                                <%--<li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/YearReport">YEAR REPORT</a></li>--%>
                            <%--</ul>--%>
                        <%--</li>--%>
                        <%--<li class="nav-item dropdown">--%>
                            <%--<a class="dropdown-toggle nav-link link" style="background: transparent;"--%>
                               <%--data-toggle="dropdown" href="#">STATISTICS--%>
                                <%--<span class="caret"></span></a>--%>
                            <%--<ul class="dropdown-menu" style="min-width: 100%;background: #282828;padding: 10px 10px 10px 20px;border-radius: 5px;">--%>
                                <%--<li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/UsersStat">USERS</a></li>--%>
                                <%--<li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/OrdersStat">ORDERS</a></li>--%>
                            <%--</ul>--%>
                        <%--</li>--%>
                        <%--<li class="nav-item nav-btn"><a class="nav-link btn btn-info" href="${pageContext.request.contextPath}/SignOut">Sign--%>
                            <%--Out</a></li>--%>
                    <%--</ul>--%>
                    <%--<button hidden="" class="navbar-toggler navbar-close" type="button" data-toggle="collapse"--%>
                            <%--data-target="#exCollapsingNavbar">--%>
                        <%--<div class="close-icon"></div>--%>
                    <%--</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</nav>--%>
<%--</section>--%>

<jsp:useBean id="topUsers" class="java.util.ArrayList" scope="session"/>

<div class="container-fluid" style="position: relative; top: 8rem;">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="col-md-12" style="padding-right: 0px">
                <legend>Top 20 users by profit:
                    <a class="btn btn-black btn-black-outline" style="float: right" href="${pageContext.request.contextPath}/Download?report=top_users">DOWNLOAD THIS TABLE</a>
                </legend>
            </div>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <td>#</td>
                        <td>User:</td>
                        <td>Profit:</td>
                    </tr>
                <c:forEach items="${topUsers}" var="list" varStatus="loop">
                    <tr>
                        <td>${loop.index+1}</td>
                        <td>${list.getUsername()}</td>
                        <td>${list.getProfit()}</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
