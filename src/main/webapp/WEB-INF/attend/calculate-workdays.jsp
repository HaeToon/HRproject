<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>


<!--현재 ㄴㄴ-->
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">휴가 관리</h2>
    </div>
    <div class="attend-content-area p-3 bg-body-tertiary">
        <%-- 오류 메시지 표시 --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                    ${errorMessage}
            </div>
        </c:if>

        <%-- 자신의 사원 번호 입력 --%>
        <form action="/attend/view-annual-leave" method="post" class="mb-3">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="text" class="form-control" name="empNo" placeholder="사원 번호 입력" required>
                        <button type="submit" class="btn btn-primary">조회</button>
                    </div>
                </div>
            </div>
        </form>

        <%-- 근무 일수 계산 결과 표시 --%>
        <c:if test="${not empty leaveInfo.workDays}">
            <div class="row mt-3">
                <div class="col-md-6">
                    <h5>입사일로부터 근무한 일수 계산 결과</h5>
                    <p>입사일로부터 ${leaveInfo.workDays}일 동안 근무하셨습니다.</p>
                </div>
            </div>
        </c:if>

        <%-- 사용한 휴가 리스트 및 연차 개수 표시 --%>
        <c:if test="${not empty leaveInfo}">
            <div class="row mt-3">
                <div class="col-md-6">
                    <h5>사용한 휴가 리스트</h5>
                    <ul>
                        <c:forEach var="leave" items="${leaveInfo.usedLeaves}">
                            <li>${leave.atdCode}: ${leave.offDay}</li>
                        </c:forEach>
                    </ul>
                    <p>사용한 휴가의 개수: ${leaveInfo.usedLeaves.size()}개</p>
                    <p>사용한 연차의 개수: ${leaveInfo.usedAnnualLeaveDays}개</p>
                    <p>올해 ${leaveInfo.empName}님의 남은 연차 개수는 ${leaveInfo.remainingAnnualLeaveDays}개 입니다.</p>
                </div>
            </div>
        </c:if>
    </div>
</div>
