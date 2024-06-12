<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<%@include file="../include/left_side_menu.jsp" %>
<div class="container content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-absolute top-0 col-8">
    <table class="table table-sm">
        <thead>
        <tr>
            <%-- 9개 --%>
            <th scope="col"><input type="checkbox" class="btn-check" id="check-all" checked autocomplete="off">
                <label class="btn btn-outline-secondary" for="check-all">-</label><br></th>
            <th scope="col">입사일자</th>
            <th scope="col">사원번호</th>
            <th scope="col">성명</th>
            <th scope="col">부서번호(명)</th>
            <th scope="col">직위/직급명</th>
            <th scope="col">Email</th>
            <th scope="col">계좌번호</th>
            <th scope="col">새로운 항목 추가???</th>
            <th scope="col">인쇄</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${hrmList}" var="hrmDto" varStatus="loop">
            <c:choose>
                <%-- 현재 주소창에 '?page=' param이 없을시 page=1로 설정 --%>
                <c:when test="${param.page == null}"><c:set var="page" value="1"></c:set></c:when>
                <c:otherwise><c:set var="page" value="${param.page}"></c:set></c:otherwise>
            </c:choose>
            <tr>
                <td><input type="checkbox" class="chk btn-check" id="btn-check-${loop.count}" autocomplete="off" >
                    <label class="btn btn-outline-secondary" for="btn-check-${loop.count}">${((page -1) * listPerPage) + loop.count}</label></td>
                <td>${hrmDto.hireDate}</td>
                <td><a href="">${hrmDto.empNo}</a></td>
                <td><a href="">${hrmDto.ename}</a></td>
                <td>${hrmDto.deptName}</td>
                <td>${hrmDto.position}</td>
                <td>${hrmDto.email}</td>
                <td>${hrmDto.account}</td>
                <td><textarea></textarea></td>
                <td><a href="">인쇄</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <c:choose>
            <c:when test="${empty search}">
                <c:set var="firstPage" value="../hrm/board?page=1"></c:set>
                <c:set var="prePage" value="../hrm/board?page=${previousPage}"></c:set>
                <c:set var="selectPage" value="../hrm/board?page="></c:set>
                <c:set var="nextPage" value="../hrm/board?page=${nextPage}"></c:set>
                <c:set var="lastPage" value="../hrm/board?page=${totalPage}"></c:set>
            </c:when>
            <c:otherwise>
                <c:set var="firstPage" value="../hrm/board?search=${search}&searchWord=${searchWord}&page=1"></c:set>
                <c:set var="prePage"
                       value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${previousPage}"></c:set>
                <c:set var="selectPage" value="../hrm/board?search=${search}&searchWord=${searchWord}&page="></c:set>
                <c:set var="nextPage"
                       value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${nextPage}"></c:set>
                <c:set var="lastPage"
                       value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${totalPage}"></c:set>
            </c:otherwise>
        </c:choose>
        <nav aria-label="Page navigation example" class="mt-5 mb-5">
            <ul class="pagination d-flex justify-content-center">
                <c:if test="${startPage ne 1}">
                    <li class="page-item">
                        <a class="page-link" href="${firstPage}" aria-label="Previous">
                            First
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="${prePage}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
                    <c:choose>
                        <c:when test="${page eq i}">
                            <li class="page-item active"><span class="page-link">${i}</span></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="${selectPage}${i}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${endPage ne totalPage}">
                    <li class="page-item">
                        <a class="page-link" href="${nextPage}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="${lastPage}" aria-label="Next">
                            Last
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
        <form action="../hrm/board" class="row g-3 d-flex align-items-center">
            <div class="col-sm-7">
                <div class="row g-3">
                    <div class="col">
                        <select class="form-select" aria-label="Default select example" name="search">
                            <option value="empno" ${search eq "empno" ? "selected": ""}>사원번호</option>
                            <option value="ename" ${search eq "ename" ? "selected": ""}>사원명</option>
                            <option value="deptname" ${search eq "deptname" ? "selected": ""}>부서명</option>
                            <option value="email" ${search eq "email" ? "selected": ""}>이메일</option>
                            <option value="all" ${search eq "all" ? "selected": ""}>all</option>
                        </select>
                    </div>
                    <div class="col w-auto">
                        <input type="text" name="searchWord" class="form-control" value="${searchWord}">
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <button class="btn btn-primary w-100">SEARCH</button>
            </div>
        </form>

        <!-- Scrollable modal -->
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
                data-bs-target="#staticBackdrop">신규
        </button>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
         tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">인사카드등록</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../hrm/board" id="modalForm" method="post" enctype="multipart/form-data">
                        <div class="row mt-3">
                            <div class="col">사원번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="사원번호" aria-label="empno" name="empNo">
                            </div>
                            <div class="col">성명</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="이름" aria-label="ename" name="eName">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">영문성명</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="영문이름" aria-label="empno" name="foreignName">
                            </div>
                            <div class="col">부서</div>
                            <div class="col col-md-4">
                                <select class="form-select form-select" aria-label="select" name="deptNo">
                                    <option value="10">부서코드:10 | 부서명:개발팀</option>
                                    <option value="20">부서코드:20 | 부서명:기획팀</option>
                                    <option value="30">부서코드:30 | 부서명:인사팀</option>
                                    <option value="40">부서코드:40 | 부서명:회계팀</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">직위/직급</div>
                            <div class="col col-md-4">
                                <select class="form-select form-select" aria-label="select" name="positionNo">
                                    <option value="10">직급코드:10 | 직급명:사원</option>
                                    <option value="20">직급코드:20 | 직급명:대리</option>
                                    <option value="30">직급코드:30 | 직급명:과장</option>
                                    <option value="40">직급코드:40 | 직급명:차장</option>
                                    <option value="50">직급코드:50 | 직급명:대표이사</option>
                                </select>
                            </div>
                            <div class="col">직책</div>
                            <div class="col col-md-4">
                                <select class="form-select form-select" aria-label="select" name="role">
                                    <option value="팀원">직책 | 팀원</option>
                                    <option value="팀장">직책 | 팀장</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">휴대폰번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="휴대폰번호" aria-label="empno" name="mobile">
                            </div>
                            <div class="col">여권번호</div>
                            <div class="col col-md-4">
                                <input type="text" class="form-control" placeholder="여권번호" aria-label="passport" name="passport">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">Email</div>
                            <div class="col col-md-4">
                                <input type="email" class="form-control" placeholder="Email" aria-label="email" name="email">
                            </div>
                            <div class="col">입사일자</div>
                            <div class="col col-md-4">
                                <input type="date" class="form-control" aria-label="hiredate" name="hireDate">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">입사구분</div>
                            <div class="col col-md-4">
                                <select class="form-select form-select" aria-label="hireType" name="hireType">
                                    <option value="10">신입</option>
                                    <option value="20">경력</option>
                                </select>
                            </div>
                            <div class="col">퇴사일자</div>
                            <div class="col col-md-4">
                                <input type="date" class="form-control" aria-label="resigndate" name="resignDate">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">퇴사사유</div>
                            <div class="col col-md-10">
                                <input type="text" class="form-control" placeholder="" aria-label="">
                            </div>
                        </div>
                        <div class="row mt-3">
                            <label for="bankAccount" class="form-label">급여통장</label>
                            <div class="input-group input-group-sm mb-3">
                                <span class="input-group-text" name="bankAccount" id="bankAccount">은행명</span>
                                <select class="form-select form-select-sm" aria-label="bankname" name="bankName">
                                    <option value="한국은행">은행명: 한국은행</option>
                                    <option value="산업은행">은행명: 산업은행</option>
                                    <option value="기업은행">은행명: 기업은행</option>
                                    <option value="국민은행">은행명: 국민은행</option>
                                    <option value="외환은행">은행명: 외환은행</option>
                                    <option value="수협중앙회">은행명: 수협중앙회</option>
                                    <option value="수출입은행">은행명: 수출입은행</option>
                                    <option value="농협은행">은행명: 농협은행</option>
                                    <option value="지역농.축협">은행명: 지역농.축협</option>
                                    <option value="우리은행">은행명: 우리은행</option>
                                </select>
                                <span class="input-group-text">통장번호</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                       aria-describedby="inputGroup-sizing-sm" name="account">
                                <span class="input-group-text">예금주</span>
                                <input type="text" class="form-control" aria-label="Sizing example input"
                                       aria-describedby="inputGroup-sizing-sm" name="accountHolder">
                            </div>
                        </div>
                        <div class="row g-3 mt-3 mb-3">
                            <label for="postCode" class="form-label">POST CODE</label>
                            <div class="row">
                                <div class="col-auto"><input type="text" class="form-control" id="postCode"
                                                             placeholder="post code"
                                                             name="postCode" readonly></div>
                                <div class="col-auto">
                                    <button type="button" id="btn-postcode" class="btn btn-dark">우편번호 찾기</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <label for="address" class="form-label">ADDRESS</label>
                            <input type="text" class="form-control" id="address" placeholder="address" name="address"
                                   readonly>
                        </div>
                        <div class="col-sm-6">
                            <label for="detail-address" class="form-label">DETAIL ADDRESS</label>
                            <input type="text" class="form-control" id="detail-address" placeholder="detail address"
                                   name="addressDetail">
                        </div>
                        <div class="mb-3">
                            <label for="profile" class="form-label">PROFILE</label>
                            <input class="form-control" type="file" id="profile" name="profile"
                                   accept="image/jpg, image/png, image/gif">
                        </div>
                        <div class="mb-3 preview" style="width: 38px; height: 38px; object-fit: contain">
                            <div id="preview"></div>
                        </div>
                        <div class="col-sm-12">
                            <label for="remarks" class="form-label">비고</label>
                            <textarea class="form-control" id="remarks" name="remarks">...</textarea>
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
</div>
<script>
    $("#check-all").on("change", function () {

        //  is(":checked") - 제이쿼리에서 체크박스 감지할때 씀
        if ($(this).is(":checked")) {
            $(".chk").prop("checked", true);
            // while문 안의 checkbox들 class명으로 접근
        } else {
            $(".chk").prop("checked", false);
        }
    })

    $("#profile").on("change", function (e) {
        const file = e.currentTarget.files[0];
        if(!file){ // 파일이 선택되지 않은 경우 (지운 경우)
            $("#preview").html(""); // 미리보기 영역 비우기
            return false;
        }
        const extension = file.name.substring(file.name.lastIndexOf(".") + 1).toLowerCase(); // +1 안하면 .png, +1 하면 png 나옴
        console.log(file);
        if (!(extension === "png" || extension === "jpg" || extension === "gif")) {
            alert("이미지 파일만 업로드 가능합니다.");
            $(this).val("");
            return false;
        } else {
            const profileReader = new FileReader();
            profileReader.onload = function (e) {
                console.log(e)
                // currentTarget or target에의 result 가 image임
                const img = e.currentTarget.result;
                /* jsp의 자바스크립트에서 달러{} 을 쓰려면 $앞에 \를 넣어줘야함 = \$ {} */
                $("#preview").html(`<img src="\${img}">`)
            }
            profileReader.readAsDataURL(file);
        }
    })

    /* postcode 버튼 눌러서 주소 팝업창 불러옴 */
    $("#btn-postcode").on("click", makePostCode);

    function makePostCode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ""; // 주소 변수
                let extraAddr = ""; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    $("#extra-address").val(extraAddr);

                } else {
                    $("#extra-address").val("");
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("#postCode").val(data.zonecode);
                $("#address").val(addr);

                // 커서를 상세주소 필드로 이동한다.
                $("#detail-address").focus();
            }
        }).open()({});
    }
</script>
<%@include file="../include/right_side_info.jsp" %>