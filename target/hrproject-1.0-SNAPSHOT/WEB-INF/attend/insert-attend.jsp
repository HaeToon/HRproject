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

<div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" data-bs-backdrop="static"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalToggleLabel">근태 입력</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../attend/insert" id="modalForm" method="post">
                    <div class="row mb-3">
                        <label for="empNo" class="col-sm-2 col-form-label">사원번호</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empNo">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="attendCount" class="col-sm-2 col-form-label">근태번호</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="attendCount">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="eName" class="col-sm-2 col-form-label">사원명</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="ename">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="attendNo" class="col-sm-2 col-form-label">근태코드</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="attendNo">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="num" class="col-sm-2 col-form-label">근태수</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="num">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="attendNo" class="col-sm-2 col-form-label">근태기간</label>
                        <div class="col-sm-10 col-auto">
                            <input type="date" class="form-control" id="startAttendDate"> ~ <input type="date" class="form-control" id="endAttendDate">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="offday" class="col-sm-2 col-form-label">휴가명</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="offday">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="detailOffday" class="col-sm-2 col-form-label">휴가사유</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="detailOffday">
                        </div>
                    </div>

                    <legend class="col-form-label col-sm-2 pt-0">인쇄</legend>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="print" id="printY" value="printY" checked>
                        <label class="form-check-label" for="printY">
                            Y
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="print" id="printN" value="printN">
                        <label class="form-check-label" for="printN">
                            N
                        </label>
                    </div>
                </form>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="modalForm" class="btn btn-primary">Submit</button>
                <button type="reset" form="modalForm" class="btn btn-danger">Reset</button>
            </div>
        </div>
    </div>
</div>






</body>
</html>
