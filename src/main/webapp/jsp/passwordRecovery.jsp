<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <title>Password recovery</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.png" type="image/x-icon">
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
    <script src="${pageContext.request.contextPath}/js/custom/custom.js"></script>


</head>
<body>

<jsp:useBean id="user" class="entity.User" scope="session"/>
<c:choose>
    <c:when test="${user.getUsername() == null}">
        <%--<jsp:include page="guestNavBar.jsp"/>--%>
    </c:when>
    <c:when test="${user.isAdmin()}">
        <c:redirect url="/"/>
    </c:when>
    <c:when test="${user.isSimpleUser()}">
        <c:redirect url="/"/>
    </c:when>
</c:choose>

<div class="container">
    <div class="row">

        <div class="col-md-8 col-md-offset-2">
            <form name="myForm" role="form" method="POST" action="${pageContext.request.contextPath}/PasswordRecovery" style="margin-top: 4rem">

                <div class="form-group col-md-12" style="color: #ff0000">
                    <c:out value="${sessionScope.passwordRecoveryError}"/>
                    <c:remove var="SignUpError" scope="session"/>
                </div>

                <legend class="text-center">Registration</legend>

                    <div class="form-group col-md-6">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" name="email" id="email"
                               pattern="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" required placeholder="Email"  maxlength="50"
                               title="Enter your email, please. Format: example@example.com."
                               oninvalid="setCustomValidity('Wrong email form. Try one more time, please.')"
                               onchange="try{setCustomValidity('')}catch(e){}">
                    </div>

                <div class="form-group">
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-primary">
                            Send password
                        </button>
                        <a href="${pageContext.request.contextPath}" style="margin-left: 20px"
                        >Main page</a>
                    </div>
                </div>

            </form>
        </div>

    </div>
</div>

<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Error</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid bd-example-row">



                    <div class="row">
                        <div class="form-group col-md-10">
                            <p style="font-size: x-large;"><c:out value="${error}" /></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-right: 15px">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
