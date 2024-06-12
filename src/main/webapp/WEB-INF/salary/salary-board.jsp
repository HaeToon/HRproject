<%@ page import="com.hrproject.hrproject.dto.SalarySearchDto" %>
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

<%--테이블--%>
<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8"
     style="width: calc(100% - 520px);">
    <h2 class="mt-5 mb-5  ">LIST</h2>
    <div>
        <button class="btn btn-primary insertSalary " data-bs-target="#searchModal" data-bs-toggle="modal">검색</button>
        <a class="btn btn-primary insertSalary" href="../salary/board">전체보기</a>
    </div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th class="align-middle">번호</th>
            <th class="align-middle">사원 번호</th>
            <th class="align-middle">사원 명</th>
            <th class="align-middle">급여구분</th>
            <th class="align-middle">지급구분</th>
            <th class="align-middle">대장명칭</th>
            <th class="align-middle">지급일</th>
            <th class="align-middle">근속연월</th>
            <th class="align-middle">지급액</th>
            <th class="align-middle">수정/삭제</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${salaryList}" var="salaryDto" varStatus="loop">
            <tr>
                <td>${salaryDto.salary_No}</td>
                <td>${salaryDto.empNo}</td>
                <td>${salaryDto.ename}</td>
                <td>${salaryDto.salaryName}</td>
                <td>${salaryDto.salaryCategory}</td>
                <td>${salaryDto.salaryInfo}</td>
                <td>${salaryDto.salaryDay}</td>
                <td>${salaryDto.accountingPeriod}</td>
                <td>${salaryDto.salary}</td>
                <td>
                    <button type="button" class="btn btn-primary modify-button" data-salary-no="${salaryDto.salary_No}"
                            data-bs-toggle="modal" data-bs-target="#modifyConfirmModal">수정
                    </button>

                    <button type="button" class="btn btn-primary delete-button" data-salary-no="${salaryDto.salary_No}"
                            data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <button class="insertSalary btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">신규</button>
    <button class="btn btn-primary" data-bs-target="#modifyModalToggle" data-bs-toggle="modal" hidden="hidden">수정버튼 히든
    </button>
</div>
<%--급여정보 검색 모달 급여정보 검색 모달 급여정보 검색 모달 급여정보 검색 모달 급여정보 검색 모달 급여정보 검색 모달 급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색급여정보 검색--%>
<div class="modal fade" id="searchModal" aria-hidden="true" aria-labelledby="searchModal"
     data-bs-backdrop="static"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="searchModalLabel">급여 정보 검색</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../salary/searchBoard" id="searchModalForm" method="post">
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label=""
                                   name="searchSalary_No">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">사원번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                                   name="searchEmpNo">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">사원 명</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                                   name="searchEName">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">근무 연월</div>
                        <div class="col col-md-4">
                            <input type="month" class="form-control" id="test" name="searchAccountingPeriod">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급구분</div>
                        <div class="col col-md-4">
                            <select class="form-control" id="testteset" name="searchSalaryCategory">
                                <option value="">-</option>
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
                            <select class="form-control" id="testtesttest" name="searchSalaryName">
                                <option value="">-</option>
                                <option value="급여구분 옵션 1">급여구분 옵션 1</option>
                                <option value="급여구분 옵션 2">급여구분 옵션 2</option>
                                <option value="급여구분 옵션 3">급여구분 옵션 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급월</div>
                        <div class="col col-md-4">
                            <input type="month" class="form-control" id="testtesttestteset"
                                   placeholder="select paymentDay"
                                   name="searchSalaryDay">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여 대장명칭</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="salaryInfo"
                                   name="searchSalaryInfo">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급액</div>
                        <div class="col col-md-4">
                            <input type="number" class="form-control" placeholder="최소 금액" aria-label="minSalary"
                                   name="searchMinSalary">
                        </div>
                        <div class="col col-md-4">
                            <input type="number" class="form-control" placeholder="최대 금액" aria-label="maxSalary"
                                   name="searchMaxSalary">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">사원 찾기
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" form="searchModalForm" class="btn btn-primary">검색</button>
                <button type="reset" form="searchModalForm" class="btn btn-danger">리셋</button>
            </div>
        </div>
    </div>
</div>
<%--수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달--%>
<div class="modal fade" id="modifyConfirmModal" tabindex="-1" aria-labelledby="modifyConfirmModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modifyConfirmModalLabel">Modify Confirmation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="password" class="form-control" id="modifyPasswordInput"
                       placeholder="비밀번호 1234/ 로그인 세션에서 값 받아서 비교해야함">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="confirmModifyPassword()">확인</button>
            </div>
        </div>
    </div>
</div>
<%-- 삭제 모달   삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달 --%>
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="delete_h1">Delete Confirmation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="password" class="form-control" id="deletePasswordInput"
                       placeholder="비밀번호 1234/ 로그인 세션에서 값 받아서 비교해야함">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="confirmDelete()">확인</button>
            </div>
        </div>
    </div>
</div>
<%--수정 모달  수정 모달 수정 모달 수정 모달 수정 모달 수정 모달--%>
<div class="modal fade" id="modifyModalToggle" aria-hidden="true" aria-labelledby="modifyModalToggleLabel"
     data-bs-backdrop="static"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modifyModalToggleLabel">급여 정보 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../salary/modify" id="modifyModalForm" method="post">
                    <input type="text" hidden="hidden" id="salary_No_orig" name="salary_No_orig">
                    <input type="text" hidden="hidden" id="empNo_orig" name="empNo_orig">
                    <input type="text" hidden="hidden" id="ename_orig" name="ename_orig">
                    <input type="date" hidden="hidden" id="accountingPeriod_orig" name="accountingPeriod_orig">
                    <input type="text" hidden="hidden" id="paymentType_orig" name="salaryCategory_orig">
                    <input type="text" hidden="hidden" id="paymentType02_orig" name="salaryName_orig">
                    <input type="date" hidden="hidden" id="salaryDay_orig" name="salaryDay_orig">
                    <input type="text" hidden="hidden" id="salary_orig" name="salary_orig">
                    <input type="text" hidden="hidden" id="salaryInfo_orig" name="salaryInfo_orig">

                    <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                           hidden="hidden" readonly id="salary_No_modify" name="salary_No_modify" value="">
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">사원번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                                   readonly id="empNo_modify" name="empNo_modify" value="">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">사원 이름</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="ename"
                                   readonly id="ename_modify" name="ename_modify" value="">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">근무 연월</div>
                        <div class="col col-md-4">
                            <input type="month" class="form-control" id="accountingPeriod_modify"
                                   name="accountingPeriod_modify">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">지급구분</div>
                        <div class="col col-md-4">
                            <select class="form-control" id="paymentType_modify" name="salaryCategory_modify">
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
                            <select class="form-control" id="paymentType02_modify" name="salaryName_modify">
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
                            <input type="date" class="form-control" id="salaryDay_modify"
                                   placeholder="select paymentDay"
                                   name="salaryDay_modify">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="salary"
                                   id="salary_modify" name="salary_modify">
                        </div>
                    </div>
                    <div class="row">
                        <%-- form body --%>
                        <div class="col">급여 대장명칭</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="00008" aria-label="salaryInfo"
                                   id="salaryInfo_modify" name="salaryInfo_modify">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" form="modifyModalForm" class="btn btn-primary">수정</button>
            </div>
        </div>
    </div>
</div>
<%--    신규 값 넣는 모달 --%>
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
                            <input type="text" class="form-control" placeholder="00008" aria-label="empNo" name="empNo"
                                   id="empNo">
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

<%--사원 찾는 모달--%>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2"
     data-bs-backdrop="static" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">사원 찾기</h1>
                <div class="col-6">
                    <div class="input-group mt-3 mx-5">
                        <input type="text" class="form-control" placeholder="ex)홍길동" aria-label="empNo" id="searchName">
                        <button class="btn btn-primary" type="submit" id="searchEmpNoByName">찾기</button>
                    </div>
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
                    <tbody id="resultTableBody">
                    <!-- 동적으로 데이터 추가 -->
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
<script>
    $(document).ready(function () {
        //salary insert modal 에서 searchEmpno시
        $("#searchEmpNoByName").on("click", function () {
            console.log("searchEmpNoByName clicked")
            const name = $("#searchName").val();

            $.ajax({
                url: "/hrm/searchEmpNoByName",
                type: "POST",
                data: {searchName: name},
                success: function (response) {
                    console.log(response)


                    $("#resultTableBody").empty();

                    response.forEach(function (searchByNameResult) {
                        const row = "<tr>" +
                            "<td>" + searchByNameResult.empNo + "</td>" +
                            "<td>" + searchByNameResult.deptName + "</td>" +
                            "<td>" + searchByNameResult.role + "</td>" +
                            "<td>" + searchByNameResult.ename + "</td>" +
                            "</tr>"
                        $("#resultTableBody").append(row);
                    });
                },
                error: function () {

                }
            })
        })
        //searchEmpno에서 ename클릭시
        $(document).on("click", "#resultTableBody td:nth-child(4)", function () {
            // 클릭된 행의 empNo 값을 가져옴
            var empNoValue = $(this).closest("tr").find("td:eq(0)").text();

            // input 요소의 값을 변경
            $("#empNo").val(empNoValue);
            $("#exampleModalToggle").modal("show");
            $("#exampleModalToggle2").modal("hide");
        });
    })


    let salary_No;
    let selectedSalary = {};

    document.querySelectorAll('.delete-button').forEach(button => {
        button.addEventListener('click', function () {
            salary_No = this.getAttribute('data-salary-no');
            console.log(salary_No)
        });
    });


    function confirmDelete() {
        const password = document.getElementById('deletePasswordInput').value;
        if (password === '1234') {
            console.log("confirmFunc >>>" + salary_No)
            window.location.href = '../salary/delete?salary_No=' + salary_No;
        } else {
            alert('비밀번호가 틀렸습니다.');
            return false;
        }
    }

    function confirmModifyPassword() {
        const password = document.getElementById('modifyPasswordInput').value;
        if (password === '1234') {
            const button = document.querySelector('[data-bs-target="#modifyModalToggle"]');
            button.click();
        } else {
            alert('비밀번호가 틀렸습니다.');
            return false;
        }
    }


    // 수정 버튼 클릭 이벤트 핸들러
    $('.modify-button').click(function () {
        // 클릭된 버튼이 속한 행을 찾기 위해 가장 가까운 tr 요소를 선택
        let $row = $(this).closest('tr');

        // 행에서 데이터를 읽어 selectedSalary 객체에 저장
        selectedSalary.salary_No = $row.find('td:eq(0)').text();
        selectedSalary.empNo = $row.find('td:eq(1)').text();
        selectedSalary.ename = $row.find('td:eq(2)').text();
        selectedSalary.salaryName = $row.find('td:eq(3)').text();
        selectedSalary.salaryCategory = $row.find('td:eq(4)').text();
        selectedSalary.salaryInfo = $row.find('td:eq(5)').text();
        selectedSalary.salaryDay = $row.find('td:eq(6)').text();
        selectedSalary.accountingPeriod = $row.find('td:eq(7)').text();
        selectedSalary.salary = $row.find('td:eq(8)').text();


        $('input#salary_No_modify').val(selectedSalary.salary_No);
        $('input#empNo_modify').val(selectedSalary.empNo);
        $('input#ename_modify').val(selectedSalary.ename);
        $('#accountingPeriod_modify').val(selectedSalary.accountingPeriod);
        $('#paymentType_modify').val(selectedSalary.salaryCategory);
        $('#paymentType02_modify').val(selectedSalary.salaryName);
        $('#salaryDay_modify').val(selectedSalary.salaryDay);
        $('input#salary_modify').val(selectedSalary.salary);
        $('input#salaryInfo_modify').val(selectedSalary.salaryInfo);


        $('input#salary_No_orig').val(selectedSalary.salary_No);
        $('input#empNo_orig').val(selectedSalary.empNo);
        $('input#ename_orig').val(selectedSalary.ename);
        $('#accountingPeriod_orig').val(selectedSalary.accountingPeriod);
        $('#paymentType_orig').val(selectedSalary.salaryCategory);
        $('#paymentType02_orig').val(selectedSalary.salaryName);
        $('#salaryDay_orig').val(selectedSalary.salaryDay);
        $('input#salary_orig').val(selectedSalary.salary);
        $('input#salaryInfo_orig').val(selectedSalary.salaryInfo);
    });
</script>
<%@include file="../include/right_side_info.jsp" %>