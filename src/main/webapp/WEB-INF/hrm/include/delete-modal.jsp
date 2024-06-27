<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-14
  Time: 오후 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 삭제 모달  --%>
<div class="modal fade" id="deleteConfirmModal" data-bs-backdrop="static" tabindex="-1"
     aria-labelledby="deleteConfirmModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="delete_h1">Delete Confirmation</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
                <div class="modal-body">
                    <div class="row mt-6">
                        <div class="col">관리자 비밀번호</div>
                        <div class="col col-md-8">
                            <input type="password" class="form-control" id="deletePasswordInput"
                                   placeholder="admin password">
                        </div>
                    </div>
                    <div class="row mt-6">
                        <div class="col">퇴사사유</div>
                        <div class="col col-md-8">
                            <input type="text" class="form-control" placeholder="퇴사사유" id="outReasons" name="outReasons">
                        </div>
                    </div>
                    <div class="row mt-6">
                        <div class="col">퇴사일자</div>
                        <div class="col col-md-8">
                            <input type="date" class="form-control" id="resignDate" name="resignDate">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="confirmDelete()">확인</button>
                </div>
        </div>
    </div>
</div>