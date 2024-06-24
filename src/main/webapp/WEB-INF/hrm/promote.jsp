<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<%--   내용 영역  --%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <%--  hrm 제목 영역  --%>
    <div class="board-title">
        <h2 class="title">Evaluation list</h2>
    </div>
    <%--  hrm 내용 영역  --%>
    <div class="hrm-content-area p-3 bg-body-tertiary">
        <%--      hrm list table 영역      --%>
        <table class="table table-sm">
            <thead>
            <tr>
                <th scope="col">사원번호</th>
                <th scope="col">부서</th>
                <th scope="col">직책</th>
                <th scope="col">사원명</th>
                <th scope="col">입사일</th>
                <th scope="col">사원평가등급</th>
                <th scope="col">승진대상</th>
                <th scope="col">승인 / 반려</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${hrmList}" var="hrmDto" varStatus="loop">
                <tr>
                    <td>${hrmDto.empNo}</td>
                    <td>${hrmDto.deptName}</td>
                    <td>${hrmDto.posName}</td>
                    <td>${hrmDto.ename}</td>
                    <td>${hrmDto.hireDate}</td>
                    <td>${hrmDto.attendanceGrade}</td>
                    <td>${hrmDto.isPromo}</td>
                    <td>
                        <c:choose>
                            <c:when test="${hrmDto.isPromo eq 'O'}">
                                <form action="hrm/evaluation" method="post">
                                    <input type="hidden" value="${hrmDto.empNo}" name="empNo">
                                    <button class="btn btn-primary">승인</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-dark" disabled>반려</button>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <%--      hrm page 영역 끝      --%>
</div>