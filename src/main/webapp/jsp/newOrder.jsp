<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="crud.CurrencyController.*" %>
<html>
<head>
    <title>New Order</title>
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

    <style>
        .modal-dialog {
            width: 900px;
            margin: 6% auto; }
    </style>

</head>
<body>

<jsp:useBean id="user" class="entity.User" scope="session"/>
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

<jsp:useBean id="countries" class="java.util.ArrayList" scope="session"/>
<jsp:useBean id="currencies" class="java.util.ArrayList" scope="session"/>

<div class="container-fluid" style="position: relative; top: 8rem;">
    <div class="row">
        <div class="col-md-4">
            <form action="${pageContext.request.contextPath}/AddParcel" method="post"
                  onsubmit="
                  document.getElementById('currency').disabled = false;
                  var e = document.getElementById('currency');
                var selectedCurrency = e.options[e.selectedIndex].value;
                localStorage.setItem('selectedCurrency', selectedCurrency);
                ">
            <fieldset>
                <div class="form-group col-md-12" style="color: #ff0000">
                    <c:out value="${sessionScope.ParcelError}"/>
                    <c:remove var="ParcelError" scope="session"/>
                </div>
                <legend>Add information about your parcel:</legend>

                    <label for="description">Description:</label>
                    <input maxlength="30" type="text" class="form-control" name="description" id="description" required
                           placeholder="Parcel with..."  pattern="^[a-zA-Z][a-zA-Z0-9 ]{2,30}$"
                           title="Enter your description. First character only letter. Other - letters or digits. From 3 to 30 characters."
                           oninvalid="setCustomValidity('Wrong description.' +
                                ' First character only letter. Other - letters or digits. From 3 to 30 characters.')"
                           oninput="try{setCustomValidity('')}catch(e){}">

                    <label for="weight">Weight:</label>
                    <input maxlength="3" type="number" class="form-control" name="weight" id="weight" min="0.1" max="100" step="0.1"
                           required placeholder="1.5 kg"
                           title="Only digits. Min weight - 0.1 kg, max weight - 100 kg."
                           oninvalid="setCustomValidity('Wrong weight.' +
                                ' Only digits. Min weight - 0.1 kg, max weight - 100 kg.')"
                           oninput="try{setCustomValidity('')}catch(e){}">

                    <label for="from">I will send it from...</label>
                    <select name="fromCountry" id="from" required class="form-control">
                        <c:forEach items="${countries}" var="country">
                            <option value="${country.getId()}">${country.getCountryNameEN()}</option>
                        </c:forEach>
                    </select>
                    <label for="to">Country destination...</label>
                    <select name="toCountry" id="to" required class="form-control">
                        <c:forEach items="${countries}" var="country">
                            <option value="${country.getId()}">${country.getCountryNameEN()}</option>
                        </c:forEach>
                    </select>

                    <label for="recipient">This parcel will receive</label>
                    <input maxlength="30" type="text" class="form-control" name="recipient" id="recipient" required
                           placeholder="Recipient's name" pattern="^[A-Z][a-z]{3,29}[a-zA-Z. ]{0,29}$"
                           title="Enter the recipient's name. The first letter should be capitalized. Only letters, spaces and dots. From 3 to 30 characters."
                           oninvalid="setCustomValidity('Wrong name format.' +
                                ' The first letter should be capitalized. Only letters, spaces and dots. From 3 to 30 characters.' +
                                ' For example: Donald Trump, Trump D., Trump.')"
                           oninput="try{setCustomValidity('')}catch(e){}">

                <label for="currency">Choose currency:</label>
                <div class="form-group">
                    <div class="checkbox">
                        <label style="margin-top: 15px; padding-left: 30px;">
                            <input type="checkbox" name="express" id="express" style="transform: scale(2.0)"/> Express
                        </label>
                        <div class="col-md-4 mbr-section-btn" style="padding-left: 0px">
                            <select name="currency" id="currency" required class="form-control">
                            <c:forEach items="${currencies}" var="currency">
                                <option value="${currency.getCurrencyAbbreviation()}">${currency.getCurrencyAbbreviation()}</option>
                            </c:forEach>
                        </select>
                        </div>
                        <a class="btn btn-black btn-black-outline" style="float: left;margin-left: -0.9rem;padding: 15px;
                        background-color: #f5f5f5;border: 1px solid #e8e8e8;font-family: 'Raleway', sans-serif;margin-right: 1rem;
                        border-left-color: #ccc;"
                           data-toggle="modal" data-target="#myModal"
                        >INFO</a>
                        <button type="submit" class="btn btn-primary" style="float: right;">
                            Add
                        </button>
                    </div>
                </div>
            </fieldset>
            </form>
        </div>


        <jsp:useBean id="order" class="entity.Order" scope="session"/>
        <jsp:useBean id="parcel" class="entity.Parcel" scope="session"/>

        <div class="col-md-8">
            <legend>Your order</legend>
            <div class="form-group col-md-12" style="color: #ff0000">
                <c:out value="${sessionScope.ErrorMessage}"/>
                <c:remove var="ErrorMessage" scope="session"/>
            </div>
            <table class="table table-bordered" style="margin-top: 40px">
                <thead>
                <tr>
                    <th>
                        #
                    </th>
                    <th>
                        Description
                    </th>
                    <th>
                        Weight
                    </th>
                    <th>
                        From
                    </th>
                    <th>
                        To
                    </th>
                    <th>
                        Recipient
                    </th>
                    <th>
                        Express
                    </th>
                    <th>
                        Price
                    </th>
                    <th>
                        del
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${order.getParcels()}" var="parcel" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><c:out value="${parcel.getDescription()}"/></td>
                        <td>${parcel.getWeight()} kg</td>
                        <td>${parcel.getFromCountry()}</td>
                        <td>${parcel.getToCountry()}</td>
                        <td><c:out value="${parcel.getRecipientInfo()}"/></td>
                        <td>${parcel.isExpress()}</td>
                        <td>${parcel.getConversionCost()}</td>
                        <td><a data-toggle="confirmation" data-title="Delete parcel?" href="${pageContext.request.contextPath}/DeleteParcel?id=${loop.index}">delete</a></td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="9" style="text-align: right;">
                        Total number: ${order.getParcels().size()}; price - ${order.getConversionTotalCost()}
                        <c:set var="count" value="${order.getParcels().size()}" scope="session"/>
                        <c:if test="${count != 0}">
                            <c:set var="name" value="${order.getParcels().get(0).getCurrency()}" scope="session"/>
                            ${name}
                        </c:if>
                    </td>
                </tr>
                </tbody>
            </table>
            <form role="form" method="POST" action="${pageContext.request.contextPath}/AddOrder">
                <button type="submit" class="btn btn-primary" style="float: right; margin-top: 24px;">
                    Confirm
                </button>
            </form>
        </div>
    </div>
</div>
<script>
    var numb = ${order.getParcels().size()};

    if (numb != 0) {
        var getCurrency = localStorage.getItem('selectedCurrency')
        $('#currency').val(getCurrency);
        document.getElementById('currency').disabled = true;
    }
    else {
        document.getElementById('currency').disabled = false;
    }
</script>

<div id="myModal" class="modal fade" role="dialog" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Currency information:</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid bd-example-row">

                    <div class="row">
                        <div class="form-group col-md-12" style=" margin-bottom: 0px;">
                                    <table class="table table-bordered">
                                        <tbody>
                                        <tr>
                                            <td>#</td>
                                            <%--<td>Currency name:</td>--%>
                                            <td>Currency:</td>
                                            <td>Official exchange rate:</td>
                                            <td>Currency scale:</td>
                                            <td>Last update:</td>
                                        </tr>
                                        <c:forEach items="${currencies}" var="list" varStatus="loop">
                                            <tr>
                                                <td>${loop.index+1}</td>
                                                <%--<td>${list.getCurrencyName()}</td>--%>
                                                <td>${list.getCurrencyAbbreviation()}</td>
                                                <td>${list.getCurrencyRate()}</td>
                                                <td>${list.getCur_Scale()}</td>
                                                <td>${list.getDate().split('T')[0]}</td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="form-group col-md-6" style="color: #ff0000">
                    <c:out value="${sessionScope.SignInError}"/>
                    <c:remove var="SignInError" scope="session"/>
                </div>
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 15px">Close</button>

            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/web/assets/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>
<script src="${pageContext.request.contextPath}/js/bootstrap/js/bootstrap-confirmation.js"></script>
<script src="${pageContext.request.contextPath}/js/custom/custom.js"></script>
<script src="${pageContext.request.contextPath}/js/dropdown/script.min.js"></script>
<script>
    console.log('Bootstrap ' + $.fn.tooltip.Constructor.VERSION);
    console.log('Bootstrap Confirmation ' + $.fn.confirmation.Constructor.VERSION);
    $('[data-toggle=confirmation]').confirmation({
        rootSelector: '[data-toggle=confirmation]',
        container: 'body'
    });
</script>
</body>

</html>
