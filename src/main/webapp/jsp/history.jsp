
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>History</title>
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
<c:if test="${user.getUsername() == null || !user.isSimpleUser()}">
    <c:redirect url="/"></c:redirect>
</c:if>

<c:choose>
    <c:when test="${user.getUsername() == null}">
        <c:redirect url="/"/>
    </c:when>
    <c:when test="${user.isAdmin()}">
        <c:redirect url="/"/>
    </c:when>
    <c:when test="${user.isSimpleUser()}">
        <jsp:include page="userNavBar.jsp"/>
    </c:when>
</c:choose>

<div class="col-md-12" style="position: relative; top: 8rem;">
    <legend>Your orders:</legend>
    <table class="table table-bordered">
        <%--Шапка таблицы. Не менять--%>
        <thead>
        <tr>
            <th>#</th>
            <th><b>ID</b></th>
            <th>Parcels count</th>
            <%--TODO <th>Total weight</th>--%>
            <th>Total cost, BYN</th>
            <th>Total cost, ${order.getCurrency()}</th>
            <th>Date</th>
        </tr>
        </thead>
            <tbody>
            <%-- Прикрутить forEach по Orders--%>
            <%-- в  data-target="#collapse..N.." N задавать номером оредера  --%>
            <c:forEach items="${user.getOrders()}" var="order" varStatus="loop">
                <tr class="accordion-toggle" data-toggle="collapse" data-target="#collapse${loop.index}" style="cursor: pointer">
                    <td>${loop.index + 1}</td>
                    <td><b>${order.getId()}</b></td>
                    <td>${order.getParcels().size()}</td>
                    <%--<td>TODO TotalWeight kg</td>--%>
                    <td>${order.getTotalCost()} BYN</td>
                    <td>${order.getConversionTotalCost()} ${order.getCurrency()}</td>
                    <td>${order.getDate()}</td>
                </tr>
                <%-- forEach по ордерс заканчивается--%>
                <tr>
                    <td colspan="6" style="padding: 0px">
                        <%-- id="collapse..N.." то же самое N, что и выше  --%>
                        <div id="collapse${loop.index}" class="panel-collapse collapse">
                            <table width="100%">
                                <%-- Шапка второй, вложенной таблицы. Тоже не менять--%>
                                <tr style="background: rgba(228, 226, 224, 0.29);">
                                    <td>#</td>
                                    <td>Parcel name</td>
                                    <td>Weight</td>
                                    <td>From</td>
                                    <td>To</td>
                                    <td>Express</td>
                                    <td>Status</td>
                                    <td>Price, BYN</td>
                                    <td>Price, ${order.getCurrency()}</td>
                                </tr>
                                <%--Конец второй, вложенной таблицы.--%>
                                <%--Прикрутить forEach по Parcels по конкретному Order.. --%>
                                    <%--<jsp:useBean id="order" class="entity.Order" scope="page"/>--%>
                                    <c:forEach items="${order.getParcels()}" var="parcel" varStatus="loop2">
                                        <tr>
                                            <%--<td>${i + 1}</td>--%>
                                            <td>${loop2.index+1}</td>
                                            <td><c:out value="${parcel.getDescription()}"/></td>
                                            <td>${parcel.getWeight()} kg</td>
                                            <td>${parcel.getFromCountry()}</td>
                                            <td>${parcel.getToCountry()}</td>
                                            <td>${parcel.isExpress()}</td>
                                            <td>${parcel.getState()}</td>
                                            <td>${parcel.getCost()} BYN</td>
                                            <td>${parcel.getConversionCost()} ${parcel.getCurrency()}</td>
                                        </tr>
                                    </c:forEach>
                            </table>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
</div>

</body>
</html>
