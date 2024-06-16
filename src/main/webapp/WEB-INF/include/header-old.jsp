<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<html>
<head>
    <title>Title</title>
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/include.css" rel="stylesheet">
    <link href="../../css/salary.css" rel="stylesheet">
    <link href="../../css/notice.css" rel="stylesheet">
    <link href="../../css/index.css" rel="stylesheet">
    <script src="../../js/bootstrap.bundle.min.js"></script>
    <script src="../../js/jquery-3.7.1.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body>
<%--헤더 처음--%>
<c:choose>
    <c:when test="${url eq 'index/index'}">
        <header class="d-flex flex-wrap  justify-content-center justify-content-md-between border-bottom">
            <div class="col-md-2 align-items-center">
                <a href="/index/index"><img src="../../images/logo.png"></a>
            </div>
            <ul class="nav col-12 col-md-auto align-items-center mb-2 mb-md-0">
                <h2> 슬로건 </h2>
            </ul>
            <div class="col-md-3 text-end">
                <button class="btn btn-outline-primary">로그인</button>
            </div>
        </header>
    </c:when>
    <c:when test="${url eq 'attend/board'}">
<header class="header d-flex flex-wrap align-items-center justify-content-between border-bottom">
    <!-- 로고 영역 시작 -->
    <div class="col-md-2">
        <a href="/index/index"><img src="../../images/logo.png"></a>
    </div>
        <%--      로고영역 끝      --%>
    <!-- 카테고리 영역 -->
    <div class="col-md-8">
        <ul class="nav justify-content-center mb-0">
            <li class="nav-item">
                <a href="" class="nav-link p-5 bg-body-tertiary">attend1</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">attend2</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">attend3</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">attend4</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">attend5</a>
            </li>
        </ul>
    </div>
        <%--      카테고리영역 끝      --%>
    <!-- 기타 영역 -->
    <div class="col-md-2 text-end">
        <button class="btn btn-outline-primary"></button>
    </div>
        <%--      기타영역 끝      --%>
</header>
    </c:when>
<c:when test="${url eq 'hrm/board'}">
<header class="header d-flex flex-wrap align-items-center justify-content-between border-bottom">
    <!-- 로고 영역 시작 -->
    <div class="col-md-2">
        <a href="/index/index"><img src="../../images/logo.png"></a>
    </div>
        <%--      로고영역 끝      --%>
    <!-- 카테고리 영역 -->
    <div class="col-md-8">
        <ul class="nav justify-content-center mb-0">
            <li class="nav-item">
                <a href="" class="nav-link p-5 bg-body-tertiary">hrm1</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">hrm2</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">hrm3</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">hrm4</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">hrm5</a>
            </li>
        </ul>
    </div>
        <%--      카테고리영역 끝      --%>
    <!-- 기타 영역 -->
    <div class="col-md-2 text-end">
        <button class="btn btn-outline-primary"></button>
    </div>
        <%--      기타영역 끝      --%>
</header>
</c:when>
<c:when test="${url eq 'salary/board'}">
<header class="header d-flex flex-wrap align-items-center justify-content-between border-bottom">
    <!-- 로고 영역 시작 -->
    <div class="col-md-2">
        <a href="/index/index"><img src="../../images/logo.png"></a>
    </div>
        <%--      로고영역 끝      --%>
    <!-- 카테고리 영역 -->
    <div class="col-md-8">
        <ul class="nav justify-content-center mb-0">
            <li class="nav-item">
                <a href="" class="nav-link p-5 bg-body-tertiary">salary1</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">salary2</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">salary3</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">salary4</a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link p-5 bg-body-tertiary">salary5</a>
            </li>
        </ul>
    </div>
        <%--      카테고리영역 끝      --%>
    <!-- 기타 영역 -->
    <div class="col-md-2 text-end">
        <button class="btn btn-outline-primary"></button>
    </div>
        <%--      기타영역 끝      --%>
</header>
</c:when>
    <c:otherwise>
        <header class="header d-flex flex-wrap align-items-center justify-content-between border-bottom">
            <!-- 로고 영역 시작 -->
            <div class="col-md-2">
                <a href="/index/index"><img src="../../images/logo.png"></a>
            </div>
                <%--      로고영역 끝      --%>
            <!-- 카테고리 영역 -->
            <div class="col-md-8">
                <ul class="nav justify-content-center mb-0">
                    <li class="nav-item">
                        <a href="" class="nav-link p-5 bg-body-tertiary">카테고리1</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link p-5 bg-body-tertiary">카테고리2</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link p-5 bg-body-tertiary">카테고리3</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link p-5 bg-body-tertiary">카테고리4</a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link p-5 bg-body-tertiary">카테고리5</a>
                    </li>
                </ul>
            </div>
                <%--      카테고리영역 끝      --%>
            <!-- 기타 영역 -->
            <div class="col-md-2 text-end">
                <button class="btn btn-outline-primary"></button>
            </div>
                <%--      기타영역 끝      --%>
        </header>
    </c:otherwise>
</c:choose>
<%--헤더 끝--%>
<div class="position-relative col-12">

