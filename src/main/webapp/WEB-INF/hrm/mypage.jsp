<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
<div class="employee-card  notice-content-area p-3">
    <h1 class="text-center">사원 카드</h1>
    <div class="profile-container">
            <c:choose>
                <c:when test="${not empty hrmDto.renameProfile}">
                    <img src="${request.contextPath}/upload/${hrmDto.renameProfile}" class="myPageProfile">
                </c:when>
                <c:otherwise>
                    <img src="../images/profile03.jpg" class="mypage-profile">
                </c:otherwise>
            </c:choose>
        <div class="profile-details">
            <div class="row mb-sm-1 reduce-gap">
                <label for="hireDate" class="col-sm col-form-label">입사일</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="hireDate" value="${hrmDto.hireDate}"
                           readonly>
                </div>
                <label for="birth" class="col-sm col-form-label">생일</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="birth" value="생일없음" readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="eName" class="col-sm col-form-label">성명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="ename" value="${hrmDto.ename}" readonly>
                </div>
                <label for="deptName" class="col-sm col-form-label">부서명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="deptName" value="${hrmDto.deptName}"
                           readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="email" class="col-sm col-form-label">Email</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="email" value="${hrmDto.email}" readonly>
                </div>
                <label for="postcode" class="col-sm col-form-label">우편</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="postcode" value="${hrmDto.postCode}"
                           readonly>
                </div>
            </div>
            <div class="row mb-3-sm-1">
                <label for="long" class="col-sm-2 col-form-label">주소</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="long"
                           value="${hrmDto.address}" readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="mobile" class="col-sm col-form-label">전화</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="mobile" value="${hrmDto.mobile}"
                           readonly>
                </div>
                <label for="position" class="col-sm col-form-label">직급</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="position" value="${hrmDto.posName}"
                           readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="passport" class="col-sm col-form-label">여권</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="passport" value="${hrmDto.passport}"
                           readonly>
                </div>
                <label for="role" class="col-sm col-form-label">직책</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="role" value="${hrmDto.roleName}" readonly>
                </div>
            </div>
            <div class="form-row">
                <div class="col-sm-12">
                    <label for="remarks" class="form-label">비고</label>
                    <textarea class="form-control" id="remarks" name="remarks" value="${hrmDto.remarks}"
                              readonly>비고란</textarea>
                </div>
            </div>
            <div class="text-end mt-3">
                <jsp:include page="mypage-passwordChange-modal.jsp" />
                <button type="button" class="btn btn-primary"
                        data-bs-toggle="modal" data-bs-target="#passwordChange">비밀번호변경
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">인쇄</button>
            </div>
        </div>
    </div>
</div>
</div>