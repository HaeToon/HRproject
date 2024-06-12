<%--
  Created by IntelliJ IDEA.
  User: jhta
  Date: 2024-06-10
  Time: 오전 9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<link href="../css/bootstrap.min.css" rel="stylesheet">
<script src="../js/bootstrap.bundle.min.js"></script>
<html>
<head>
    <title>Title</title>

    <style>

    </style>
</head>
<body>
<button class="btn btn-primary" data-bs-target="#editModal" data-bs-toggle="modal">수정</button>

<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">근태 정보 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 근태 정보 수정 폼 -->
                <form id="editForm" action="../board/attend-modify" method="post">
                    <!-- 사원번호 -->
                    <input type="hidden" id="editEmpNo" name="empNo">

                    <!-- 근태번호 -->
                    <div class="mb-3">
                        <label for="editDate" class="form-label">근태일자</label>
                        <input type="date" class="form-control" id="editDate" name="atdDate">
                    </div>

                    <!-- 사원명 -->
                    <div class="mb-3">
                        <label for="editEname" class="form-label">사원</label>
                        <input type="text" class="form-control" id="editEname" name="ename" readonly>
                    </div>

                    <!-- 근태코드 -->
                    <div class="mb-3">
                        <label for="editAtdCode" class="form-label">근태(코드)</label>
                        <input type="text" class="form-control" id="editAtdCode" name="atdCode">
                    </div>

                    <!-- 근태수 -->
                    <div class="mb-3">
                        <label for="editAtdNum" class="form-label">근태수</label>
                        <input type="text" class="form-control" id="editAtdNum" name="atdNum">
                    </div>

                    <!-- 근태기간 -->
                    <div class="mb-3">
                        <label for="editAtdDate" class="form-label">근태기간</label>
                        <input type="text" class="form-control" id="editAtdDate" name="atdDate">
                    </div>

                    <!-- 휴가명 -->
                    <div class="mb-3">
                        <label for="editOffDay" class="form-label">휴가명</label>
                        <input type="text" class="form-control" id="editOffDay" name="offDay" readonly>
                    </div>

                    <!-- 휴가사유 -->
                    <div class="mb-3">
                        <label for="editOffDayRs" class="form-label">휴가사유</label>
                        <input type="text" class="form-control" id="editOffDayRs" name="offDayRs" readonly>
                    </div>

                    <!-- 인쇄 -->
                    <div class="mb-3">
                        <label for="editPrint" class="form-label">인쇄</label>
                        <input type="text" class="form-control" id="editPrint" name="print" readonly>
                    </div>

                    <!-- 저장과 취소 버튼 -->
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
