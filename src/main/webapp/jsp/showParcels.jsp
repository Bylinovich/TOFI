<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Parcels</title>
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

    <script src="${pageContext.request.contextPath}/js/tether/tether.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/web/assets/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/dropdown/script.min.js"></script>

</head>
<body>

<jsp:useBean id="user" class="entity.User" scope="session"/>
<jsp:useBean id="states" class="java.util.ArrayList" scope="session"/>
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
<jsp:include page="adminNavBar.jsp"/>

<jsp:useBean id="users" class="java.util.ArrayList" scope="request"/>

<div class="container-fluid" style="position: relative; top: 8rem;">
    <div class="row">
        <div class="col-md-12">
            <form action="${pageContext.request.contextPath}/ShowParcels" method="post">
                <div class="row">
                    <div class="col-md-3">
                        <div class="input-group">
                            <input required type="number" min="1" pattern="\d+" class="form-control" placeholder="Order Id" name="OrderId">
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-secondary">Go!</button>
                            </span>
                        </div>
                    </div>
                </div>
            </form>
            <form action="${pageContext.request.contextPath}/ChangeParcelsState" method="post">
                <%--<legend>List of parcels:</legend>--%>
                <table class="table table-bordered">
                    <thead style="background: rgba(228, 226, 224, 0.29);">
                    <tr>
                        <th>

                        </th>
                        <th>
                            ID:
                        </th>
                        <th>
                            Description:
                        </th>
                        <th>
                            Weight:
                        </th>
                        <th>
                            Cost:
                        </th>
                        <th>
                            From:
                        </th>
                        <th>
                            To:
                        </th>
                        <th>
                            State:
                        </th>
                        <%--TODO<th>Total spending:</th>--%>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach items="${parcels}" var="parcel">
                        <tr>
                            <td>
                                <input type="checkbox" class="select-parcel" name="select_${parcel.getId()}">
                            </td>
                            <td><c:out value="${parcel.getId()}"/></td>
                            <td>${parcel.getDescription()}</td>
                            <c:if test="${'Waiting for the parcel'.equals(parcel.getState())}">
                                <td><input name="weight${parcel.getId()}" min="0.1" max="100" step="0.1" type="number" value="${parcel.getWeight()}"></td>
                            </c:if>
                            <c:if test="${!'Waiting for the parcel'.equals(parcel.getState())}">
                                <td>${parcel.getWeight()}</td>
                            </c:if>
                            <td>${parcel.getCost()}</td>
                            <td>${parcel.getFromCountry()}</td>
                            <td>${parcel.getToCountry()}</td>
                            <td><select name="state${parcel.getId()}" required class="form-control">
                                <c:forEach items="${states}" var="state">
                                <option ${state.equals(parcel.getState())?"selected":""} value="${state}">${state}</option>
                                </c:forEach>
                            </select></td>
                        </tr>
                    </c:forEach>

                        <tr>
                            <td>
                                <input type="checkbox" name="select_all" id="select-all" class="select-parcel">
                            </td>
                            <td colspan="6"></td>
                            <td><select
                                    name="state_selected"
                                    id="select-status-for-all-parcels"
                                    class="form-control hidden"
                                    required
                            >
                                <c:forEach items="${states}" var="state">
                                    <option ${state.equals(parcel.getState())?"selected":""} value="${state}">${state}</option>
                                </c:forEach>
                            </select></td>
                        </tr>

                    </tbody>
                    <tfoot style="background: rgba(228, 226, 224, 0.29);">
                    <tr>
                        <td colspan="3">
                            <button type="submit" class="btn btn-primary" style="float: left;">
                                Save
                            </button>
                        </td>
                        <td colspan="5" style="padding-top: 0.2rem; padding-bottom: 0.2rem;">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" style="margin-top: 0.2rem; margin-bottom: 0.2rem; float: right">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${pageNumber-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                        </a>

                                        <c:choose>
                                        <c:when test="${pageNumber-3>0}">
                                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=1">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">...</a></li>
                                    <c:forEach var="i" begin="${pageNumber-1}" end="${pageNumber-1}">
                                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${i}">${i}</a></li>
                                    </c:forEach>

                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="i" begin="1" end="${pageNumber-1}">
                                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${i}">${i}</a></li>
                                        </c:forEach>
                                    </c:otherwise>
                                    </c:choose>

                                    <li class="page-item"><a class="page-link" style="color: black" href="#">${pageNumber}</a></li>


                                    <c:choose>
                                        <c:when test="${pageAmount-pageNumber>2}">
                                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${pageNumber+1}">${pageNumber+1}</a></li>
                                            <li class="page-item"><a class="page-link" href="#">...</a></li>
                                            <c:forEach var="i" begin="${pageAmount}" end="${pageAmount}">
                                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${i}">${i}</a></li>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="i" begin="${pageNumber+1}" end="${pageAmount}">
                                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${i}">${i}</a></li>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>

                                    <a class="page-link" href="${pageContext.request.contextPath}/ShowParcels?page=${pageNumber+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                    </li>
                                </ul>
                            </nav>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</div>
</div>
<script src="${pageContext.request.contextPath}/js/admin/parcels.js"></script>
</body>
</html>
