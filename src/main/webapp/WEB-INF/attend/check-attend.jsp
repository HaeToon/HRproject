<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="salary-check-area d-flex col-12">
        <div class="employee-card col-12">
            <div class="profile-container">
                <div class="salary-check-profile">
                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${not empty loginDto.renameProfile}">
                                <img src="${request.contextPath}/upload/${loginDto.renameProfile}" class="myPageProfile">
                            </c:when>
                            <c:otherwise>
                                <img src="../images/profile01.jpg">
                            </c:otherwise>
                        </c:choose>
                    </li>
                </div>
                <div class="salary-profile-details">
                    <h2 class="">이름 : ${loginDto.ename} </h2>
                    <hr>
                    <h4>부서 : ${loginDto.deptName}</h4>
                    <h4>직책 : ${loginDto.posName}</h4>
                    <h4>직급 : ${loginDto.roleName}</h4>
                    <h4>입사일 : ${loginDto.hireDate}</h4>
                    <h4>근속연수 :
                        <c:if test="${diffYear != 0}">
                            ${diffYear}년
                        </c:if>
                        <c:if test="${diffMonth != 0}">
                            ${diffMonth}월
                        </c:if>
                        <c:if test="${diffDay != 0}">
                            ${diffDay}일
                        </c:if> </h4>
                    <h4>${year}년 ${month}월 발생연차 : ${annualLeave+usedAnnualCount}</h4>
                    <h4>사용가능한 연차 : ${annualLeave}</h4>
                    <h4>사용한 연차 : ${usedAnnualCount}</h4>
                </div>
            </div>
        </div>
    </div>
    <div class="attend-check-search-area col-12">
        <div class="left-section col-4">
            <h2>검색</h2>
            <div class="d-flex input-group">
                <input type="number" class="form-control attend-check-search-year-text " placeholder="연도를 입력하세요"
                       id="attend-check-search-year" name="attendCheckYear">
                <input type="number" class="form-control attend-check-search-month-text " placeholder="월을 입력하세요"
                       id="attend-check-search-month" name="attendCheckMonth">
                <button class="btn btn-primary attend-check-search-btn" type="button" id="attend-check-search-btn">검색</button>
            </div>
        </div>
        <div class="center-section col-4">
            <h1 class="sattend-check-calendar-date" id="attend-check-calendar-date">2024년 06월 근태표</h1>
        </div>
    </div>
    <div class="attend-check-calendar-area d-flex">
        <table class="attend-check-calendar">
            <thead>
            <tr>
                <th>일</th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
                <th>토</th>
            </tr>
            </thead>
            <tbody id="calendar-body">
            <c:forEach items="${weekDates}" var="week">
                <tr>
                    <c:forEach items="${week}" var="day">
                        <td><c:if test="${day != 0}">
                            <h5 class="calendar-day">${day} <br>
                                <c:choose>
                                    <c:when test="${day < 10}">
                                        <c:set var="localDate" value="${year}${month}0${day}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="localDate" value="${year}${month}${day}" />
                                    </c:otherwise>
                                </c:choose>
                                <c:set var="intLocalDate" value="${localDate+0}" />


                                <c:forEach items="${approvedAttendList}" var="attendDto" varStatus="loop">
                                    <c:set var="startDay" value="${fn:replace(attendDto.startAtdDate, '-', '')+0}" />
                                    <c:set var="endDay" value="${fn:replace(attendDto.endAtdDate, '-', '')+0}" />

                                    <c:if test="${startDay <= intLocalDate && endDay >= intLocalDate}">
                                        <br> ${attendDto.ename}
                                    </c:if>
                                </c:forEach>
                            </h5></c:if></td>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <br><br><br>



    <br><br><br><br>

<%--    로그인한 사원의 근태 신청 목록만 출력--%>
    <div>
        <h3> ${loginDto.ename}님의 신청 내역 </h3>
        <hr>
        <%--검색--%>
        <form action="../attend/check" class="row d-flex align-items-center justify-content-start m-0">
            <div class="attend-search-area col-sm-5">
                <div class="row">
                    <div class="col">
                        <select class="form-select" aria-label="Default select example" name="search">
                            <option value="all" ${search eq "all" ? "selected": ""}>전체</option>
                            <option value="aptNo" ${search eq "aptNo" ? "selected": ""}>근태번호</option>
                            <option value="atdCode" ${search eq "atdCode" ? "selected": ""}>근태코드</option>
                            <option value="offDay" ${search eq "offDay" ? "selected": ""}>휴가명</option>
                            <option value="approval" ${search eq "approval" ? "selected": ""}>승인여부</option>
                        </select>
                    </div>
                    <div class="col w-auto">
                        <input type="text" name="searchWord" class="form-control" value="${searchWord}">
                    </div>
                    <div class="col-sm-3">
                        <button class="btn btn-primary w-100">SEARCH</button>
                    </div>
                </div>
            </div>
        </form>

        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">사원번호</th>
                <th scope="col">근태번호</th>
                <th scope="col">사원명</th>
                <th scope="col">근태코드</th>
                <th scope="col">근태수</th>
                <th scope="col">근태기간</th>
                <th scope="col">휴가명</th>
                <th scope="col">휴가사유</th>
                <th scope="col">인쇄</th>
                <th scope="col">승인여부</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${loginAttendList}" var="attendDto" varStatus="loop">
                <tr>
                    <td>${attendDto.empNo}</td>
                    <td>${attendDto.atdNo}</td>
                        <%--근태번호 수정키--%>
                    <td>${attendDto.ename}</td>
                    <td>${attendDto.atdCode}</td>
                    <td>${attendDto.atdNum}</td>
                    <td>${attendDto.atdDate}</td>
                    <td>${attendDto.offDay}</td>
                    <td>${attendDto.offDayRs}</td>
                    <td>${attendDto.print}</td>
                    <td>${attendDto.approval}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <%--신규 버튼--%>
        <button class="attend-check-Insert-btn btn btn-primary w-20" data-bs-target="#insertAttendCheckModal"
                data-bs-toggle="modal">휴가 신청
        </button>
    </div>




    <%--attend insert 모달--%>
    <div class="modal fade" id="insertAttendCheckModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         data-bs-backdrop="static"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">휴가 신청</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <form action="../attend/check/insert" id="insertAttendCheck" method="post">
                        <div class="row mb-3">
                            <label for="insertEmpNo" class="col-sm-2 col-form-label">사원번호</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="insertEmpNo" name="insertEmpNo" value="${loginDto.empNo}" readonly>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdNo" class="col-sm-2 col-form-label">근태번호</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="atdNo" name="atdNo" placeholder="근태번호를 입력하세요.">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="eName" class="col-sm-2 col-form-label">사원명</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="ename" name="ename" value="${loginDto.ename}" readonly>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdCode" class="col-sm-2 col-form-label">근태코드</label>
                            <div class="col-sm-10">
                                <select class="form-select" id="atdCode" name="atdCode">
                                    <option value="">근태 코드를 입력하세요.</option>
                                    <option value="A01">A01 : 연차</option>
                                    <option value="A02">A02 : 반차</option>
                                    <option value="A03">A03 : 병가</option>
                                    <option value="B01">B01 : 경조사</option>
                                    <option value="C01">C01 : 교육</option>
                                    <option value="C02">C02 : 연수</option>
                                    <option value="C03">C03 : 기타</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">근태기간</label>
                            <div class="col-sm-10 col-auto">
                                <input type="date" class="form-control" id="startAtdDate" name="startAtdDate"> ~ <input
                                    type="date" class="form-control" id="endAtdDate" name="endAtdDate">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="atdNum" class="col-sm-2 col-form-label">근태수</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" id="atdNum" name="atdNum" step="0.1">
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" form="insertAttendCheck" id="AttendInsertSubmitBtn" class="btn btn-primary">
                        신청
                    </button>
                    <button type="reset" form="insertAttendCheck" class="btn btn-danger">리셋</button>
                </div>
            </div>
        </div>
    </div>


    <script>

        document.addEventListener("DOMContentLoaded", function() {
            const startAtdDate = document.getElementById("startAtdDate");
            const endAtdDate = document.getElementById("endAtdDate");
            const atdNum = document.getElementById("atdNum");

            function calculateDays() {
                const startDate = new Date(startAtdDate.value);
                const endDate = new Date(endAtdDate.value);

                if (!isNaN(startDate) && !isNaN(endDate) && startDate <= endDate) {
                    const timeDifference = endDate - startDate;
                    const dayDifference = timeDifference / (1000 * 3600 * 24) + 1;
                    atdNum.value = dayDifference.toFixed(1);
                } else {
                    atdNum.value = "";
                }
            }

            startAtdDate.addEventListener("change", calculateDays);
            endAtdDate.addEventListener("change", calculateDays);
        });


        //달력
        // Ajax 요청 후 달력 생성 예시
        $(document).ready(function () {
            $("#attend-check-search-btn").on("click", function () {
                let year = $("#attend-check-search-year").val();
                let month = $("#attend-check-search-month").val();

                if (month<1 || month>12){
                    alert("월 검색 값은 01~12 여야합니다.")
                    $("#attend-check-search-month").focus();
                    return;
                }
                $.ajax({
                    url: "/attend/check",
                    method: "POST",
                    data: {
                        year: year,
                        month: month,
                    },
                    success: function (response) {
                        $("#attend-check-calendar-date").text(response.year + "년 " + response.month + "월 근태표");

                        var calendarBody = $("#calendar-body");
                        calendarBody.empty();

                        // 서버로부터 받은 데이터를 기반으로 달력 생성

                        response.weekDates.forEach(function(week){
                            var weekRow = "<tr>";
                            week.forEach(function (day) {
                                if (day !== 0) {
                                    weekRow += '<td><h5 class="calendar-day">' + day + '</h5><br>';

                                    if (day<10) {
                                        var currentDate = year+"-"+month+"-0"+day;
                                        if(month<10){
                                            var currentDate = year+"-0"+month+"-0"+day;
                                        }
                                    }else {
                                        if(month<10){
                                            var currentDate = year+"-0"+month+"-"+day;
                                        }else{
                                        var currentDate = year+"-"+month+"-"+day;
                                        }
                                    }


                                    console.log("currentDate"+currentDate)
                                    response.approvedAttendList.forEach(function (attendDto){
                                        if(attendDto.startAtdDate <= currentDate && attendDto.endAtdDate >= currentDate) {
                                            weekRow += attendDto.ename + '<br>';
                                        }
                                    });
                                    weekRow += "</td>";
                                } else {
                                    weekRow += "<td></td>";
                                }
                            });
                            weekRow += "</tr>";
                            calendarBody.append(weekRow);
                        });
                    },
                    error: function (xhr, status, error) {
                        console.log("XHR: " + JSON.stringify(xhr));
                        alert("서브밋 에러");
                        alert("XHR: " + JSON.stringify(xhr)); // XHR 객체를 문자열로 변환하여 출력
                        alert("Status: " + status);
                        alert("Error: " + error);
                    },
                });
            });
        });



        // 근태코드 변경 시 휴가명 변경
        $('#atdCode').on('change', function () {
            var selectedAtdCode = $(this).val();
            var offDayInput = $('#offDay');

            switch (selectedAtdCode) {
                case 'A01':
                    offDayInput.val('연차');
                    break;
                case 'A02':
                    offDayInput.val('반차');
                    break;
                case 'A03':
                    offDayInput.val('병가');
                    break;
                case 'B01':
                    offDayInput.val('경조사');
                    break;
                case 'C01':
                    offDayInput.val('교육');
                    break;
                case 'C02':
                    offDayInput.val('연수');
                    break;
                case 'C03':
                    offDayInput.val('기타');
                    break;
                default:
                    offDayInput.val('');
                    break;
            }
        });

        //외래키 사원번호 예외처리
        $(document).ready(function () {
            $("#insertAttendCheck").on('submit', function (event) {
                var empNo = $('#insertEmpNo').val();
                var atdNo = $('#atdNo').val();
                var ename = $('#ename').val();
                var startAtdDate = $('#startAtdDate').val();
                var endAtdDate = $('#endAtdDate').val();
                var atdCode = $('#atdCode').val();

                //사원번호를 입력하지 않은경우
                if (!empNo) {
                    event.preventDefault();
                    alert('사원번호를 입력해주세요.');
                    $('#insertEmpNo').val('');
                    $('#insertEmpNo').focus();
                    return;
                }
                //근태번호를 입력하지 않은경우
                if (!atdNo) {
                    event.preventDefault();
                    alert('근태번호를 입력해주세요.');
                    $('#atdNo').val('');
                    $('#atdNo').focus();
                    return;
                }
                //사원명을 입력하지 않은경우
                if (!ename) {
                    event.preventDefault();
                    alert('사원명을 입력해주세요.');
                    $('#ename').val('');
                    return;
                }

                //근태코드를 입력하지 않은경우
                if (!atdCode) {
                    event.preventDefault();
                    alert('근태코드를 입력해주세요.');
                    return;
                }

                //근태기간을 입력하지 않은경우
                if (!startAtdDate || !endAtdDate) {
                    event.preventDefault();
                    alert('근태기간을 입력해주세요.');
                    return;
                }

                //근태기간이 잘못된경우 시작과 끝이 안맞는 경우
                if (startAtdDate > endAtdDate) {
                    event.preventDefault();
                    alert('잘못된 근태기간입니다.');
                    return;
                }

                // empNo와 atdNo 입력후 조건검사
                if (empNo && atdNo) {
                    event.preventDefault();
                    $.ajax({
                        url: "/attend/insertEmpNoCheck",
                        method: "POST",
                        data: {empNo: empNo},
                        success: function (response) {
                            if (response === 1) {
                                $.ajax({
                                    url: "/attend/insertAtdNoCheck",
                                    method: "POST",
                                    data: {atdNo: atdNo},
                                    success: function (response) {
                                        if (response === 1) {
                                            alert("중복된 근태번호입니다.")
                                            $("#atdNo").focus();
                                            return false;
                                        } else {
                                            $("#insertAttendCheck").unbind('submit').submit();
                                        }
                                    },
                                    error: function () {
                                        alert("알수없는 오류 발생");
                                    }
                                })
                            } else {
                                alert("존재하지않는 사원번호입니다.")
                                $("#insertEmpNo").focus();
                                return false;
                            }
                        },
                        error: function () {
                            alert("알수없는 오류 발생");
                        }
                    });
                }
            });
        });

        window.onload = function () {
            var urlParams = new URLSearchParams(window.location.search);

            if (urlParams.get('AttendInsertSuccess') === 'true') {
                alert('등록 되었습니다.');
            }
        };



    </script>