<%@ page import="com.hrproject.hrproject.dto.SalaryPlusEmpNameDto" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-11
  Time: 오전 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/header.jsp" %>
<%@include file="../include/left_side_menu.jsp" %>
<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8"
     style="width: calc(100% - 520px);">
    <h2 class="mt-5 mb-5  ">LIST</h2>
    <form action="../board/delete-all" method="post">
        <table class="table table-striped">

            <thead>
            <tr>
                <th>번호</th>
                <th>사원 번호</th>
                <th>사원 명</th>
                <th>급여구분</th>
                <th>지급구분</th>
                <th>대장명칭</th>
                <th>지급일</th>
                <th>근속연월</th>
                <th>지급액</th>
                <th>기타</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${salaryList}" var="salaryDto" varStatus="loop">
                <tr>
                    <td>${salaryDto.salary_No}</td>
                    <td>${salaryDto.empNo}</td>
                    <td>${salaryDto.ename}</td>
                    <td>${salaryDto.salaryName}</td>
                    <td>${salaryDto.salary}</td>
                    <td>${salaryDto.salaryDay}</td>
                    <td>${salaryDto.salaryCategory}</td>
                    <td>${salaryDto.salaryInfo}</td>
                    <td>${salaryDto.salaryDay}</td>
                    <td>${salaryDto.accountingPeriod}</td>
                    <td>${salaryDto.salary}</td>


                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
    <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">신규</button>

</div>

<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
     data-bs-backdrop="static"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalToggleLabel">급여 정보 등록</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../salary/insert" id="modalForm" method="post">
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">대상 사원번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="empNo" name="empNo">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">근무 연월</div>
                        <div class="col col-md-4">
                            <input type="month" class="form-control" id="accountingPeriod" name="accountingPeriod">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급구분</div>
                        <div class="col col-md-4">
                            <select class="form-control" id="paymentType" name="salaryCategory">
                                <option value="지급구분 옵션1">지급구분 옵션 1</option>
                                <option value="지급구분 옵션2">지급구분 옵션 2</option>
                                <option value="지급구분 옵션3">지급구분 옵션 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여구분</div>
                        <div class="col col-md-4">
                            <select class="form-control" id="paymentType02" name="salaryName">
                                <option value="급여구분 옵션 1">급여구분 옵션 1</option>
                                <option value="급여구분 옵션 2">급여구분 옵션 2</option>
                                <option value="급여구분 옵션 3">급여구분 옵션 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급날짜</div>
                        <div class="col col-md-4">
                            <input type="date" class="form-control" id="salaryDay" placeholder="select paymentDay"
                                   name="salaryDay">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="salary"
                                   name="salary">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">기타 추가급여</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="bonus" name="bonus">
                        </div>
                    </div>

                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여 대장명칭</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="salaryInfo"
                                   name="salaryInfo">
                        </div>
                    </div>
                </form>
            </div>


            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">사원 찾기
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="modalForm" class="btn btn-primary">Submit</button>
                <button type="reset" form="modalForm" class="btn btn-danger">Reset</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
     data-bs-backdrop="static" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">사원 찾기</h1>
                    <div class="col-6">
                <form action="/hrm/searchEmpNo">
                    <div class="input-group mt-3 mx-5">
                        <input type="text" class="form-control" placeholder="ex)홍길동" aria-label="empNo" name="searchEmpNo">
                        <button class="btn btn-primary" type="submit">찾기</button>
                    </div>
                </form>
                    </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <colgroup>
                        <col style="width:150px">
                        <col style="width:150px">
                        <col style="width:150px">
                        <col style="width:150px">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>사원 번호</th>
                        <th>부서 명</th>
                        <th>직책</th>
                        <th>사원 명</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${hrmList}" var="hrmDto" varStatus="loop">
                        <tr>
                            <td><input type="checkbox" id="check-all"></td>
                            <td>${hrmDto.empNo}</td>
                            <td>${hrmDto.deptName}</td>
                                <%--                            <td>${hrmDto.eName}</td>--%>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">Back to
                    first
                </button>
            </div>
        </div>
    </div>
</div>


<%@include file="../include/right_side_info.jsp" %>