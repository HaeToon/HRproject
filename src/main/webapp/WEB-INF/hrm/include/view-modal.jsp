<%--
  Created by IntelliJ IDEA.
  User: JHTA
  Date: 2024-06-12
  Time: 오후 2:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="modal fade" id="viewModal" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">사원 카드</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="employee-card">
                    <h1 class="text-center">사원 카드</h1>
                    <div class="profile-container">
                        <li class="nav-item">
                                <img id="renameProfile_view" class="myPageProfile" src="" alt="Profile Image">
                        </li>
                        <div class="profile-details">
                            <div class="row mb-sm-1 reduce-gap">
                                <label for="empNo_view" class="col-sm col-form-label">사원번호</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="empNo_view"
                                           readonly>
                                </div>
                                <label for="birthDate_view" class="col-sm col-form-label">생일</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="birthDate_view" value="생일없음" readonly>
                                </div>
                            </div>
                            <div class="row mb-sm-1 reduce-gap">
                                <label for="ename_view" class="col-sm col-form-label">성명</label>
                                <div class="col-sm-4">
                                    <%--                                    <input type="text" class="form-control" id="ename" value="${hrmViewDto.ename}"--%>
                                    <%--                                           readonly>--%>
                                    <input type="text" class="form-control" placeholder="사원 이름" aria-label="ename"
                                           readonly id="ename_view" name="ename_view" value="">
                                </div>
                                <label for="deptName_view" class="col-sm col-form-label">부서</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="deptName_view"
                                           readonly>
                                </div>
                            </div>
                            <div class="row mb-sm-1 reduce-gap">
                                <label for="email_view" class="col-sm col-form-label">Email</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="email_view"
                                           readonly>
                                </div>
                                <label for="hireDate_view" class="col-sm col-form-label">입사일</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="hireDate_view" value="생일없음" readonly>
                                </div>
                            </div>
                            <div class="row mb-sm-1 reduce-gap">
                                <label for="mobile_view" class="col-sm col-form-label">전화</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="mobile_view" readonly>
                                </div>
                                <label for="position_view" class="col-sm col-form-label">직급</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="position_view" readonly>
                                </div>
                            </div>
                            <div class="row mb-sm-1 reduce-gap">
                                <label for="passport_view" class="col-sm col-form-label">여권</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="passport_view" readonly>
                                </div>
                                <label for="roleName_view" class="col-sm col-form-label">직책</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="roleName_view" readonly>
                                </div>
                            </div>
                            <div class="row mb-3-sm-1">
                                <label for="address_view" class="col-sm-2 col-form-label">주소</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="address_view" readonly>
                                </div>
                            </div>
                            <div class="row mb-3-sm-1">
                                <label for="bankAccount_view" class="col-sm-2 col-form-label">급여통장</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="bankAccount_view" readonly>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-sm-12">
                                    <label for="remarks_view" class="form-label">비고</label>
                                    <textarea class="form-control" id="remarks_view" name="remarks"
                                              value="${hrmViewDto.remarks}"
                                              readonly>비고란</textarea>
                                </div>
                            </div>
<%--                            <div class="text-end mt-3">--%>
<%--                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>--%>
<%--                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">인쇄</button>--%>
<%--                            </div>--%>

                        </div>
                    </div>
                </div>
            </div>
            <div class="text-end mt-3">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-secondary" id="btn-print">인쇄</button>
            </div>
        </div>
    </div>
</div>

<script>
    let empNoView;
    $("#btn-print").on("click", function () {
        empNoView = $("#empNo_view").val();

        // 프린트를 위한 URL 설정
        var printUrl = "../hrm/print?hrmPrintEmpNo=" + empNoView;

        // 새 창을 화면 가운데에 위치시키고 크게 열기
        var printWindow = window.open(printUrl);

        // 새 창이 로드된 후 프린트 명령 실행
        printWindow.onload = function() {
            printWindow.print();
            // printWindow.close(); // 프린트 후 창 닫기
        };
    });
</script>