<%--
  Created by IntelliJ IDEA.
  User: JHTA
  Date: 2024-06-18
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/header.jsp" %>

<div class="modal-body">
    <div class="employee-card">

        <form action="../hrm/print" class="row d-flex align-items-center">
            <h1 class="text-center">사원 카드</h1>
            <div class="profile-container container d-flex">
                <div class="nav-item">
                    <c:choose>
                        <c:when test="${not empty printHrmCardDto.renameProfile}">
                            <img src="${request.contextPath}/upload/${printHrmCardDto.renameProfile}"
                                 class="myPageProfile">
                        </c:when>
                        <c:otherwise>
                            <img src="../images/profile03.jpg" class="myPageProfile">
                        </c:otherwise>
                    </c:choose>

                </div>
                <div class="profile-details">
                    <div class="row mb-sm-1 reduce-gap">
                        <label for="hireDate_view" class="col-sm col-form-label">입사일</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="hireDate_view"
                                   value="${printHrmCardDto.hireDate}"
                                   readonly>
                        </div>
                        <label for="birth_view" class="col-sm col-form-label">생년월일</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="birth_view" value="${printHrmCardDto.birthDate}"
                                   readonly>
                        </div>
                    </div>
                    <div class="row mb-sm-1 reduce-gap">
                        <label for="ename_view" class="col-sm col-form-label">성명</label>
                        <div class="col-sm-4">

                            <input type="text" class="form-control" placeholder="사원 이름" aria-label="ename"
                                   readonly id="ename_view" name="ename_view" value="${printHrmCardDto.ename}">
                        </div>
                        <label for="deptName_view" class="col-sm col-form-label">부서명</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="deptName_view"
                                   value="${printHrmCardDto.deptName}"
                                   readonly>
                        </div>
                    </div>
                    <div class="row mb-sm-1 reduce-gap">
                        <label for="email_view" class="col-sm col-form-label">Email</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="email_view"
                                   value="${printHrmCardDto.email}" readonly>
                        </div>
                        <label for="postCode_view" class="col-sm col-form-label">우편</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="postCode_view"
                                   value="${printHrmCardDto.postCode}" readonly>
                        </div>
                    </div>
                    <div class="row mb-3-sm-1">
                        <label for="address_view" class="col-sm-2 col-form-label">주소</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="address_view"
                                   value="${printHrmCardDto.address}" readonly>
                        </div>
                    </div>
                    <div class="row mb-sm-1 reduce-gap">
                        <label for="mobile_view" class="col-sm col-form-label">전화</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="mobile_view" value="${printHrmCardDto.mobile}"
                                   readonly>
                        </div>
                        <label for="position_view" class="col-sm col-form-label">직급</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="position_view"
                                   value="${printHrmCardDto.posName}"
                                   readonly>
                        </div>
                    </div>
                    <div class="row mb-sm-1 reduce-gap">
                        <label for="passport_view" class="col-sm col-form-label">여권</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="passport_view"
                                   value="${printHrmCardDto.passport}"
                                   readonly>
                        </div>
                        <label for="role_view" class="col-sm col-form-label">직책</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="role_view" value="${printHrmCardDto.roleName}"
                                   readonly>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-sm-12">
                            <label for="remarks_view" class="form-label">비고</label>
                            <textarea class="form-control" id="remarks_view" name="remarks"
                                      value="${printHrmCardDto.remarks}"
                                      readonly>비고란</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(document).ready(function(){
        const printContent = $(".employee-card").html();
        const originalContents = $("body").html();
        $("body").html(printContent);
        window.print();
        //$("body").html(originalContents);
    })

</script>