<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>About us</title>
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
            <jsp:include page="guestNavBar.jsp"/>
        </c:when>
        <c:when test="${user.isAdmin()}">
            <jsp:include page="adminNavBar.jsp"/>
        </c:when>
        <c:when test="${user.isSimpleUser()}">
            <jsp:include page="userNavBar.jsp"/>
        </c:when>
    </c:choose>

<section class="mbr-section mbr-section-hero mbr-section-full mbr-parallax-background mbr-after-navbar" id="header1-i"
         style="background-image: url(${pageContext.request.contextPath}/images/photo-1445865272827-4894eb9d48de-2000x1333-50.jpg);">

    <div class="mbr-overlay" style="opacity: 0.5; background-color: rgb(0, 0, 0);"></div>

    <div class="mbr-table-cell">

        <div class="container">
            <div class="row">
                <div class="mbr-section col-md-10 col-md-offset-1 text-xs-center">

                    <h1 class="mbr-section-title display-1">ABOUT US</h1>
                    <p class="mbr-section-lead lead">Windows talking painted pasture yet its express parties use. Sure
                        last upon he same as knew next. Of believed or diverted no rejoiced. End friendship sufficient
                        assistance can prosperous met. As game he show it park do. Was has unknown few certain ten
                        promise. No finished my an likewise cheerful packages we. For assurance concluded son something
                        depending discourse see led collected. Packages oh no denoting my advanced humoured. Pressed be
                        so thought natural. <br><br>View fine me gone this name an rank. Compact greater and demands mrs
                        the parlors. Park be fine easy am size away. Him and fine bred knew. At of hardly sister favour.
                        As society explain country raising weather of. Sentiments nor everything off out uncommonly
                        partiality bed.&nbsp;<br></p>

                </div>
            </div>
        </div>
    </div>


</section>
</body>
</html>
