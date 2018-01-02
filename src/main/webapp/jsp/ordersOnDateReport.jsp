<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Orders on date</title>
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



<div class="container" style="margin-top: 6.5rem">
    <div class="row">
        <div class="col-md-8 col-md-offset-2" >
            <div class="form-group col-md-12" style="color: #ff0000; font-size: x-large">
                <c:out value="${sessionScope.DateError}"/>
                <c:remove var="DateError" scope="session"/>
            </div>
            <legend>Orders for date: </legend>
            <form role="form" method="POST" action="${pageContext.request.contextPath}/OrdersOnDate">

                <label for="day">Day:</label>
                <input maxlength="2" type="number" class="form-control" name="day" id="day" min="1" max="31" step="1"
                       required placeholder="15"
                       title="Enter day in digit form."
                       oninvalid="setCustomValidity('Wrong day form. Only digits, please. ')"
                       onchange="try{setCustomValidity('')}catch(e){}">

                <label for="month">Month:</label>
                <input maxlength="2" type="number" class="form-control" name="month" id="month" min="1" max="12" step="1"
                       required placeholder="12" value="12"
                       title="Enter month in digit form."
                       oninvalid="setCustomValidity('Wrong month form. Only digits, please.')"
                       onchange="try{setCustomValidity('')}catch(e){}">

                <label for="year">Year:</label>
                <input maxlength="4" type="number" class="form-control" name="year" id="year" min="0" max="2018" step="1"
                       required placeholder="2017" value="2017"
                       title="Enter month in digit form."
                       oninvalid="setCustomValidity('Wrong year form. Only digits, please.')"
                       onchange="try{setCustomValidity('')}catch(e){}">


                <div class="form-group">
                    <div class="col-md-12" style="padding-left: 0px">
                        <button type="submit" style="margin-top: 0.7rem" class="btn btn-primary">
                            Get orders
                        </button>
                        <a style="margin-top: 0.7rem" class="btn btn-black btn-black-outline"
                           href=""
                        onclick="if (document.getElementById('day').value.length > 0 && document.getElementById('month').value.length > 0
                         && document.getElementById('year').value.length > 0){
                         this.href='${pageContext.request.contextPath}/Download?report=orders_on_date&day='+document.getElementById('day').value+
                                '&month='+document.getElementById('month').value+'&year='+document.getElementById('year').value
                         }else alert('Please, fill up all fields.');
                                ">
                            DOWNLOAD THIS TABLE
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:useBean id="ordersOnDate" class="java.util.ArrayList" scope="session"/>
<jsp:useBean id="countOrdersOnDate" class="java.lang.String" scope="session"/>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <legend>Found ${countOrdersOnDate} orders:</legend>
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <td>#</td>
                    <td>User:</td>
                    <td>Profit:</td>
                    <td>Currency:</td>
                    <td>Date:</td>
                </tr>
                <c:forEach items="${ordersOnDate}" var="list" varStatus="loop">
                    <tr>
                        <td>${loop.index+1}</td>
                        <td>${list.getUsername()}</td>
                        <td>${list.getTotalCost()}</td>
                        <td>${list.getCurrency()}</td>
                        <td>${list.getDate()}</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
