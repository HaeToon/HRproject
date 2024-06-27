<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>


<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title"><h2 class="title">출/퇴근 목록</h2></div>

    <div class="attend-content-area p-3">

        <div class="salary-search-area">
            <button class="salary-search-button btn btn-primary insertSalary " data-bs-target="#searchModal_work"
                    data-bs-toggle="modal">검색
            </button>
            <a class="salary-search-button btn btn-primary insertSalary" href="../workSchedule/adminWorkBoard">새로고침</a>
        </div>
        <%--보드--%>
        <table class="table ">
            <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">날짜</th>
                <th scope="col">사원번호</th>
                <th scope="col">부 서</th>
                <th scope="col">사원 이름</th>
                <th scope="col">출근 시간</th>
                <th scope="col">퇴근 시간</th>
                <th scope="col">상태</th>
                <th scope="col">휴가</th>
                <th scope="col">수정/삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${adminWorkList}" var="adminWorkDto" varStatus="loop">
                <tr>
                    <td>${adminWorkDto.workIdx}</td>
                    <td>${adminWorkDto.workDate}</td>
                    <td>${adminWorkDto.empNo}</td>
                    <td>${adminWorkDto.deptName}</td>
                    <td>${adminWorkDto.ename}</td>
                    <td>${adminWorkDto.startTime}</td>
                    <td>${adminWorkDto.endTime}</td>
                    <td>${adminWorkDto.status}</td>
                    <td>${adminWorkDto.vacationCode}</td>
                    <td>


                        <button type="button" class="btn btn-primary modify-button"
                                data-workIdx="${adminWorkDto.workIdx}"
                                data-bs-toggle="modal" data-bs-target="#modifyWorkConfirmModal">수정
                        </button>
                        <button type="button" class="btn btn-primary delete-button"
                                data-workIdx="${adminWorkDto.workIdx}"
                                data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제
                        </button>
                        <button class="btn btn-primary" data-bs-target="#modifyWorkModalToggle" data-bs-toggle="modal"
                                hidden="hidden">수정버튼 히든</button>


                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


    <nav aria-label="Page navigation example" class="mt-3">
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

<%--검색 모달--%>
    <div class="modal fade" id="searchModal_work" aria-hidden="true" aria-labelledby="searchModal"
         data-bs-backdrop="static"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="searchModalLabel">출퇴근 정보 검색</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../workSchedule/adminWorkBoard" id="searchModalForm" method="post">
                        <div class="row">
                            <div class="col">날짜</div>
                            <div class="col col-md-4">
                                <input type="date" class="form-control" id="search_work_date" name="searchWorkDate">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">사원번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                                       name="searchWorkEmpNo">
                            </div>
                        </div>


                        <div class="row">
                            <div class="col">부서</div>
                            <div class="col col-md-4">
                                <select class="form-control" id="" name="searchWorkDept">
                                    <option value="">-</option>
                                    <option value="부서명 1">부서명 1</option>
                                    <option value="부서명 2">부서명 2</option>
                                    <option value="부서명 3">부서명 3</option>
                                </select>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col">사원 이름</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                                       name="searchWorkEName">
                            </div>
                        </div>


                        <div class="row">
                            <div class="col">상태</div>
                            <div class="col col-md-4">
                                <select class="form-control" name="searchWorkStatus">
                                    <option value="">-</option>
                                    <option value="출근">출근</option>
                                    <option value="퇴근">퇴근</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">휴가</div>
                            <div class="col col-md-4">
                                <select class="form-control" name="searchWorkVacationCode">
                                    <option value="">-</option>
                                    <option value="휴가 코드 1">휴가 코드 1</option>
                                    <option value="휴가 코드 2">휴가 코드 2</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" form="searchModalForm" class="btn btn-primary">검색</button>
                    <button type="reset" form="searchModalForm" class="btn btn-danger">리셋</button>
                </div>
            </div>
        </div>
    </div>


    <%--수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달수정 컨펌 모달 수정 컨펌 모달 수정 컨펌 모달--%>
    <div class="modal fade" id="modifyWorkConfirmModal" tabindex="-1" aria-labelledby="modifyConfirmModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modifyConfirmModalLabel">Modify Confirmation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="password" class="form-control" id="modifyPasswordInput"
                           placeholder="비밀번호 1234/ 로그인 세션에서 값 받아서 비교해야함">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="confirmModifyPassword()">확인</button>
                </div>
            </div>
        </div>
    </div>
    <%-- 삭제 모달   삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달  삭제 모달 --%>
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModal"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="delete_h1">Delete Confirmation</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="password" class="form-control" id="deletePasswordInput"
                           placeholder="비밀번호 1234/ 로그인 세션에서 값 받아서 비교해야함">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="confirmDelete()">확인</button>
                </div>
            </div>
        </div>
    </div>
    <%--수정 모달  수정 모달 수정 모달 수정 모달 수정 모달 수정 모달--%>
    <div class="modal fade" id="modifyWorkModalToggle" aria-hidden="true" aria-labelledby="modifyWorkModalToggleLabel"
         data-bs-backdrop="static"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modifyWorkModalToggleLabel">출퇴근 기록 수정</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../workSchedule/modify" id="modifyModalForm" method="post">
                        <input type="text" class="form-control" placeholder="00008" aria-label="empNo"
                            hidden="hidden"    readonly id="workIdx_modify" name="workIdx_modify" value="">
                        <div class="row">
                            <%-- 출근 시간 --%>
                            <div class="col">출근시간</div>
                            <div class="col col-md-4">
                                <input type="time" class="form-control" aria-label="출근시간 입력" id="startTime_modify" name="modifyStartTime">
                                <input type="checkbox" id="chkClearStartTime"> <label for="chkClearStartTime">시간 초기화</label>
                            </div>
                        </div>

                        <div class="row">
                            <%-- 퇴근 시간 --%>
                            <div class="col">퇴근시간</div>
                            <div class="col col-md-4">
                                <input type="time" class="form-control" aria-label="퇴근시간 입력" id="endTime_modify" name="modifyEndTime">
                                <input type="checkbox" id="chkClearEndTime"> <label for="chkClearEndTime">시간 초기화</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">상태</div>
                            <div class="col col-md-4">
                                <select class="form-control" name="searchWorkStatus">
                                    <option value="">-</option>
                                    <option value="출근">출근</option>
                                    <option value="퇴근">퇴근</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>


                <div class="modal-footer">
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" form="modifyModalForm" class="btn btn-primary">수정</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        document.addEventListener('DOMContentLoaded', function () {
            // 출근 시간 체크박스
            document.getElementById('chkClearStartTime').addEventListener('change', function () {
                var startTimeInput = document.getElementById('startTime_modify');
                startTimeInput.value = this.checked ? null : startTimeInput.value;
            });

            // 퇴근 시간 체크박스
            document.getElementById('chkClearEndTime').addEventListener('change', function () {
                var endTimeInput = document.getElementById('endTime_modify');
                endTimeInput.value = this.checked ? null : endTimeInput.value;
            });
        });



        let selectedWork = {};
        let formatStartTime;
        let formatEndTime;
        $('.modify-button').click(function () {
            // 클릭된 버튼이 속한 행을 찾기 위해 가장 가까운 tr 요소를 선택
            let $row = $(this).closest('tr');

            // 행에서 데이터를 읽어 selectedSalary 객체에 저장
            selectedWork.workIdx = $row.find('td:eq(0)').text();
            selectedWork.startTime = $row.find('td:eq(5)').text();
            selectedWork.endTime = $row.find('td:eq(6)').text();
            formatStartTime =selectedWork.startTime.split(':').slice(0, 2).join(':');
            formatEndTime = selectedWork.endTime.split(':').slice(0, 2).join(':');


            console.log(selectedWork.workIdx);
            console.log(selectedWork.startTime);
            console.log(selectedWork.endTime);



            $('input#workIdx_modify').val(selectedWork.workIdx);
            $('input#startTime_modify').val(formatStartTime);
            $('input#endTime_modify').val(formatEndTime);

        });



        let workIdx;
        document.querySelectorAll('.delete-button').forEach(button => {
            button.addEventListener('click', function () {
                workIdx = this.getAttribute('data-workIdx');
                console.log(workIdx)
            });
        });


        function confirmDelete() {
            const password = document.getElementById('deletePasswordInput').value;
            if (password === '1234') {
                console.log("confirmFunc >>>" + workIdx)
                window.location.href = '../workSchedule/delete?workIdx=' + workIdx;
            } else {
                alert('비밀번호가 틀렸습니다.');
                return false;
            }
        }

        function confirmModifyPassword() {
            const password = document.getElementById('modifyPasswordInput').value;
            if (password === '1234') {
                const button = document.querySelector('[data-bs-target="#modifyWorkModalToggle"]');
                button.click();
            } else {
                alert('비밀번호가 틀렸습니다.');
                return false;
            }
        }


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


