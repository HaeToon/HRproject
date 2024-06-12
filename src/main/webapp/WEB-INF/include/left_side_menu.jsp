<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%--left_side_menu area--%>
<div class="d-flex flex-column flex-shrink-0 bg-body-tertiary col-2" style="width: 220px;">
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="/hrm/board" class="nav-link link-body-emphasis p-5" aria-current="page">
                조회하기
            </a>
        </li>
        <li class="nav-item">
            <a href="/salary/board" class="nav-link link-body-emphasis p-5">
                업무보기
            </a>
        </li>
        <li class="nav-item">
            <a href="/attend/board" class="nav-link link-body-emphasis p-5">
                커뮤니티
            </a>
        </li>
        <li class="nav-item">
            <a href="/notice/board" class="nav-link link-body-emphasis p-5">
                공지사항
            </a>
        </li>
        <li class="nav-item">
            <a href="#" class="nav-link link-body-emphasis p-5">
                연락처
            </a>
        </li>
    </ul>
</div>
<script>
    $(document).ready(function () {
        $(".nav-link").click(function () {
            $(".nav-link").removeClass("active");
            $(this).addClass("active")
        })
    })
</script>