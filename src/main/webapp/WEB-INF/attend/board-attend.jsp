<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<%--attend 내용 영역--%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <%--  제목 영역  --%>
    <div class="board-title">
        <h2 class="title">Attend list</h2>
    </div>
    <%--검색 영역--%>
    <div class="attend-content-area p-3 bg-body-tertiary">
        <form action="../attend/board" class="row d-flex align-items-center justify-content-start m-0">
            <div class="attend-search-area col-sm-5">
                <div class="row">
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

        <%--attend list table--%>
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
                <th scope="col">삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${attendList}" var="attendDto" varStatus="loop">
                <tr>
                    <td>${attendDto.empNo}</td>
                    <td class="updateModal">${attendDto.atdNo}</td> <%--근태번호 수정키--%>
                    <td>${attendDto.ename}</td>
                    <td>${attendDto.atdCode}</td>
                    <td>${attendDto.atdNum}</td>
                    <td>${attendDto.atdDate}</td>
                    <td>${attendDto.offDay}</td>
                    <td>${attendDto.offDayRs}</td>
                    <td>${attendDto.print}</td>
                    <td>
                        <button type="button" class="attend-delete-button btn btn-danger" data-id="${attendDto.atdNo}">삭제</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <%--신규 버튼--%>
        <button class="attend-Insert-btn btn btn-primary" data-bs-target="#insertModalToggle" data-bs-toggle="modal">신규</button>
    </div>
    <%--attend insert 모달--%>
    <div class="modal fade" id="insertModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" data-bs-backdrop="static"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">근태 입력</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../attend/insert" id="insertModalForm" method="post">
                        <div class="row mb-3">
                            <label for="empNo" class="col-sm-2 col-form-label">사원번호</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="empNo" name="empNo">
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
                                <input type="number" class="form-control" id="atdNum" name="atdNum" step="0.1">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">근태기간</label>
                            <div class="col-sm-10 col-auto">
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
                    <button type="submit" form="insertModalForm" id="AttendInsertSubmitBtn" class="btn btn-primary">Submit</button>
                    <button type="reset" form="insertModalForm" class="btn btn-danger">Reset</button>
                </div>
            </div>
        </div>
    </div>


</div>
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
                <form id="editForm" action="/attend/update" method="post">
                    <!-- 사원번호 -->
                    <input type="hidden" id="editEmpNo" name="empNo" value="">

                    <!-- 근태번호 -->
                    <div class="mb-3">
                        <label for="editAtdno" class="form-label">근태번호</label>
                        <input type="text" class="form-control" id="editAtdno" name="atdNo" value="" readonly>
                    </div>

                    <!-- 사원명 -->
                    <div class="mb-3">
                        <label for="editEname" class="form-label">사원명</label>
                        <input type="text" class="form-control" id="editEname" name="ename"  value="" readonly>
                    </div>

                    <!-- 근태코드 -->
                    <div class="mb-3">
                        <label for="editAtdCode" class="form-label">근태코드</label>
                        <input type="text" class="form-control" id="editAtdCode" name="atdCode" value="">
                    </div>

                    <!-- 근태수 -->
                    <div class="mb-3">
                        <label for="editAtdNum" class="form-label">근태수</label>
                        <input type="number" class="form-control" id="editAtdNum" name="atdNum" value="" step="0.1">
                    </div>

                    <!-- 근태기간 -->
                    <div class="mb-3">
                        <label for="editAtdDate" class="form-label">근태기간</label>
                        <input type="text" class="form-control" id="editAtdDate" name="atdDate" value="">
                    </div>

                    <!-- 휴가명 -->
                    <div class="mb-3">
                        <label for="editOffDay" class="form-label">휴가명</label>
                        <input type="text" class="form-control" id="editOffDay" name="offDay" readonly value="">
                    </div>

                    <!-- 휴가사유 -->
                    <div class="mb-3">
                        <label for="editOffDayRs" class="form-label">휴가사유</label>
                        <input type="text" class="form-control" id="editOffDayRs" name="offDayRs" value="">
                    </div>

                    <!-- 인쇄 -->
                    <div class="mb-3">
                        <label for="editPrint" class="form-label">인쇄</label>
                        <input type="text" class="form-control" id="editPrint" name="print" readonly value="">
                    </div>

                    <!-- 저장과 취소 버튼 -->
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    //수정 모달 클릭 이벤트
    $(document).ready(function (){
        $(document).on("click", ".updateModal", function (){
            const selectName=$(this).text();
            $.ajax({
                url: "/attend/attendUpdateInfo",
                method: "POST",
                data: {ATDNO: selectName},
                success: function (response) {
                    $("#editEmpNo").val(response.empNo);
                    $("#editAtdno").val(response.atdNo);
                    $("#editEname").val(response.ename);
                    $("#editAtdCode").val(response.atdCode);
                    $("#editAtdNum").val(response.atdNum);
                    $("#editAtdDate").val(response.atdDate);
                    $("#editOffDay").val(response.offDay);
                    $("#editOffDayRs").val(response.offDayRs);
                    $("#editPrint").val(response.print);
                    // Show the modal
                    $("#editModal").modal("show");
                },
                error: function () {

                }
            })
        })
    })

    // 삭제 버튼 클릭 이벤트
    $(document).on("click", ".attend-delete-button", function () {
        const atdNo = $(this).closest("tr").find(".updateModal").text();  // 근태번호 가져오기
        const row = $(this).closest("tr");

        if (confirm("정말로 삭제하시겠습니까?")) {
            $.ajax({
                url: "/attend/delete",
                method: "POST",
                data: {atdNo: atdNo},
                success: function (response) {
                    if (response.success) {
                        row.remove(); // 성공적으로 삭제되면 해당 행을 제거
                        alert("삭제되었습니다.");
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                },
                error: function () {
                    alert("삭제 중 오류가 발생했습니다.");
                }
            });
        }
    });
    //외래키 사원번호 예외처리
    $(document).ready(function() {
        $("#insertModalForm").on('submit', function(event) {
            var empNo = $('#empNo').val();
            var atdNo = $('#atdNo').val();
            var ename = $('#ename').val();

            //사원번호를 입력하지 않은경우
            if (!empNo) {
                event.preventDefault();
                alert('사원번호를 입력해주세요.');
                $('#empNo').val('');
                $('#empNo').focus();
                return;
            }
            //근태번호를 입력하지 않은경우
            if (!atdNo) {
                event.preventDefault();
                alert('근태번호를 입력해주세요.');
                $('#atdNo').val('');
                $('#atdNo').focus();
                return;
            }
            //사원명을 입력하지 않은경우
            if (!ename) {
                event.preventDefault();
                alert('사원명을 입력해주세요.');
                $('#ename').val('');
                return;
            }
            // empNo와 atdNo 입력후 조건검사
            if (empNo && atdNo) {
                event.preventDefault();
                $.ajax({
                    url:"/attend/insertEmpNoCheck",
                    method:"POST",
                    data:{empNo:empNo},
                    success: function (response){
                        console.log(response)
                        if (response === 1){
                            $.ajax({
                                url:"/attend/insertAtdNoCheck",
                                method:"POST",
                                data:{atdNo:atdNo},
                                success:function (response){
                                    if(response === 1){
                                        alert("중복된 근태번호입니다.")
                                        $("#atdNo").focus();
                                        return false;
                                    }else {
                                        $("#modalForm").unbind('submit').submit();
                                    }
                                },
                                error:function (){
                                    alert("알수없는 오류 발생");
                                }
                            })
                        }else {
                            alert("존재하지않는 사원번호입니다.")
                            $("#empNo").focus();
                            return false;
                        }
                    },
                    error: function (){
                        alert("알수없는 오류 발생");
                    }
                })
            }
        });
    });
</script>
