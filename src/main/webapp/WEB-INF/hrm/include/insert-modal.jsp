<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-11
  Time: 오후 5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insertModal" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">인사카드등록</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../hrm/insert" id="modalForm" method="post" enctype="multipart/form-data">
                    <div class="row mt-3">
                        <div class="col">사원번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control is-valid" id="empNo" placeholder="사원번호"
                                   aria-label="empno" name="empNo"
                                   value="${maxEmpNo + 1}" readonly>
                        </div>
                        <div class="col">성명</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control is-invalid" id="ename" placeholder="이름"
                                   aria-label="ename" name="ename">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">영문성명</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" id="foreignName" placeholder="영문이름"
                                   aria-label="foreignName"
                                   name="foreignName">
                        </div>
                        <div class="col">부서</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="deptNo">
                                <option value="10">부서코드:10 | 부서명:개발팀</option>
                                <option value="20">부서코드:20 | 부서명:기획팀</option>
                                <option value="30">부서코드:30 | 부서명:인사팀</option>
                                <option value="40">부서코드:40 | 부서명:회계팀</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">직위/직급</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="positionNo">
                                <option value="10">직급코드:10 | 직급명:사원</option>
                                <option value="20">직급코드:20 | 직급명:대리</option>
                                <option value="30">직급코드:30 | 직급명:과장</option>
                                <option value="40">직급코드:40 | 직급명:차장</option>
                                <option value="50">직급코드:50 | 직급명:대표이사</option>
                            </select>
                        </div>
                        <div class="col">직책</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="role">
                                <option value="팀원">직책 | 팀원</option>
                                <option value="팀장">직책 | 팀장</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">휴대폰번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control is-invalid" id="mobile" placeholder="휴대폰번호 중복체크넣을예정"
                                   aria-label="empno"
                                   name="mobile">
                        </div>
                        <div class="col">여권번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" placeholder="여권번호" aria-label="passport"
                                   name="passport">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">Email</div>
                        <div class="col col-md-4">
                            <input type="email" class="form-control is-invalid" id="email" placeholder="Email 중복체크넣을예정"
                                   aria-label="email" name="email" aria-describedby="basic-addon2">
                            <%--                            <input type="text" class="form-control" placeholder="Recipient's username"--%>
                            <%--                                   aria-label="Recipient's username" aria-describedby="basic-addon2">--%>
<%--                            <span class="input-group-text" id="basic-addon2">@example.com</span>--%>
                        </div>

                        <div class="col">입사일자</div>
                        <div class="col col-md-4">
                            <input type="date" class="form-control is-invalid" id="hireDate" aria-label="hiredate"
                                   name="hireDate">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">입사구분</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="hireType" name="hireType">
                                <option value="10">신입</option>
                                <option value="20">경력</option>
                            </select>
                        </div>
                        <%--                        <div class="col">퇴사일자</div>--%>
                        <%--                        <div class="col col-md-4">--%>
                        <%--                            <input type="date" class="form-control" aria-label="resigndate" name="resignDate">--%>
                        <%--                        </div>--%>
                    </div>
                    <%--                    <div class="row mt-3">--%>
                    <%--                        <div class="col">퇴사사유</div>--%>
                    <%--                        <div class="col col-md-10">--%>
                    <%--                            <input type="text" class="form-control" placeholder="" aria-label="">--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>
                    <div class="row mt-3">
                        <label for="bankAccount" class="form-label">급여통장</label>
                        <div class="input-group input-group-sm mb-3">
                            <span class="input-group-text" name="bankAccount" id="bankAccount">은행명</span>
                            <select class="form-select form-select-sm" aria-label="bankname" name="bankName">
                                <option value="한국은행">은행명: 한국은행</option>
                                <option value="산업은행">은행명: 산업은행</option>
                                <option value="기업은행">은행명: 기업은행</option>
                                <option value="국민은행">은행명: 국민은행</option>
                                <option value="외환은행">은행명: 외환은행</option>
                                <option value="수협중앙회">은행명: 수협중앙회</option>
                                <option value="수출입은행">은행명: 수출입은행</option>
                                <option value="농협은행">은행명: 농협은행</option>
                                <option value="지역농.축협">은행명: 지역농.축협</option>
                                <option value="우리은행">은행명: 우리은행</option>
                            </select>
                            <span class="input-group-text">통장번호</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                   aria-describedby="inputGroup-sizing-sm" name="account">
                            <span class="input-group-text">예금주</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                   aria-describedby="inputGroup-sizing-sm" name="accountHolder">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="postCode" class="form-label">POST CODE</label>
                        <div class="row">
                            <div class="col-auto"><input type="text" class="form-control postCode" id="postCode"
                                                         placeholder="post code" name="postCode" readonly></div>
                            <div class="col-auto">
                                <button type="button" class="btn btn-dark btn-post">우편번호 찾기</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <label for="address" class="form-label">ADDRESS</label>
                        <input type="text" class="form-control address" id="address" placeholder="address"
                               name="address"
                               readonly>
                    </div>
                    <div class="col-sm-6">
                        <label for="detail-address" class="form-label">DETAIL ADDRESS</label>
                        <input type="text" class="form-control detail-address" id="detail-address"
                               placeholder="detail address"
                               name="addressDetail">
                    </div>
                    <div class="mb-3">
                        <label for="profile" class="form-label">PROFILE</label>
                        <input class="form-control" type="file" id="profile" name="profile"
                               accept="image/jpg, image/png, image/gif">
                    </div>
                    <div class="mb-3 preview" style="width: 38px; height: 38px; object-fit: contain">
                        <div id="preview"></div>
                    </div>
                    <div class="col-sm-12">
                        <label for="remarks" class="form-label">비고</label>
                        <textarea class="form-control" id="remarks" name="remarks">...</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="modalForm" class="btn btn-primary" id="btn-insert">Submit</button>
                <button type="reset" form="modalForm" class="btn btn-danger">Reset</button>
            </div>
        </div>
    </div>
</div>

<script>
    $("#btn-insert").on("click", () => {
        /* 필수 입력 사항 체크 */
        if ($("#ename").val().trim() === "") {
            alert("성명은 필수입력 사항입니다.");
            $("#ename").focus();
            return false;
        }
        if ($("#mobile").val().trim() === "") {
            alert("휴대폰번호는 필수입력 사항입니다.");
            $("#mobile").focus();
            return false;
        }
        if ($("#email").val().trim() === "") {
            alert("Email은 필수입력 사항입니다.");
            $("#email").focus();
            return false;
        }
        /* 아이디 중복 체크 */
        if (!isIdChecked) {
            alert("아이디 중복 체크 ㄱㄱ")
            $("#userID").focus();
            return false;
        }
    });


    $("#ename").on("keyup", function () {
        if ($(this).val() !== '') {
            $(this).removeClass('is-invalid');
        } else {
            $(this).addClass('is-invalid');
        }
    });
    $("#mobile").on("keyup", function () {
        if ($(this).val() !== '') {
            $(this).removeClass('is-invalid');
        } else {
            $(this).addClass('is-invalid');
        }
    });
    $("#email").on("keyup", function () {
        if ($(this).val() !== '') {
            $(this).removeClass('is-invalid');
        } else {
            $(this).addClass('is-invalid');
        }
    });
    $(document).ready(function () {
        // 오늘 날짜를 yyyy-mm-dd 형식으로 가져오기
        var today = new Date().toISOString().split('T')[0];

        // max 속성을 오늘 날짜로 설정
        $("#hireDate").attr('max', today);

        $("#hireDate").on("change", function () {
            if ($(this).val() !== '') {
                $(this).removeClass('is-invalid');
                $(".invalid-feedback").hide();
            } else {
                $(this).addClass('is-invalid');
                $(".invalid-feedback").show();
            }
        });
    });

    // var empNoInput = document.getElementById('empNo');
    // var submitBtn = document.getElementById('submitBtn');
    //
    // // 제출 버튼 클릭 시 유효성 검사
    // submitBtn.addEventListener('click', function (event) {
    //     if (empNoInput.value.trim() === '') {
    //         empNoInput.classList.add('is-invalid');
    //     } else {
    //         empNoInput.classList.remove('is-invalid');
    //     }
    // });
</script>