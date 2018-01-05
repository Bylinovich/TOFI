
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
                        <li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/jsp/account.jsp">ACCOUNT</a>
                        </li>
                        <li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/ShowUsers">USERS</a>
                        </li>
                        <li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/ShowParcels?OrderId=0">PARCELS</a></li>
                        <%--<li class="nav-item"><a class="nav-link link" href="${pageContext.request.contextPath}/jsp/about.jsp">ABOUT US</a>--%>
                        </li>

                        <li class="nav-item dropdown">
                        <a class="dropdown-toggle nav-link link" style="background: transparent;"
                        data-toggle="dropdown" href="#">REPORTS
                        <span class="caret"></span></a>
                        <ul class="dropdown-menu" style="min-width: 100%;background: #282828;padding: 10px 10px 10px 20px;border-radius: 5px;">
                        <li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/TopUsers">TOP 20 USERS</a></li>
                        <li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/jsp/ordersOnDateReport.jsp">ORDERS ON DATE</a></li>
                        <li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/YearReport">YEAR REPORT</a></li>
                        </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="dropdown-toggle nav-link link" style="background: transparent;"
                               data-toggle="dropdown" href="#">STATISTICS
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu" style="min-width: 100%;background: #282828;padding: 10px 10px 10px 20px;border-radius: 5px;">
                                <li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/UsersStat">USERS</a></li>
                                <li class="nav-link link" style="margin: 0.5rem;"><a href="${pageContext.request.contextPath}/OrdersStat">ORDERS</a></li>
                            </ul>
                        </li>

                        <li class="nav-item nav-btn"><a class="nav-link btn btn-info" href="${pageContext.request.contextPath}/SignOut">Sign
                            Out</a></li>
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
</body>
</html>
