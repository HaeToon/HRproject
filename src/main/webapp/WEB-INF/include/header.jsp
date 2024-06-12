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
    <c:when test="${sessionMember eq null}">
        <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between border-bottom">
            <div class="col-md-2">
                <a href="/index/index"><img src="../../images/logo.png"></a>
            </div>
            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
                <h2>첫화면은 슬로건 좌측 사이드메뉴 클릭시 카테고리 </h2>
            </ul>
            <div class="col-md-3 text-end">
                <h2>뭔가넣는곳</h2>
            </div>
        </header>
    </c:when>
    <c:otherwise>
        <header class="header d-flex flex-wrap align-items-center justify-content-between border-bottom">
            <!-- 로고 영역 시작 -->
            <div class="col-md-2">
                <img src="../../images/logo.png">
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
                <h2>뭔가넣는곳</h2>
            </div>
                <%--      기타영역 끝      --%>
        </header>
    </c:otherwise>
</c:choose>
<%--헤더 끝--%>
<div class="position-relative col-12">

