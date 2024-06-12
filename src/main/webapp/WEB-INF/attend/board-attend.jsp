<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<<<<<<< HEAD
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/left_side_menu.jsp" %>

<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8"
     style="width: calc(100% - 520px);">
    <h2 class="mt-5 mb-5">근태관리</h2>
    <%--<form action="../board" method="post">--%>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">사원번호</th>
            <th scope="col">근태번호</th>
            <th scope="col">사원명</th>
            <th scope="col">근태코드</th>
            <th scope="col">근태수</th>
            <th scope="col">근태기간</th>
            <th scope="col">휴가명</th>
            <th scope="col">휴가사유</th>
            <th scope="col">인쇄</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${attendList}" var="attendDto" varStatus="loop">

<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8" style="width: calc(100% - 520px);">
    <h2 class="mt-5 mb-5">Attend list</h2>
    <%--검색--%>
    <form action="../attend/board" class="row g-3 d-flex align-items-center justify-content-end">
        <div class="col-sm-5">
            <div class="row g-3">
                <div class="col">
                    <select class="form-select" aria-label="Default select example" name="search">
                        <option value="all" ${search eq "all" ? "selected": ""}>전체</option>
                        <option value="empNo" ${search eq "empno" ? "selected": ""}>사원번호</option>
                        <option value="aptNo" ${search eq "aptNo" ? "selected": ""}>근태번호</option>
                        <option value="ename" ${search eq "ename" ? "selected": ""}>사원명</option>
                        <option value="atdCode" ${search eq "atdCode" ? "selected": ""}>근태코드</option>
                    </select>
                </div>
                <div class="col w-auto">
                    <input type="text" name="searchWord" class="form-control" value="${searchWord}">
                </div>

                <div class="col-sm-3">
                    <button class="btn btn-primary w-100">SEARCH</button>
                </div>

            </div>
        </div>

    </form>

    <%--보드--%>
    <form action="../board/delete-all" method="post">
        <table class="table table-striped">
            <thead>
            <tr>
                <td>${attendDto.empNo}</td>
                <td>
                    <a href="#"
                       data-bs-toggle="modal"
                       data-bs-target="#editModal"
                       data-bs-backdrop="static"
                       data-empno="${attendDto.empNo}"
                       data-atdno="${attendDto.atdNo}"
                       data-ename="${attendDto.ename}"
                       data-atdcode="${attendDto.atdCode}"
                       data-atdnum="${attendDto.atdNum}"
                       data-atddate="${attendDto.atdDate}"
                       data-offday="${attendDto.offDay}"
                       data-offdayrs="${attendDto.offDayRs}"
                       data-print="${attendDto.print}">
                            ${attendDto.atdNo}
                    </a>

                </td>

                <td>${attendDto.ename}</td>
                <td>${attendDto.atdCode}</td>
                <td>${attendDto.atdNum}</td>
                <td>${attendDto.atdDate}</td>
                <td>${attendDto.offDay}</td>
                <td>${attendDto.offDayRs}</td>
                <td>${attendDto.print}</td>

            </tr>

        </c:forEach>
        </tbody>
    </table>
    <%--</form>--%>
    <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         data-bs-backdrop="static"
            </thead>
            <tbody>
            <c:forEach items="${attendList}" var="attendDto" varStatus="loop">
                <tr>
                    <td>${attendDto.empNo}</td>
                    <td><a href="#" id="updateModal">${attendDto.atdNo}</a></td> <%--근태번호 수정키--%>
                    <td>${attendDto.ename}</td>
                    <td>${attendDto.atdCode}</td>
                    <td>${attendDto.atdNum}</td>
                    <td>${attendDto.atdDate}</td>
                    <td>${attendDto.offDay}</td>
                    <td>${attendDto.offDayRs}</td>
                    <td>${attendDto.print}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>


    <div class="modal fade" id="insertModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" data-bs-backdrop="static"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">근태 입력</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../attend/insert" id="modalForm" method="post">
                        <div class="row mb-3">
                            <label for="empNo" class="col-sm-2 col-form-label">사원번호</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="empNo" name="empNo">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdNo" class="col-sm-2 col-form-label">근태번호</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="atdNo" name="atdNo">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="eName" class="col-sm-2 col-form-label">사원명</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="ename" name="ename">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdCode" class="col-sm-2 col-form-label">근태코드</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="atdCode" name="atdCode">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdNum" class="col-sm-2 col-form-label">근태수</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="atdNum" name="atdNum">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">근태기간</label>
                            <div class="col-sm-10 col-auto">

                                <input type="date" class="form-control" id="startAttendDate"> ~ <input type="date"
                                                                                                       class="form-control"
                                                                                                       id="endAttendDate">
                                <input type="date" class="form-control" id="startAtdDate" name="startAtdDate"> ~ <input type="date" class="form-control" id="endAtdDate" name="endAtdDate">

                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="offDay" class="col-sm-2 col-form-label">휴가명</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="offDay" name="offDay">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="offDayRs" class="col-sm-2 col-form-label">휴가사유</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="offDayRs" name="offDayRs">
                            </div>
                        </div>

                        <legend class="col-form-label col-sm-2 pt-0">인쇄</legend>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="print" id="printY" value="Y" checked>

                            <label class="form-check-label" for="printY">
                                Y
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="print" id="printN" value="N">
                            <label class="form-check-label" for="printN">
                                N
                            </label>
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
    <button type="button" class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal"
            style="font-size: 12px; padding: 5px 10px;">신규
    </button>


</div>
<script>
    // 모달이 열릴 때마다 실행되는 함수
    $('#editModal').on('show.bs.modal', function (event) {
        // 버튼을 클릭한 요소 가져오기
        var button = $(event.relatedTarget);
        // 데이터셋 추출
        var empNo = button.data('empno');
        var atdNo = button.data('atdno');
        var ename = button.data('ename');
        var atdCode = button.data('atdcode');
        var atdNum = button.data('atdnum');
        var atdDate = button.data('atddate');
        var offDay = button.data('offday');
        var offDayRs = button.data('offdayrs');
        var print = button.data('print');

        // 모달에 데이터 입력
        var modal = $(this);
        modal.find('#editEmpNo').val(empNo);
        modal.find('#editAtdNo').val(atdNo);
        modal.find('#editEname').val(ename);
        modal.find('#editAtdCode').val(atdCode);
        modal.find('#editAtdNum').val(atdNum);
        modal.find('#editAtdDate').val(atdDate);
        modal.find('#editOffDay').val(offDay);
        modal.find('#editOffDayRs').val(offDayRs);
        modal.find('#editPrint').val(print);

        // 사용자가 입력한 값을 가져와서 변수에 저장
        var editedAtdNum = modal.find('#editAtdNum').val();
        var editedAtdDate = modal.find('#editAtdDate').val();
        var editedOffDay = modal.find('#editOffDay').val();
        var editedOffDayRs = modal.find('#editOffDayRs').val();
        var editedPrint = modal.find('#editPrint').val();

        // 수정된 값으로 변경
        modal.find('#editAtdNum').val(editedAtdNum);
        modal.find('#editAtdDate').val(editedAtdDate);
        modal.find('#editOffDay').val(editedOffDay);
        modal.find('#editOffDayRs').val(editedOffDayRs);
        modal.find('#editPrint').val(editedPrint);
    });
</script>


    <%--신규--%>
    <button class="btn btn-primary insert-btn" data-bs-target="#insertModalToggle" data-bs-toggle="modal">신규</button>

    <%--수정모달--%>
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">근태 정보 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- 근태 정보 수정 폼 -->
                    <form id="editForm" action="../board/attend-modify" method="post">
                        <!-- 사원번호 -->
                        <input type="hidden" id="editEmpNo" name="empNo">

                        <!-- 근태번호 -->
                        <div class="mb-3">
                            <label for="editDate" class="form-label">근태일자</label>
                            <input type="date" class="form-control" id="editDate" name="atdDate">
                        </div>

                        <!-- 사원명 -->
                        <div class="mb-3">
                            <label for="editEname" class="form-label">사원</label>
                            <input type="text" class="form-control" id="editEname" name="ename" readonly>
                        </div>

                        <!-- 근태코드 -->
                        <div class="mb-3">
                            <label for="editAtdCode" class="form-label">근태(코드)</label>
                            <input type="text" class="form-control" id="editAtdCode" name="atdCode">
                        </div>

                        <!-- 근태수 -->
                        <div class="mb-3">
                            <label for="editAtdNum" class="form-label">근태수</label>
                            <input type="text" class="form-control" id="editAtdNum" name="atdNum">
                        </div>

                        <!-- 근태기간 -->
                        <div class="mb-3">
                            <label for="editAtdDate" class="form-label">근태기간</label>
                            <input type="text" class="form-control" id="editAtdDate" name="atdDate">
                        </div>

                        <!-- 휴가명 -->
                        <div class="mb-3">
                            <label for="editOffDay" class="form-label">휴가명</label>
                            <input type="text" class="form-control" id="editOffDay" name="offDay" readonly>
                        </div>

                        <!-- 휴가사유 -->
                        <div class="mb-3">
                            <label for="editOffDayRs" class="form-label">휴가사유</label>
                            <input type="text" class="form-control" id="editOffDayRs" name="offDayRs" readonly>
                        </div>

                        <!-- 인쇄 -->
                        <div class="mb-3">
                            <label for="editPrint" class="form-label">인쇄</label>
                            <input type="text" class="form-control" id="editPrint" name="print" readonly>
                        </div>

                        <!-- 저장과 취소 버튼 -->
                        <button type="submit" class="btn btn-primary">저장</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>


<script>
    // 링크 클릭 시 모달 열기
    document.getElementById("openModal").addEventListener("click", function(event) {
        event.preventDefault();  // 링크 기본 동작 방지
        var myModal = new bootstrap.Modal(document.getElementById("editModal"));
        myModal.show();
    });
</script>


<%@include file="../include/right_side_info.jsp"%>

