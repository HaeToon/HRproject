
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<%@include file="../include/left_side_menu.jsp"%>
<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8">
    <table class="table">
        <thead>
        <tr>
            <%-- 10개 --%>

            <th scope="col"><input type="checkbox" id="check-all"></th>
            <th scope="col">입사일자</th>
            <th scope="col">사원번호</th>
            <th scope="col">성명</th>S
            <th scope="col">부서번호(명)</th>
            <th scope="col">직위/직급명</th>
            <th scope="col">Email</th>
            <th scope="col">계좌번호</th>
            <th scope="col">새로운 항목 추가???</th>
            <th scope="col">인쇄</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${hrmList}" var="hrmDto" varStatus="loop">
            <tr>
                    <%--            <td>${total - hrmDto.num + 1}</td>  --%>
                <td scope="row"><input type="checkbox">${loop.count}</td>
                <td>${hrmDto.hireDate}</td>
                <td><a href="">${hrmDto.empNo}</a></td>
                <td>${hrmDto.EName}</td>
                <td>${hrmDto.deptNo}(부서명 넣으면됨)</td>
                <td>직위/직급</td>
                    <%--                <td>${hrmList.positionName}</td>--%>
                <td>${hrmDto.email}</td>
                <td>${hrmDto.account}</td>
                <td><textarea></textarea></td>
                <td><a href="">인쇄</a></td>
                    <%--            <td><input type="checkbox"></td>--%>
                    <%--            <td>입사일자</td>--%>
                    <%--            <td><a href="#" data-bs-toggle="modal" data-bs-target="#staticBackdrop">사원번호</a></td>--%>
                    <%--            <td><a href="#" data-bs-toggle="modal" data-bs-target="#staticBackdrop">성명</a></td>--%>
                    <%--            <td>부서명</td>--%>
                    <%--            <td>직위/직급명</td>--%>
                    <%--            <td>Email</td>--%>
                    <%--            <td>계좌번호</td>--%>
                    <%--            <td>새로운 항목 추가???</td>--%>
                    <%--            <td>인쇄</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Scrollable modal -->
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
            data-bs-target="#staticBackdrop">신규
    </button>
    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
         tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">인사카드등록</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../hrm/board" id="modalForm" method="post" enctype="multipart/form-data">
                        <div class="row mt-3">
                            <div class="col">사원번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="00008" aria-label="empno">
                            </div>
                            <div class="col">성명</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="Name" aria-label="ename">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">영문성명</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="00008" aria-label="empno">
                            </div>
                            <div class="col">부서번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="부서코드" aria-label="deptno">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">직위/직급</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="" aria-label="">
                            </div>
                            <div class="col">직책</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="" aria-label="">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">휴대폰번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="00008" aria-label="empno">
                            </div>
                            <div class="col">여권번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="Name" aria-label="name">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">Email</div>
                            <div class="col col-md-4">
                                <input type="email" class="form-control" placeholder="" aria-label="">
                            </div>
                            <div class="col">입사일자</div>
                            <div class="col col-md-4">
                                <input type="date" class="form-control" placeholder="" aria-label="">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">입사구분</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="" aria-label="">
                            </div>
                            <div class="col">퇴사일자</div>
                            <div class="col col-md-4">
                                <input type="date" class="form-control" placeholder="" aria-label="">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">퇴사사유</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="" aria-label="">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" form="modalForm" class="btn btn-primary">Submit</button>
                    <button type="reset" form="modalForm" class="btn btn-danger">Reset</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../include/right_side_info.jsp"%>