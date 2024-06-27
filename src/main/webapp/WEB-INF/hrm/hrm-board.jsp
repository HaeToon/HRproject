<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<c:choose>
    <c:when test="${loginDto.grade eq 'ADMIN' or loginDto.deptNo eq 30}">
        <%--   내용 영역  --%>
        <div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
                <%--  hrm 제목 영역  --%>
            <div class="board-title">
                <h2 class="title">사원 목록</h2>
            </div>
                <%--  hrm 내용 영역  --%>
            <div class="hrm-content-area p-3 ">
                    <%--    hrm 검색 영역    --%>
                <div class="hrm-search-area">
                    <form action="../hrm/board" class="row d-flex align-items-center">
                        <div class="col-sm-3">
                            <div class="row g-3">
                                <div class="col">
                                    <select class="form-select" aria-label="Default select example" name="search">
                                        <option value="all" ${search eq "all" ? "selected": ""}>전체</option>
                                        <option value="empno" ${search eq "empno" ? "selected": ""}>사원번호</option>
                                        <option value="ename" ${search eq "ename" ? "selected": ""}>사원명</option>
                                        <option value="deptname" ${search eq "deptname" ? "selected": ""}>부서명</option>
                                        <option value="email" ${search eq "email" ? "selected": ""}>이메일</option>
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
                <table class="table table-light table-sm">
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
                        <th scope="col">조회 / 수정 / 삭제</th>
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
                            <td>
                                    <%--                    <div class="form-check form-check-inline">--%>
                                    <%--                        <input class="chk form-check-input" type="checkbox" name="check" value="${hrmDto.empNo}">--%>
                                    <%--                        <label class="chk form-check-label">${((page -1) * listPerPage) + loop.count}</label>--%>
                                    <%--                    </div>--%>
                                <input type="checkbox" class="chk btn-check" id="btn-check-${loop.index}"
                                       autocomplete="off"
                                       value="${hrmDto.empNo}" name="check"
                                       style="width: 20px; height: 20px">
                                <label class="btn"
                                       for="btn-check-${loop.index}">${((page -1) * listPerPage) + loop.count}</label>
                            </td>
                            <td>${hrmDto.hireDate}</td>
                            <td>${hrmDto.empNo}</td>
                            <td>${hrmDto.ename}</td>
                            <td>${hrmDto.deptName}</td>
                            <td>${hrmDto.posName}</td>
                            <td>${hrmDto.email}</td>
                            <td>${hrmDto.account}</td>
                            <td><input type="text" value="일단빈칸"></td>
                            <td>
                                <button type="button" class="btn btn-primary view-button" data-empno="${hrmDto.empNo}"
                                        data-bs-toggle="modal" data-bs-target="#viewModal">상세
                                </button>
                                    <button type="button" class="btn btn-primary modify-button"
                                            data-bs-target="#modifyModal"
                                            data-empno="${hrmDto.empNo}"
                                            data-bs-toggle="modal" data-bs-target="#modifyModal">수정
                                    </button>
                                    <button type="button" class="btn btn-danger delete-button"
                                            data-empno="${hrmDto.empNo}"
                                            data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제
                                    </button>
                            </td>
                        </tr>
                    </c:forEach>
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
                                        <li class="page-item"><a class="page-link" href="${selectPage}${i}">${i}</a>
                                        </li>
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
                            <%--                <a href="#" data-bs-toggle="modal" class="openModal btn btn-danger"--%>
                            <%--                   data-bs-target="#staticBackdropView" onclick="return chk_form()"--%>
                            <%--                   data-show="delete">삭제</a>--%>
                            <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
                                    data-bs-target="#insertModal">신규
                            </button>
                            <form action="../hrm/insert" class="row d-flex align-items-center">
                                <input type="hidden" value="addEmployee" name="addEmployee">
                                <button class="btn btn-primary mt-2">사원 30명+</button>
                            </form>
                    </div>
                </div>
                    <%--      hrm page 영역 끝      --%>
            </div>
                <%--    hrm 내용영역 끝    --%>
                <%-- Modal 영역 !!! --%>
            <jsp:include page="include/view-modal.jsp" flush="true"/>
                <jsp:include page="include/insert-modal.jsp" flush="true"/>
                <jsp:include page="include/update-modal.jsp" flush="true"/>
                <jsp:include page="include/delete-modal.jsp" flush="true"/>
        </div>
    </c:when>
    <c:otherwise>
        <c:set var="redirectUrl" value="${pageContext.request.contextPath}/index/index"/>
        <c:if test="${not fn:contains(pageContext.request.requestURI, '/index/index')}">
            <meta http-equiv="refresh" content="0; url=${redirectUrl}">
        </c:if>
    </c:otherwise>
</c:choose>
<script>
    // 상세 보기 버튼 클릭 이벤트 핸들러
    $('.view-button').click(function () {
        var empNo = $(this).attr('data-empno');
        $.ajax({
            url: '../hrm/view',  // 데이터를 가져올 서블릿 URL
            type: 'POST',
            data: {empNo: empNo},
            success: function (response) {
                // 서버에서 받은 데이터로 폼을 채움
                $('input#empNo_view').val(response.empNo);
                $('input#ename_view').val(response.ename);
                $('input#birthDate_view').val(response.birthDate);
                $('input#hireDate_view').val(response.hireDate);
                $('input#hireType_view').val(response.hireType);
                $('input#deptName_view').val(response.deptNo + "  |  " + response.deptName);
                $('input#email_view').val(response.email);
                $('input#address_view').val(response.postCode + "  " + response.address +"  "+ response.addressDetail);
                $('input#mobile_view').val(response.mobile);
                $('input#position_view').val(response.posNo + "  |  " + response.posName);
                $('input#bankAccount_view').val(response.bankName + "    " + response.account + "    " + response.accountHolder);
                $('input#passport_view').val(response.passport);
                $('input#roleName_view').val(response.roleName);
                $('textarea#remarks_view').val(response.remarks);

                if (response.renameProfile && response.renameProfile.trim() !== "") {
                    $('#renameProfile_view').attr('src', '../upload/' + response.renameProfile);
                } else {
                    $('#renameProfile_view').attr('src', '../images/profile01.jpg');
                }

                // 수정 모달을 보여줌
                $('#viewModal').modal('show');
            },
            error: function () {
                alert('사원 정보를 가져오는 데 실패했습니다.');
            }
        });
    });

    $('.modify-button').click(function () {
        var empNo = $(this).attr('data-empno');

        $.ajax({
            url: '../hrm/update',  // 데이터를 가져올 서블릿 URL
            type: 'GET',
            data: {empNo: empNo},
            success: function (response) {
                // 서버에서 받은 데이터로 폼을 채움
                $('input#empNo_update').val(response.empNo);
                $('input#empNo_password_update').val(response.empNo);
                $('input#ename_update').val(response.ename);
                $('input#birthDate_update').val(response.birthDate);
                $('input#foreignName_update').val(response.foreignName);
                $("select#posNo_update").val(response.posNo);
                $("select#deptNo_update").val(response.deptNo);
                $('select#roleName_update').val(response.roleName);
                $('input#mobile_update').val(response.mobile);
                $('input#passport_update').val(response.passport);
                $('input#email_update').val(response.email);
                $('input#hireDate_update').val(response.hireDate);
                $('select#hireType_update').val(response.hireType);
                $('input#postCode_update').val(response.postCode);
                $('input#address_update').val(response.address);
                $('input#addressDetail_update').val(response.addressDetail);
                $('select#bankName_update').val(response.bankName);
                $('input#account_update').val(response.account);
                $('input#accountHolder_update').val(response.accountHolder);
                // $('input#profile_update').val(response.renameProfile);
                $('textarea#remarks_update').val(response.remarks);

                // 나머지 필드들도 동일한 방식으로 처리
                // 예: $('input#hireDate_view').val(response.hireDate);

                // 수정 모달을 보여줌
                $('#modifyModal').modal('show');
            },
            error: function () {
                alert('사원 정보를 가져오는 데 실패했습니다.');
            }
        });
    });

    let empNo;
    document.querySelectorAll('.delete-button').forEach(button => {
        button.addEventListener('click', function () {
            empNo = this.getAttribute('data-empno');
        });
    });

    function confirmDelete() {
        const password = document.getElementById('deletePasswordInput').value;
        if (password === '1234') {
            window.location.href = '../hrm/delete?empNo=' + empNo;
        } else {
            alert('비밀번호가 틀렸습니다.');
            return false;
        }
    }


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
            // $("#preview").html(""); // 미리보기 영역 비우기
            $("#preview").attr("src", "../../images/profile01.jpg");
            return false;
        }
        const extension = file.name.substring(file.name.lastIndexOf(".") + 1).toLowerCase(); // +1 안하면 .png, +1 하면 png 나옴
        if (!(extension === "png" || extension === "jpg" || extension === "gif")) {
            alert("이미지 파일(jpg, png. gif)만 업로드 가능합니다.");
            $(this).val("");
            $("#preview").attr("src", "../../images/profile01.jpg");
            return false;
        } else {
            const profileReader = new FileReader();
            profileReader.onload = function (e) {
                // currentTarget or target에의 result 가 image임
                const img = e.target.result;
                /* jsp의 자바스크립트에서 달러{} 을 쓰려면 $앞에 \를 넣어줘야함 = \$ {} */
                // $("#preview").html(`<img src="\${img}">`)
                $("#preview").attr("src", img); // 선택한 이미지로 미리보기 업데이트
            }
            profileReader.readAsDataURL(file);
        }
    })

    $("#profile_update").on("change", function (e) {
        const file = e.currentTarget.files[0];
        if (!file) { // 파일이 선택되지 않은 경우 (지운 경우)
            // $("#preview").html(""); // 미리보기 영역 비우기
            $("#update_preview").attr("src", "../../images/profile01.jpg");
            return false;
        }
        const extension = file.name.substring(file.name.lastIndexOf(".") + 1).toLowerCase(); // +1 안하면 .png, +1 하면 png 나옴
        if (!(extension === "png" || extension === "jpg" || extension === "gif")) {
            alert("이미지 파일(jpg, png. gif)만 업로드 가능합니다.");
            $(this).val("");
            $("#update_preview").attr("src", "../../images/profile01.jpg");
            return false;
        } else {
            const profileReader = new FileReader();
            profileReader.onload = function (e) {
                // currentTarget or target에의 result 가 image임
                const img = e.target.result;
                /* jsp의 자바스크립트에서 달러{} 을 쓰려면 $앞에 \를 넣어줘야함 = \$ {} */
                // $("#preview").html(`<img src="\${img}">`)
                $("#update_preview").attr("src", img); // 선택한 이미지로 미리보기 업데이트
            }
            profileReader.readAsDataURL(file);
        }
    })

    /* postcode 버튼 눌러서 주소 팝업창 불러옴 */
    $(".btn-post").on("click", makePostCode);

    function makePostCode() {
        $("#postCode").each(function () {
            if ($(this).val() !== '') {
                $(this).removeClass('is-invalid');
            }
        });

        $("#address").each(function () {
            if ($(this).val() !== '') {
                $(this).removeClass('is-invalid');
            }
        });
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
                    $(".extra-address").val(extraAddr);

                } else {
                    $(".extra-address").val("");
                }

// 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".postCode").val(data.zonecode);
                $(".address").val(addr);

                // Remove 'is-invalid' class if values are present
                if ($("#postCode").val() !== '') {
                    $("#postCode").removeClass('is-invalid');
                }
                if ($("#address").val() !== '') {
                    $("#address").removeClass('is-invalid');
                }

// 커서를 상세주소 필드로 이동한다.
                $(".detail-address").focus();
            }
        }).open()({});
    }
</script>