<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>


<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title"><h2 class="title">출/퇴근 목록</h2></div>

    <div class="attend-content-area p-3 ">
        <form id="myForm" action="../workSchedule/empWorkBoard" method="post">
            <button id="workRecord" class="btn btn-primary">출/퇴근</button>
        </form>


        <%--보드--%>
        <table class="table ">
            <thead>
            <tr>

                <th scope="col">날짜</th>
                <th scope="col">출근 시간</th>
                <th scope="col">퇴근 시간</th>
                <th scope="col">상태</th>
                <th scope="col">휴가</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${empWorkList}" var="empWorkDto" varStatus="loop">
                <tr>
                    <td>${empWorkDto.workDate}</td>
                    <td>${empWorkDto.startTime}</td>
                    <td>${empWorkDto.endTime}</td>
                    <td>${empWorkDto.status}</td>
                    <td>${empWorkDto.vacationCode}</td>
                    <td>${empWorkDto.etc}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <nav aria-label="Page navigation example" class="">
        <ul class="pagination d-flex justify-content-center" style="margin-bottom: 0">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=1" aria-label="First">First</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">&laquo;</a>
                </li>
            </c:if>
            <c:forEach begin="1" end="${noOfPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <li class="page-item active"><span class="page-link">${i}</span></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="?page=${i}">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < noOfPages}">
                <li class="page-item">
                    <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">&raquo;</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="?page=${noOfPages}" aria-label="Last">Last</a>
                </li>
            </c:if>
        </ul>
    </nav>



    <script>


        document.addEventListener('DOMContentLoaded', function () {
            var workRecordBtn = document.getElementById('workRecord');
            var form = document.getElementById('myForm');

            workRecordBtn.addEventListener('click', function (event) {
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


