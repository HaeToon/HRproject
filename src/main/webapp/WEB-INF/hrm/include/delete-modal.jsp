<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-14
  Time: 오후 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 삭제 모달  --%>
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
                <input type="text" class="form-control" placeholder="퇴사사유 아직작동안함" name ="outReasons">
                퇴사일자 <input type="date" class="form-control" name ="resignDate">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="confirmDelete()">확인</button>
            </div>
        </div>
    </div>
</div>