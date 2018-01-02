
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:useBean id="user" class="entity.User" scope="session"/>
    <section id="ext_menu-9">

        <nav class="navbar navbar-dropdown">
            <div class="container">

                <div class="mbr-table">
                    <div class="mbr-table-cell">

                        <div class="navbar-brand">
                            <a href="${pageContext.request.contextPath}" class="navbar-logo"><img
                                    src="${pageContext.request.contextPath}/images/stork-express-logo-138x128-21.png"
                                    alt="Stork Express"></a>
                            <a class="navbar-caption" href="${pageContext.request.contextPath}">Stork Express</a>
                        </div>

                    </div>
                    <div class="mbr-table-cell">

                        <button class="navbar-toggler pull-xs-right hidden-md-up" type="button" data-toggle="collapse"
                                data-target="#exCollapsingNavbar">
                            <div class="hamburger-icon"></div>
                        </button>

                        <ul class="nav-dropdown collapse pull-xs-right nav navbar-nav navbar-toggleable-sm"
                            id="exCollapsingNavbar">
                            <li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/jsp/about.jsp">ABOUT US</a></li>
                            <li class="nav-item nav-btn"><a class="nav-link btn btn-info" href="${pageContext.request.contextPath}/#SignIn">Sign
                                In</a></li>
                            <li class="nav-item nav-btn"><a class="nav-link btn btn-info" href="${pageContext.request.contextPath}/jsp/registration.jsp">Sign
                                Up</a></li>

                        </ul>
                        <button hidden="" class="navbar-toggler navbar-close" type="button" data-toggle="collapse"
                                data-target="#exCollapsingNavbar">
                            <div class="close-icon"></div>
                        </button>

                    </div>
                </div>

            </div>
        </nav>

    </section>
</head>
<body>

</body>
</html>
