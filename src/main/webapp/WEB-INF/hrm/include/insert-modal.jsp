<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-11
  Time: 오후 5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="insertModal" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">인사카드등록</h1>
                <button type="button" class="btn-close close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                        <div class="col">생년월일</div>
                        <div class="col col-md-4">
                            <input type="date" class="form-control is-invalid" id="birthDate" aria-label="birthdate"
                                   name="birthDate">
                        </div>
                        <div class="col">영문성명</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" id="foreignName" placeholder="영문이름"
                                   aria-label="foreignName"
                                   name="foreignName">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">휴대폰번호</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" class="form-control is-invalid" id="mobile" placeholder="휴대폰번호"
                                       aria-label="empno" name="mobile" aria-describedby="btn-mobile-duplicate">
                                <button class="btn btn-outline-secondary btn-duplicate" type="button"
                                        id="btn-mobile-duplicate">확인
                                </button>
                            </div>
                        </div>
                        <div class="col">여권번호</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="여권번호" aria-label="passport"
                                       name="passport" aria-describedby="btn-passport-duplicate" id="passport">
                                <button class="btn btn-outline-secondary btn-duplicate" type="button"
                                        id="btn-passport-duplicate">확인
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">Email</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="email" class="form-control is-invalid" id="email" placeholder="Email"
                                       aria-label="email" name="email" aria-describedby="btn-email-duplicate">
                                <button class="btn btn-outline-secondary btn-duplicate" type="button"
                                        id="btn-email-duplicate">확인
                                </button>
                            </div>
                        </div>
                        <div class="col">부서</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="deptNo">
                                <c:forEach var="dept" items="${deptMap}">
                                    <option value="${dept.key}">부서코드:${dept.key} | 부서명:${dept.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">직위/직급</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="positionNo">
                                <c:forEach var="pos" items="${positionMap}">
                                    <option value="${pos.key}">직급코드:${pos.key} | 직급명:${pos.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col">직책</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="select" name="roleName">
                                <option value="팀원">팀원</option>
                                <option value="팀장">팀장</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">입사일자</div>
                        <div class="col col-md-4">
                            <input type="date" class="form-control is-invalid" id="hireDate" aria-label="hiredate"
                                   name="hireDate">
                        </div>
                        <div class="col">입사구분</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" aria-label="hireType" name="hireType">
                                <option value="신입">신입</option>
                                <option value="경력">경력</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <label class="col-2">급여통장</label>
                        <div class="col-10">
                            <div class="input-group">
                                <span class="input-group-text" id="bankName">은행명</span>
                                <select class="form-select col-2" aria-label="은행명 선택" name="bankName">
                                    <option value="한국은행">한국은행</option>
                                    <option value="국민은행">국민은행</option>
                                    <option value="신한은행">신한은행</option>
                                    <option value="우리은행">우리은행</option>
                                    <option value="하나은행">하나은행</option>
                                    <option value="기업은행">기업은행</option>
                                    <option value="외환은행">외환은행</option>
                                </select>
                                <span class="input-group-text">예금주</span>
                                <input type="text" class="form-control col-2" aria-label="accountHolder"
                                       name="accountHolder">
                                <span class="input-group-text">통장번호</span>
                                <input type="text" class="form-control col-6 is-invalid" aria-label="account"
                                       name="account" id="account">
                                <button class="btn btn-outline-secondary btn-duplicate" type="button"
                                        id="btn-account-duplicate">확인
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="postCode" class="col-md-2 col-form-label">우편번호</label>
                        <div class="col-md-6">
                            <div class="input-group">
                                <input type="text" class="form-control postCode is-invalid" id="postCode"
                                       placeholder="우편번호" name="postCode" readonly>
                                <button type="button" class="btn btn-dark btn-post">우편번호 찾기</button>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="address" class="col-md-2 col-form-label">주소</label>
                        <div class="col-10">
                            <input type="text" class="form-control address is-invalid" id="address" placeholder="주소"
                                   name="address" readonly>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="detail-address" class="col-md-2 col-form-label">상세 주소</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control detail-address" id="detail-address"
                                   placeholder="상세주소" name="addressDetail">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="profile" class="col-md-2 col-form-label">프로필사진</label>
                        <div class="col-md-7">
                            <input class="form-control" type="file" id="profile" name="profile"
                                   accept="image/jpg, image/png, image/gif">
                        </div>
                        <div class="col-md-4 preview" style="width: 170px; height: 170px; object-fit: contain">
                            <%--                        <div id="preview"></div>--%>
                            <img class="preview " id="preview" src="../../../images/profile01.jpg">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="remarks" class="col-md-2 col-form-label">비고</label>
                        <div class="col-md-10">
                            <textarea class="form-control" id="remarks" name="remarks">...</textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="modalForm" class="btn btn-primary" id="btn-insert">Submit</button>
                <button type="reset" form="modalForm" class="btn btn-danger" id="reset">Reset</button>
            </div>
        </div>
    </div>
</div>

<script>

    /* 닫기 버튼 클릭시 페이지 새로고침 */
    $(".close").on("click", () => {
        location.reload();
    });

    let emailChecked = false;
    let mobileChecked = false;
    let accountChecked = false;
    let passportChecked = true;
    $('#reset').click(function () {
        $('#birthDate').addClass('is-invalid');
        $('#hireDate').addClass('is-invalid');
        $('#postCode').addClass('is-invalid');
        $('#address').addClass('is-invalid');
        // 이메일 입력 필드 초기화
        $('#email').removeClass('is-valid');
        $('#email').addClass('is-invalid');
        $('#email').prop('readonly', false);

        // 휴대전화 입력 필드 초기화
        $('#mobile').removeClass('is-valid');
        $('#mobile').addClass('is-invalid');
        $('#mobile').prop('readonly', false);

        // 계좌번호 입력 필드 초기화
        $('#account').removeClass('is-valid');
        $('#account').addClass('is-invalid');
        $('#account').prop('readonly', false);

        // 여권 입력 필드 초기화
        $('#passport').removeClass('is-valid');
        $('#passport').removeClass('is-invalid');
        $('#passport').prop('readonly', false);
        emailChecked = false;
        mobileChecked = false;
        accountChecked = false;
        passportChecked = true;
    });

    /* 제출시 필수 입력 사항 공백 없는지 확인 */
    $("#btn-insert").on("click", () => {
        if ($("#ename").val().trim() === "") {
            alert("성명은 필수입력 사항입니다.");
            $("#ename").focus();
            return false;
        }
        if ($("#birthDate").val().trim() === "") {
            alert("생년월일은 필수입력 사항입니다.");
            $("#birthDate").focus();
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
        if ($("#hireDate").val().trim() === "") {
            alert("입사일자는 필수입력 사항입니다.");
            $("#hireDate").focus();
            return false;
        }
        if ($("#account").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#account").focus();
            return false;
        }
        if ($("#postCode").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#postCode").focus();
            return false;
        }
        if ($("#address").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#address").focus();
            return false;
        }
        /* 아이디 중복 체크 */
        if (!emailChecked) {
            alert("이메일 중복확인 필요")
            $("#email").focus();
            return false;
        }
        if (!mobileChecked) {
            alert("휴대폰번호 중복확인 필요")
            $("#mobile").focus();
            return false;
        }
        if (!passportChecked) {
            alert("여권번호 중복확인 필요")
            $("#passport").focus();
            return false;
        }
        if (!accountChecked) {
            alert("계좌번호 중복확인 필요")
            $("#account").focus();
            return false;
        }
    });


    /* 중복 체크 */
    $(".btn-duplicate").on("click", function () {
        var inputId = $(this).prev().attr("id");
        var checkField;
        var checkValue = $("#" + inputId).val();
        var url = "../hrm/duplicate-check";
        var data = {};
        switch (inputId) {
            case "email":
                if (emailChecked) {
                    return; // 이미 중복 확인을 완료한 경우, 추가 확인 방지
                }
                checkField = "email";
                data = {check: checkField, checkValue: checkValue};
                break;
            case "account":
                if (accountChecked) {
                    return; // 이미 중복 확인을 완료한 경우, 추가 확인 방지
                }
                checkField = "account";
                data = {check: checkField, checkValue: checkValue};
                break;
            case "passport":
                if (passportChecked) {
                    return;
                }
                checkField = "passport";
                data = {check: checkField, checkValue: checkValue};
                break;
            case "mobile":
                if (mobileChecked) {
                    return;
                }
                checkField = "mobile";
                data = {check: checkField, checkValue: checkValue};
                break;
            default:
                console.error("Invalid input ID.");
                return;
        }
        $.ajax({
            url: url,
            data: data,
            method: "post",
            success: function (data) {

                if (data.count === -1) {
                    alert("중복 확인 해주세요");
                    $("#" + inputId).val("");
                    $("#" + inputId).focus();
                    return;
                } else if (data.count > 0) {
                    alert("중복");
                    $("#" + inputId).val("");
                    $("#" + inputId).focus();
                } else {
                    const used = confirm("사용가능");
                    if (used) {
                        $("#" + inputId).attr("readonly", true);
                        switch (inputId) {
                            case "email":
                                $("#" + inputId).addClass('is-valid');
                                emailChecked = true;
                                break;
                            case "account":
                                $("#" + inputId).addClass('is-valid');
                                accountChecked = true;
                                break;
                            case "passport":
                                $("#" + inputId).removeClass('is-invalid');
                                $("#" + inputId).addClass('is-valid');
                                passportChecked = true;
                                break;
                            case "mobile":
                                $("#" + inputId).addClass('is-valid');
                                mobileChecked = true;
                                break;
                        }
                    } else {
                        $("#" + inputId).focus();
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                // 오류 처리
            }
        });
    });


    /* 생년월일 날짜 오늘 이후 선택 불가능, 입사일자 = 필수입력사항 선택하면 invalid 제거 */
    $(document).ready(function () {
        // 오늘 날짜를 yyyy-mm-dd 형식으로 가져오기
        var today = new Date().toISOString().split('T')[0];

        // max 속성을 오늘 날짜로 설정
        $("#birthDate").attr('max', today);

        $("#birthDate").on("change", function () {
            if ($(this).val() !== '') {
                $(this).removeClass('is-invalid');
                $(".invalid-feedback").hide();
            } else {
                $(this).addClass('is-invalid');
                $(".invalid-feedback").show();
            }
        });
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

    /* 필수 입력사항 입력하면 invalid 제거 공백시 생성 */
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
    $("#account").on("keyup", function () {
        if ($(this).val() !== '') {
            $(this).removeClass('is-invalid');
        } else {
            $(this).addClass('is-invalid');
        }
    });
    $("#passport").on("keyup", function () {
        if ($(this).val() !== '') {
            passportChecked = false;
            $(this).addClass('is-invalid');
        } else {
            passportChecked = true;
            $(this).removeClass('is-invalid');
        }
    });
</script>