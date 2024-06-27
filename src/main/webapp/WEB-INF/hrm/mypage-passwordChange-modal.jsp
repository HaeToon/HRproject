<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="passwordChange" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5">비밀번호 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%--<form action="/hrm/login-logout" id="loginModal" method="post">--%>
                <form action="../hrm/change-password" id="changePWModal" method="post">
                    <input type="hidden" class="form-control" value="${sessionDto.empNo}" id="empNo" name="empNo">
                    <div class="row mt-8">
                        <div class="col">비밀번호</div>
                        <div class="col col-md-8">
                            <input type="password" class="form-control" id="changePassword" placeholder="초기 비밀번호는 사원번호입니다."
                                   aria-label="changePassword" name="changePassword">
                        </div>
                    </div>
                    <div class="row mt-8">
                        <div class="col">비밀번호 확인</div>
                        <div class="col col-md-8">
                            <input type="password" class="form-control" id="changePasswordConfirm" placeholder="비밀번호 확인"
                                   aria-label="changePassword" name="changePasswordConfirm">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="changePWModal" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </div>
</div>