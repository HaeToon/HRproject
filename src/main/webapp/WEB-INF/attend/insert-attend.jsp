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
<button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">신규</button>

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
                            <input type="text" class="form-control" id="empNo" name="empNo">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="atdNo" class="col-sm-2 col-form-label">근태번호</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="atdNo" name="atdNo">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="eName" class="col-sm-2 col-form-label">사원명</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="ename" name="ename">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="atdCode" class="col-sm-2 col-form-label">근태코드</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="atdCode" name="atdCode">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="atdNum" class="col-sm-2 col-form-label">근태수</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="atdNum" name="atdNum">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">근태기간</label>
                        <div class="col-sm-10 col-auto">
                            <input type="date" class="form-control" id="startAtdDate" name="startAtdDate"> ~ <input type="date" class="form-control" id="endAtdDate" name="endAtdDate">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="offDay" class="col-sm-2 col-form-label">휴가명</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="offDay" name="offDay">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="offDayRs" class="col-sm-2 col-form-label">휴가사유</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="offDayRs" name="offDayRs">
                        </div>
                    </div>

                    <legend class="col-form-label col-sm-2 pt-0">인쇄</legend>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="print" id="printY" value="Y" checked>
                        <label class="form-check-label" for="printY">
                            Y
                        </label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="print" id="printN" value="N">
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
