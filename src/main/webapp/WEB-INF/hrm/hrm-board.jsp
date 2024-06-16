<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<%--   내용 영역  --%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <%--  hrm 제목 영역  --%>
    <div class="board-title">
        <h2 class="title">Hrm list</h2>
    </div>
    <%--  hrm 내용 영역  --%>
    <div class="hrm-content-area p-3 bg-body-tertiary">
        <%--    hrm 검색 영역    --%>
        <div class="hrm-search-area">
            <form action="../hrm/board" class="row d-flex align-items-center">
                <div class="col-sm-3">
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
                    <button class="btn btn-primary">SEARCH</button>
                </div>
            </form>
        </div>
        <%--    hrm 검색 영역  끝   --%>
<%--      hrm list table 영역      --%>
        <table class="table table-sm">
            <thead>
            <tr>
                <%-- 9개 --%>
                <th scope="col">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="" id="check-all">
                        <label class="form-check-label" for="check-all"></label>
                    </div>
                </th>
                <th scope="col">입사일자</th>
                <th scope="col">사원번호</th>
                <th scope="col">성명</th>
                <th scope="col">부서번호(명)</th>
                <th scope="col">직위/직급명</th>
                <th scope="col">Email</th>
                <th scope="col">계좌번호</th>
                <th scope="col">새로운 항목 추가???</th>
                <th scope="col">회원정보변경</th>
            </tr>
            </thead>
            <tbody>

            <form action="../hrm/delete" method="post" id="delete">
                <c:forEach items="${hrmList}" var="hrmDto" varStatus="loop">
                    <c:choose>
                        <%-- 현재 주소창에 '?page=' param이 없을시 page=1로 설정 --%>
                        <c:when test="${param.page == null}"><c:set var="page" value="1"></c:set></c:when>
                        <c:otherwise><c:set var="page" value="${param.page}"></c:set></c:otherwise>
                    </c:choose>
                    <tr>
                        <td>
                            <input type="hidden" name="test" value="test">
                            <div class="form-check form-check-inline">
                                <input class="chk form-check-input" type="checkbox" name="check"
                                       value="${hrmDto.empNo}">
                                <label class="chk form-check-label">${((page -1) * listPerPage) + loop.count}</label>
                            </div>
                        </td>
                        <td>${hrmDto.hireDate}</td>
                        <td><a href="#" data-bs-toggle="modal" class="openModal" data-show="view"
                               data-bs-target="#staticBackdropView"
                               data-empno="${hrmDto.empNo}">${hrmDto.empNo}</a></td>
                        <td><a href="#" data-bs-toggle="modal" class="openModal" data-show="view"
                               data-bs-target="#staticBackdropView"
                               data-empno="${hrmDto.empNo}">${hrmDto.ename}</a></td>
                        <td>${hrmDto.deptName}</td>
                        <td>${hrmDto.position}</td>
                        <td>${hrmDto.email}</td>
                        <td>${hrmDto.account}</td>
                        <td><input type="text" value="일단빈칸"></td>
                        <td><a href="#" data-bs-toggle="modal" class="openModal"
                               data-bs-target="#staticBackdropView"
                               data-empno="${hrmDto.empNo}" data-show="update">정보변경</a></td>
                    </tr>
                </c:forEach>
            </form>
            </tbody>
        </table>
            <%--      hrm list table 영역 끝      --%>

                        <%--      hrm page 영역      --%>
        <div class="d-flex justify-content-between align-items-center ">
            <c:choose>
                <c:when test="${empty search}">
                    <c:set var="firstPage" value="../hrm/board?page=1"></c:set>
                    <c:set var="prePage" value="../hrm/board?page=${previousPage}"></c:set>
                    <c:set var="selectPage" value="../hrm/board?page="></c:set>
                    <c:set var="nextPage" value="../hrm/board?page=${nextPage}"></c:set>
                    <c:set var="lastPage" value="../hrm/board?page=${totalPage}"></c:set>
                </c:when>
                <c:otherwise>
                    <c:set var="firstPage"
                           value="../hrm/board?search=${search}&searchWord=${searchWord}&page=1"></c:set>
                    <c:set var="prePage"
                           value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${previousPage}"></c:set>
                    <c:set var="selectPage"
                           value="../hrm/board?search=${search}&searchWord=${searchWord}&page="></c:set>
                    <c:set var="nextPage"
                           value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${nextPage}"></c:set>
                    <c:set var="lastPage"
                           value="../hrm/board?search=${search}&searchWord=${searchWord}&page=${totalPage}"></c:set>
                </c:otherwise>
            </c:choose>
            <nav aria-label="Page navigation example" class="">
                <ul class="pagination d-flex justify-content-center " style="margin-bottom: 0">
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
            <div class="text-end">
                <a href="#" data-bs-toggle="modal" class="openModal btn btn-danger"
                   data-bs-target="#staticBackdropView" onclick="return chk_form()"
                   data-show="delete">삭제</a>
                <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
                        data-bs-target="#staticBackdrop">신규
                </button>
            </div>
        </div>
            <%--      hrm page 영역 끝      --%>
    </div>
<%--    hrm 내용영역 끝    --%>
    <%-- Modal 영역 !!! --%>
    <jsp:include page="include/insert-modal.jsp" flush="true"/>
    <div class="modal fade" id="staticBackdropView" data-bs-backdrop="static" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <%--        <c:choose>--%>
        <%--        <c:when test="조건문 들어가서 view update delete 중에 하나만 include 해야함">--%>
        <jsp:include page="include/view-modal.jsp" flush="true"/>
        <jsp:include page="include/update-modal.jsp" flush="true"/>
        <jsp:include page="include/delete-modal.jsp" flush="true"/>
    </div>

</div>
<script>
    function chk_form() {
        document.getElementById('delete').submit();
    }

    // 모달을 열기 위한 스크립트
    $(document).ready(function () {
        $('.openModal').on('click', function (event) {
            event.preventDefault();
            var empNo = $(this).data('empno');
            var show = $(this).data('show');
            // var url = '../hrm/view?empNo=' + empNo;
            if (empNo == null) {
                var url = '../hrm/' + show;
            } else {
                var url = '../hrm/' + show + '?empNo=' + empNo;
            }
            console.log(url)


            // Ajax로 페이지 내용을 가져와 모달(modal-body 부분???)에 로드
            $.get(url, function (data) {
                $('#staticBackdropView .modal-body').html(data);
                var myModal = new bootstrap.Modal(document.getElementById('staticBackdropView'));
                myModal.show();
            });
        });
        $('#staticBackdropView').on('hidden.bs.modal', function () {
            location.reload();
        });
    });


    $("#check-all").on("change", function () {
// is(":checked") - 제이쿼리에서 체크박스 감지할때 씀
        if ($(this).is(":checked")) {
            $(".chk").prop("checked", true);
// while문 안의 checkbox들 class명으로 접근
        } else {
            $(".chk").prop("checked", false);
        }
    })

    $("#profile").on("change", function (e) {
        const file = e.currentTarget.files[0];
        if (!file) { // 파일이 선택되지 않은 경우 (지운 경우)
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