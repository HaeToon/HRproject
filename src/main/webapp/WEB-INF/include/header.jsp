<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>HRM</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/include.css" rel="stylesheet">
    <link href="../../css/hrm.css" rel="stylesheet">
    <link href="../../css/salary.css" rel="stylesheet">
    <link href="../../css/attend.css" rel="stylesheet">
    <link href="../../css/notice.css" rel="stylesheet">
    <link href="../../css/index.css" rel="stylesheet">
    <script src="../../js/bootstrap.bundle.min.js"></script>
    <script src="../../js/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body>
<%--헤더 처음--%>
<nav class="header-top navbar navbar-dark fixed-top">
    <div class="container-fluid">
        <div class="row w-100">
            <!-- Offcanvas Toggle Button -->
            <div class="col-auto align-content-center">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas"
                        data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
            <!-- Login Button -->
            <div class="header-user-info d-flex col-auto ms-auto text-end">
                <c:choose>
                    <c:when test="${not empty loginDto.renameProfile}">
                        <img src="${request.contextPath}/upload/${loginDto.renameProfile}" class="profile">
                    </c:when>
                    <c:otherwise>
                        <img src="../images/profile01.jpg" class="profile">
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${loginDto eq null}">
                        <c:set var="redirectUrl" value="${pageContext.request.contextPath}/index/index"/>
                        <c:if test="${not fn:contains(pageContext.request.requestURI, '/index/index')}">
                            <meta http-equiv="refresh" content="0; url=${redirectUrl}">
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown">
                            <button class="user-name btn btn-outline-light" type="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    ${loginDto.ename}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-dark mt-2">
                                <li>
                                    <form action="../hrm/mypage" method="post" id="mypage" class="m-0">
                                        <input type="hidden" value="${loginDto.empNo}" name="sessionEmpNo">
                                        <button class="btn dropdown-btn-outline-light" form="mypage">마이페이지</button>
                                    </form>
                                </li>
                                <li>
                                    <form action="../hrm/login-logout" method="post" id="logout" class="m-0">
                                        <input type="hidden" value="${loginDto.empNo}" name="sessionEmpNo">
                                        <button class="btn dropdown-btn-outline-light" form="logout">로그아웃</button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- Offcanvas Component -->
    <div class="left-side offcanvas offcanvas-start " tabindex="-1" id="offcanvasDarkNavbar"
         aria-labelledby="offcanvasDarkNavbarLabel" style="width:300px">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">메뉴</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
                    aria-label="Close"></button>
        </div>
        <hr>
        <div class="offcanvas-body">
            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-house"></i>
                    <a class="nav-link" aria-current="page" href="/index/index">홈으로</a>
                </li>
                <c:choose>
                    <c:when test="${loginDto.grade eq 'ADMIN'}">

                    </c:when>
                    <c:otherwise>
                        <li class="left-side-link nav-item align-items-center">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-search"></i>
                                <button class="btn btn-toggle collapsed nav-link" data-bs-toggle="collapse"
                                        data-bs-target="#selectDropDown" aria-expanded="false">
                                    조회
                                </button>
                            </div>
                            <div class="collapse" id="selectDropDown" style="">
                                <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                    <li><a href="/attend/check" class="nav-link text-decoration-none rounded">근태 조회</a></li>
                                    <li><a href="/salary/check" class="nav-link text-decoration-none rounded">급여 조회</a></li>
                                </ul>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
                <c:if test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 10
                or loginDto.deptNo eq 20 or loginDto.deptNo eq 30}">
                    <li class="left-side-link nav-item align-items-center">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-person-workspace"></i>
                            <button class="btn btn-toggle collapsed nav-link" data-bs-toggle="collapse"
                                    data-bs-target="#workDropDown" aria-expanded="false">업무
                            </button>
                        </div>
                        <div class="collapse" id="workDropDown" style="">
                            <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                                <c:if test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 10}">
                                    <li><a href="/attend/board" class="nav-link text-decoration-none rounded">근태 업무</a></li>
                                </c:if>
                                <c:if test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 20}">
                                <li><a href="/salary/board" class="nav-link text-decoration-none rounded">급여 업무</a></li>
                                </c:if>
                               <c:if test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 30}" >
                                <li><a href="/hrm/board" class="nav-link text-decoration-none rounded">인사 업무</a></li>
                                </c:if>
                                <c:if test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 30}" >
                                    <li><a href="/hrm/evaluation" class="nav-link text-decoration-none rounded">평가 업무</a></li>
                                </c:if>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-exclamation-square"></i>
                    <a class="nav-link" href="/notice/board">공지사항</a>
                </li>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-calendar4"></i>
                    <a class="nav-link" href="../workSchedule/empWorkBoard">사원용 출퇴근</a>
                </li>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-calendar4"></i>
                    <a class="nav-link" href="../workSchedule/adminWorkBoard">관리자용 출퇴근</a>
                </li>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-book"></i>
                    <a class="nav-link" href="/community/board">커뮤니티</a>
                </li>
            </ul>
        </div>
        <hr>
    </div>
</nav>
<%--헤더 끝--%>

