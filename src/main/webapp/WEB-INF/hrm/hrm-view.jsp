<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<link href="../../css/hrm.css" rel="stylesheet">
<div class="employee-card">
    <h1 class="text-center">사원 카드</h1>
    <div class="profile-container">
        <li class="nav-item">
            <img src="../../images/profile01.jpg">
        </li>
        <div class="profile-details">
            <div class="row mb-sm-1 reduce-gap">
                <label for="hireDate" class="col-sm col-form-label">입사일</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="hireDate" value="${hrmViewDto.hireDate}"
                           readonly>
                </div>
                <label for="birth" class="col-sm col-form-label">생일</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="birth" value="생일없음" readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="eName" class="col-sm col-form-label">성명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="ename" value="${hrmViewDto.ename}" readonly>
                </div>
                <label for="deptName" class="col-sm col-form-label">부서명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="deptName" value="${hrmViewDto.deptName}"
                           readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="email" class="col-sm col-form-label">Email</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="email" value="${hrmViewDto.email}" readonly>
                </div>
                <label for="postcode" class="col-sm col-form-label">우편</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="postcode" value="${hrmViewDto.postCode}"
                           readonly>
                </div>
            </div>
            <div class="row mb-3-sm-1">
                <label for="long" class="col-sm-2 col-form-label">주소</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="long"
                           value="${hrmViewDto.address}" readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="mobile" class="col-sm col-form-label">전화</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="mobile" value="${hrmViewDto.mobile}"
                           readonly>
                </div>
                <label for="position" class="col-sm col-form-label">직급</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="position" value="${hrmViewDto.position}"
                           readonly>
                </div>
            </div>
            <div class="row mb-sm-1 reduce-gap">
                <label for="passport" class="col-sm col-form-label">여권</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="passport" value="${hrmViewDto.passport}"
                           readonly>
                </div>
                <label for="role" class="col-sm col-form-label">직책</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="role" value="${hrmViewDto.role}" readonly>
                </div>
            </div>
            <div class="form-row">
                <div class="col-sm-12">
                    <label for="remarks" class="form-label">비고</label>
                    <textarea class="form-control" id="remarks" name="remarks" value="${hrmViewDto.remarks}"
                              readonly>비고란</textarea>
                </div>
            </div>
            <div class="text-end mt-3">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">인쇄</button>
            </div>
        </div>
    </div>
</div>

<%-- Modal view.jsp --%>
<div class="modal fade" id="staticBackdropUpdate" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="staticBackdropLabel2" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel2">사원 정보 변경</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 여기에 Ajax로 페이지 내용이 로드됩니다. -->
            </div>
        </div>
    </div>
</div>