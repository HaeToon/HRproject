<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-11
  Time: 오후 5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="modifyModal" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="modifyHrmToggleLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modifyHrmToggleLabel">사원 정보 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../hrm/update" id="modifyModalForm" method="post" enctype="multipart/form-data">
                    <div class="row mt-3">
                        <div class="col">사원번호</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control is-valid" id="empNo_update"
                                   aria-label="empno" name="empNo" readonly>
                        </div>
                        <div class="col">성명</div>
                        <div class="col col-md-4">
                            <input type="text" class="form-control" id="ename_update" placeholder="이름"
                                   aria-label="ename" name="ename">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">생년월일</div>
                        <div class="col col-md-4">
                            <input type="date" class="form-control" id="birthDate_update" aria-label="birthdate"
                                   name="birthDate">
                        </div>
                        <div class="col">영문성명</div>
                        <div class="col col-md-4">
                            <input type="text" id="foreignName_update" class="form-control" placeholder="영문이름"
                                   aria-label="empno" name="foreignName">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">휴대폰번호</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" id="mobile_update" class="form-control" placeholder="휴대폰번호"
                                       aria-label="empno" name="mobile" id="btn-mobile-update-duplicate">
                                <button class="btn btn-outline-secondary btn-update-duplicate" type="button">확인
                                </button>
                            </div>
                        </div>
                        <div class="col">여권번호</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" id="passport_update" class="form-control" placeholder="여권번호"
                                       aria-label="passport" name="passport" id="btn-passport-update-duplicate">
                                <button class="btn btn-outline-secondary btn-update-duplicate" type="button">확인
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">Email</div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="email" id="email_update" class="form-control" placeholder="Email"
                                       aria-label="email" name="email" id="btn-email-update-duplicate">
                                <button class="btn btn-outline-secondary btn-update-duplicate" type="button">확인
                                </button>
                            </div>
                        </div>
                        <div class="col">부서</div>
                        <div class="col col-md-4">
                                <select class="form-select form-select" id="deptNo_update" aria-label="select"
                                        name="deptNo">
                                    <c:forEach var="dept" items="${deptMap}">
                                    <option value="${dept.key}">부서코드:${dept.key} | 부서명:${dept.value}</option>
                                    </c:forEach>
                                </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">직위/직급</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" id="posNo_update" aria-label="select"
                                    name="positionNo">
                                <c:forEach var="pos" items="${positionMap}">
                                    <option value="${pos.key}">직급코드:${pos.key} | 직급명:${pos.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col">직책</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" id="roleName_update" aria-label="select"
                                    name="roleName">
                                <option value="팀원">팀원</option>
                                <option value="팀장">팀장</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">입사일자</div>
                        <div class="col col-md-4">
                            <input type="date" id="hireDate_update" class="form-control" aria-label="hiredate"
                                   name="hireDate">
                        </div>
                        <div class="col">입사구분</div>
                        <div class="col col-md-4">
                            <select class="form-select form-select" id="hireType_update" aria-label="hireType"
                                    name="hireType">
                                <option value="신입">신입</option>
                                <option value="경력">경력</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <label class="col-2">급여통장</label>
                        <div class="col-10">
                            <div class="input-group">
                                <span class="input-group-text">은행명</span>
                                <select class="form-select col-2" id="bankName_update" aria-label="은행명 선택"
                                        name="bankName">
                                    <c:forEach var="bank" items="${bankMap}">
                                        <option value="${bank.key}">${bank.value}</option>
                                    </c:forEach>
                                </select>
                                <span class="input-group-text">통장번호</span>
                                <input type="text" class="form-control col-6" aria-label="account"
                                       name="account" id="account_update">
                                <span class="input-group-text">예금주</span>
                                <input type="text" class="form-control col-2" aria-label="accountHolder"
                                       name="accountHolder" id="accountHolder_update">
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="postCode_update" class="col-md-2 col-form-label">우편번호</label>
                        <div class="col-md-6">
                            <div class="input-group">
                                <input type="text" class="form-control postCode" id="postCode_update"
                                       placeholder="우편번호" name="postCode" readonly>
                                <button type="button" class="btn btn-dark btn-post">우편번호 찾기</button>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="address_update" class="col-md-2 col-form-label">주소</label>
                        <div class="col-10">
                            <input type="text" class="form-control address" id="address_update"
                                   placeholder="주소"
                                   name="address" readonly>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="addressDetail_update" class="col-md-2 col-form-label">상세 주소</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control detail-address" id="addressDetail_update"
                                   placeholder="상세주소" name="addressDetail">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="profile_update" class="col-md-2 col-form-label">프로필사진</label>
                        <div class="col-md-7">
                            <input class="form-control" type="file" id="profile_update" name="profile"
                                   accept="image/jpg, image/png, image/gif">
                        </div>
                        <div class="col-md-4 preview" style="width: 170px; height: 170px; object-fit: contain">
                            <%--                        <div id="preview"></div>--%>
                            <img id="update_preview" src="../../../images/profile01.jpg">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <label for="remarks_update" class="col-md-2 col-form-label">비고</label>
                        <div class="col-md-10">
                            <textarea class="form-control" id="remarks_update" name="remarks">...</textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="modifyModalForm" class="btn btn-primary" id="btn-update">수정</button>
                <%--                <form action="../hrm/update" type="post">--%>
                <%--                    <input type="hidden" id="empNo_password_update" name="empNo_password">--%>
                <%--                    <button type="submit" form="modifyModalForm" class="btn btn-primary">비밀번호 초기화</button>--%>
                <%--                </form>--%>
            </div>
        </div>
    </div>
</div>

<script>
    let emailChecked_update = true;
    let mobileChecked_update = true;
    let passportChecked_update = true;

    $("#btn-update").on("click", () => {
        /* 필수 입력 사항 체크 */
        if ($("#ename_update").val().trim() === "") {
            alert("성명은 필수입력 사항입니다.");
            $("#ename_update").focus();
            return false;
        }
        if ($("#birthDate_update").val().trim() === "") {
            alert("생년월일은 필수입력 사항입니다.");
            $("#birthDate_update").focus();
            return false;
        }
        if ($("#mobile_update").val().trim() === "") {
            alert("휴대폰번호는 필수입력 사항입니다.");
            $("#mobile_update").focus();
            return false;
        }
        if ($("#email_update").val().trim() === "") {
            alert("Email은 필수입력 사항입니다.");
            $("#email_update").focus();
            return false;
        }
        if ($("#hireDate_update").val().trim() === "") {
            alert("입사일자는 필수입력 사항입니다.");
            $("#hireDate_update").focus();
            return false;
        }
        if ($("#account_update").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#account").focus();
            return false;
        }
        if ($("#postCode_update").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#postCode").focus();
            return false;
        }
        if ($("#address_update").val().trim() === "") {
            alert("통장번호은 필수입력 사항입니다.");
            $("#address").focus();
            return false;
        }
        /* 아이디 중복 체크 */
        if (!emailChecked_update) {
            alert("이메일 중복확인 필요")
            $("#email").focus();
            return false;
        }
        if (!mobileChecked_update) {
            alert("휴대폰번호 중복확인 필요")
            $("#mobile").focus();
            return false;
        }
        if (!passportChecked_update) {
            alert("아이디 중복 체크 ㄱㄱ")
            $("#passport").focus();
            return false;
        }
    });

    $(".btn-update-duplicate").on("click", function () {
        var inputId = $(this).prev().attr("id");
        var checkValue = $("#" + inputId).val();
        var url = "../hrm/duplicate-check";
        var data = {};
        switch (inputId) {
            case "email_update":
                if (emailChecked_update) {
                    return; // 이미 중복 확인을 완료한 경우, 추가 확인 방지
                }
                data = {check: "email", checkValue: checkValue};
                break;
            case "passport_update":
                if (passportChecked_update) {
                    return;
                }
                data = {check: "passport", checkValue: checkValue};
                break;
            case "mobile_update":
                if (mobileChecked_update) {
                    return;
                }
                data = {check: "mobile", checkValue: checkValue};
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
                            case "email_update":
                                $("#" + inputId).addClass('is-valid');
                                emailChecked_update = true;
                                break;
                            case "passport_update":
                                $("#" + inputId).addClass('is-valid');
                                passportChecked_update = true;
                                break;
                            case "mobile_update":
                                $("#" + inputId).addClass('is-valid');
                                mobileChecked_update = true;
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
    });


    $("#ename_update").on("keyup", function () {
        if ($(this).val().trim() === '') {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });
    $("#birthDate_update").on("keyup", function () {
        if ($(this).val().trim() === '') {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });
    $("#account_update").on("keyup", function () {
        if ($(this).val().trim() === '') {
            $(this).addClass('is-invalid');
        } else {
            $(this).removeClass('is-invalid');
        }
    });

    let emailValue;
    let mobileValue;
    let passportValue;
    $("#email_update").on("focus", function () {
        emailValue = $("#email_update").val();
    });
    $("#mobile_update").on("focus", function () {
        mobileValue = $("#mobile_update").val();
    });
    $("#passport_update").on("focus", function () {
        passportValue = $("#passport_update").val();
    });

    $("#email_update").on("keyup", function () {
        if ($(this).val().trim() !== emailValue) {
            $(this).addClass('is-invalid');
            emailChecked_update = false;
        } else {
            emailChecked_update = true;
            $(this).removeClass('is-invalid');
        }
    });

    $("#mobile_update").on("keyup", function () {
        if ($(this).val() !== mobileValue) {
            $(this).addClass('is-invalid');
            mobileChecked_update = false;
        } else {
            mobileChecked_update = true;
            $(this).removeClass('is-invalid');
        }
    });
    // $("#account_update").on("keyup", function () {
    //     if ($(this).val() !== '') {
    //         $(this).addClass('is-invalid');
    //     } else {
    //         $(this).removeClass('is-invalid');
    //     }
    // });
    $("#passport_update").on("keyup", function () {
        if ($(this).val() !== passportValue && $(this).val().trim() !== "") {
            passportChecked_update = false;
            $(this).addClass('is-invalid');
        } else {
            passportChecked_update = true;
            $(this).removeClass('is-invalid');
        }
    });


</script>