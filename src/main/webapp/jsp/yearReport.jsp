<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Year report</title>
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

<jsp:useBean id="yearReport" class="java.util.ArrayList" scope="session"/>

<div class="container-fluid" style="position: relative; top: 8rem;">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="col-md-12" style="padding-right: 0px">
                <legend>Year report:
                    <a class="btn btn-black btn-black-outline" style="float: right" href="${pageContext.request.contextPath}/Download?report=year_report">DOWNLOAD THIS TABLE</a>
                </legend>
            </div>
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <td>#</td>
                    <td>Month:</td>
                    <td>Orders:</td>
                    <td>Profit:</td>
                </tr>
                <c:forEach items="${yearReport}" var="list" varStatus="loop">
                    <tr>
                        <td>${loop.index+1}</td>
                        <td>${list.getMonth()}</td>
                        <td>${list.getOrders()}</td>
                        <td>${list.getProfit()} BYN</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
