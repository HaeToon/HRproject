<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<%@include file="../include/left_side_menu.jsp"%>
<div class="content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8" style="width: calc(100% - 520px);">
    <h2>noticeboard</h2>
    <div>
        <table class="table table-sm">
            <thead>
            <tr>
                <%-- 5개 --%>
                <th scope="col">글번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${hrmList}" var="noticeDto" varStatus="loop">
                <tr>
                    <td>${noticeDto.no}</td>
                    <td><a href="">${noticeDto.subject}</a></td>
                    <td><a href="">${noticeDto.writer}</a></td>
                    <td>${noticeDto.regdate}</td>
                    <td>${noticeDto.hit}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <button class="notice-write btn btn-outline-primary">글작성하기</button>
</div>
<%@include file="../include/right_side_info.jsp"%>