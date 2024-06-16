<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<%@include file="../include/left_side_menu.jsp" %>
<style>

    .insert-btn {
        width: 80px;
    }

</style>

<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8"
     style="width: calc(100% - 520px);">
    <h2 class="mt-5 mb-5">EmpWorkList</h2>
    <div class="my-3">
        <form id="myForm" action="../workSchedule/empWorkBoard" method="post">
            <button id="workRecord" class="btn btn-primary">출/퇴근</button>
        </form>
    </div>

    <%--보드--%>
    <table class="table table-striped">
        <thead>
        <tr>

            <th scope="col">날짜</th>
            <th scope="col">출근 시간</th>
            <th scope="col">퇴근 시간</th>

            <th scope="col">상태</th>
            <th scope="col">수정/삭제</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${empWorkList}" var="empWorkDto" varStatus="loop">
            <tr>
                <td>${empWorkDto.workDate}</td>
                <td>${empWorkDto.startTime}</td>
                <td>${empWorkDto.endTime}</td>

                <td>${empWorkDto.status}</td>
                <td>${empWorkDto.etc}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var workRecordBtn = document.getElementById('workRecord');
            var form = document.getElementById('myForm');

            workRecordBtn.addEventListener('click', function(event) {
                // 현재 시각 가져오기
                var today = new Date();
                var hours = String(today.getHours()).padStart(2, '0');
                var minutes = String(today.getMinutes()).padStart(2, '0');
                var formattedTime = hours + ':' + minutes;

                // 팝업 창 띄우기
                var confirmRecord = confirm('현재시각: ' + formattedTime + '\n기록하시겠습니까?');

                // 확인 버튼을 눌렀을 때
                if (confirmRecord) {


                    form.submit();
                } else {
                    // 취소 버튼을 눌렀을 때
                    event.preventDefault(); // 기본 동작 (submit) 막기
                    console.log('기록 취소');
                }
            });
        });
    </script>


<%@include file="../include/right_side_info.jsp" %>