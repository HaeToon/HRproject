<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/header.jsp" %>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">급여 조회</h2>
    </div>
    <div class="salary-check-area d-flex col-12">
        <div class="salary-check-profile position-relative">
            <h2>프로필?</h2>
        </div>
        <div class="salary-check-info position-relative">
            <table>
                <tbody>
                <tr>
                    <td>이름</td>
                </tr>
                <tr>
                    <td>내용</td>
                </tr>
                <tr>
                    <td>내용</td>
                </tr>
                <tr>
                    <td>내용</td>
                </tr>
                <tr>
                    <td>내용</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="salary-check-search-area col-12">
        <div class="left-section col-4">
            <h2>근무 시간표</h2>
            <div class="d-flex input-group">
                <input type="text" class="form-control salary-check-search-year-text " placeholder="ex)2024"
                       id="salary-check-search-year" name="salaryCheckYear">
                <input type="text" class="form-control salary-check-search-month-text " placeholder="ex)06"
                       id="salary-check-search-month" name="salaryCheckMonth">
                <input type="hidden" id="salary-check-search-empNo" name="salaryCheckEmpNo" value="${sessionDto.empNo}">
                <button class="btn btn-primary salary-check-search-btn" id="salary-check-search-btn">검색</button>
            </div>
        </div>
        <div class="center-section col-4">
            <h1 class="salary-check-calendar-date" id="salary-check-calendar-date">${year}년 ${month}월 근무표</h1>
        </div>
    </div>
    <div class="salary-check-calendar-area d-flex">
        <table class="salary-check-calendar">
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
                        <td><c:if test="${day != 0}"><h5 class="calendar-day">${day}</h5>
                        <c:choose>
                            <c:when test="${workDayList[day] == 8}">
                                근무시간 : ${workDayList[day]}</td>
                            </c:when>
                            <c:otherwise>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="salary-check-calendar-total">
            <table>
                <thead>
                <tr>
                    <th>기본근무시간</th>
                    <th>초과근무시간</th>
                </tr>
                </thead>
                <tbody id="total-body">
                <c:forEach items="${weekDates}" var="week" varStatus="loop">
                    <tr>
                        <td>${weekWorkTimes[loop.index]}</td> <!-- loop.index는 0부터 시작하므로 +1을 해서 1부터 시작하게 만듭니다 -->
                        <td></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $("#salary-check-search-btn").on("click", function () {
            var year = $("#salary-check-search-year").val();
            var month = $("#salary-check-search-month").val();

            if (month < 1 || month > 12) {
                alert("월 검색값은 01~12 사이의 정수여야합니다.");
                $("#salary-check-search-month").focus();
                return;
            }
            const salaryCheckEmpNo = $("#salary-check-search-empNo").val();
            console.log("year==" + year)
            console.log("month==" + month)
            console.log("salaryCheckEmpNo==" + salaryCheckEmpNo)
            var message = "";
            $.ajax({
                url: "/salary/check",
                method: "POST",
                data: {
                    empNo: salaryCheckEmpNo,
                    year: year,
                    month: month,
                },
                success: function (response) {
                    $("#salary-check-calendar-date").text(year + " " + month + "월 근무표");

                    var calendarBody = $("#calendar-body");
                    var totalBody = $("#total-body");

                    calendarBody.empty();
                    totalBody.empty();

                    var workDayList = response.workDayList; // 응답에서 workDayList 가져오기
                    var weeklyWorkTimes = []; // 주간 근무 시간 저장

                    response.weekDates.forEach(function (week) {
                        var weekRow = '<tr>';
                        var weeklyWorkTime = 0;
                        week.forEach(function (day) {
                            if (day != 0) {
                                var workTime = workDayList[day]; // 배열 인덱스는 0부터 시작하므로 day - 1
                                weekRow += '<td><h5 class="calendar-day">' + day + '</h5>';
                                if (workTime != 0) {
                                    weekRow += "근무시간 : " + workTime;
                                    weeklyWorkTime += workTime;
                                }
                                weekRow += '</td>';
                            } else {
                                weekRow += '<td></td>';
                            }
                        });
                        weekRow += '</tr>';
                        weeklyWorkTimes.push(weeklyWorkTime);
                        calendarBody.append(weekRow);
                    });
                    for (var i = 0; i < response.numberOfWeeks; i++) {
                        totalBody.append('<tr><td>' + weeklyWorkTimes[i] + '</td><td></td></tr>');
                    }
                },
                error: function () {
                    message = "검색값은 4자리-2자리 정수여야합니다. \n 예)2024-05"
                    alert(message)
                }
            })

        })
    })
</script>
