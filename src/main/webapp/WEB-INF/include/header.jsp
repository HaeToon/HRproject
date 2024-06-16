<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<html>
<head>
    <title>Title</title>
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
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <div class="row w-100">
            <!-- Offcanvas Toggle Button -->
            <div class="col-auto">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
            <!-- Login Button -->
            <div class="header-user-info d-flex col-auto ms-auto text-end">
                <img src="../../images/profile01.jpg" class="profile">
                <a href="" class="user-name btn btn-outline-light">홍길동</a>
                <a href="" class="btn btn-outline-light me-2">로그인</a>
            </div>
        </div>
    </div>
    <!-- Offcanvas Component -->
    <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel" style="width:300px">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">메뉴</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <hr>
        <div class="offcanvas-body">
            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-house"></i>
                    <a class="nav-link" aria-current="page" href="/index/index">홈으로</a>
                </li>
                <li class="left-side-link nav-item align-items-center" >
                    <div class="d-flex align-items-center">
                    <i class="bi bi-search"></i>
                    <button class="btn btn-toggle collapsed nav-link" data-bs-toggle="collapse" data-bs-target="#selectDropDown" aria-expanded="false">
                        조회
                    </button>
                    </div>
                    <div class="collapse" id="selectDropDown" style="">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="#" class="nav-link text-decoration-none rounded">근태 조회</a></li>
                            <li><a href="#" class="nav-link text-decoration-none rounded">급여 조회</a></li>
                        </ul>
                    </div>
                </li>
                <li class="left-side-link nav-item align-items-center" >
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-workspace"></i>
                        <button class="btn btn-toggle collapsed nav-link" data-bs-toggle="collapse" data-bs-target="#workDropDown" aria-expanded="false">
                            업무
                        </button>
                    </div>
                    <div class="collapse" id="workDropDown" style="">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="/attend/board" class="nav-link text-decoration-none rounded">근태 업무</a></li>
                            <li><a href="/salary/board" class="nav-link text-decoration-none rounded">급여 업무</a></li>
                            <li><a href="/hrm/board" class="nav-link text-decoration-none rounded">인사 업무</a></li>
                        </ul>
                    </div>
                </li>
<%--                <li class="left-side-link nav-item d-flex align-items-center" >--%>
<%--                    <div class="d-flex align-items-center">--%>
<%--                    <i class="bi bi-person-workspace"></i>--%>
<%--                    <button class="btn btn-toggle collapsed nav-link" data-bs-toggle="collapse" data-bs-target="#workDropDown" aria-expanded="false">--%>
<%--                        업무--%>
<%--                    </button>--%>
<%--                    </div>--%>
<%--                    <div class="collapse" id="workDropDown" style="">--%>
<%--                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">--%>
<%--                            <li><a href="/attend/board" class="nav-link text-decoration-none rounded">근태 업무</a></li>--%>
<%--                            <li><a href="/salary/board" class="nav-link text-decoration-none rounded">급여 업무</a></li>--%>
<%--                            <li><a href="/hrm/board" class="nav-link text-decoration-none rounded">인사 업무</a></li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
<%--                </li>--%>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-exclamation-square"></i>
                    <a class="nav-link" href="/notice/board">공지사항</a>
                </li>
                <li class="left-side-link nav-item d-flex align-items-center">
                    <i class="bi bi-calendar4"></i>
                    <a class="nav-link" href="#">커뮤니티</a>
                </li>
            </ul>
        </div>
        <hr>
    </div>
</nav>
<%--헤더 끝--%>
<div class="position-relative col-12">

