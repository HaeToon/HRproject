<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp" %>

<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">휴가사용현황</h2>
    </div>
    <div class="attend-content-area p-3 bg-body-tertiary">

        <!-- 검색 폼 -->
        <form action="/attend/offday" method="get" class="mb-3">
            <div class="row">
                <div class="col-md-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="empNo" placeholder="사원 번호 입력">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="empName" placeholder="사원 이름 입력">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="input-group">
                        <input type="text" class="form-control" name="departmentCode" placeholder="부서 코드 입력">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </div>
                </div>
            </div>
        </form>

        <!-- 연차 정보 표시 -->
        <c:if test="${not empty offdayList}">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>사원번호: ${offdayList[0].empNo}</h5>
                    <p>총 사용 휴가일수: ${totalUsedOffdays}</p>
                    <p>연차 사용일수: ${annualLeaveUsed}</p>
                    <p>잔여 연차일수: ${remainingAnnualLeave}</p>
                </div>
            </div>

            <!-- 휴가 정보 테이블 -->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>휴가 코드</th>
                            <th>휴가 일수</th>
                            <th>휴가 날짜</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="attendDto" items="${offdayList}">
                            <tr>
                                <td>${attendDto.atdCode}</td>
                                <td>${attendDto.atdNum}</td>
                                <td>${attendDto.atdDate}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</div>
