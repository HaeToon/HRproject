<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>

<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-3">

    <%--  내용 영역  --%>
    <div class="hrm-login-content-area p-3 bg-body-tertiary">
    <%--  제목 영역  --%>
        <div class="login-title">
            <h2 class="title">Login</h2>
        </div>
    <%--    폼 영역    --%>
        <form action="../hrm/login-logout" method="post">
            <div class="form-floating">
                <input type="text" class="form-control" id="loginEmpNo" value="admin" name="loginEmpNo" placeholder="사원번호를 입력해 주세요">
                <label for="loginEmpNo">사원번호</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="loginPassword" value="1234" name="loginPassword" placeholder="비밀번호를 입력해 주세요">
                <label for="loginPassword">비밀번호</label>
            </div>
            <div class="row mt-3">
                <div class="col col-4">
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
            </div>
        </form>
    </div>
</div>