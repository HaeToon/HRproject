<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp" %>
<%@ page import="java.util.Date, java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--   내용 영역  --%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <%--  hrm 제목 영역  --%>
    <div class="board-title">
        <h2 class="title">인사평가</h2>
    </div>
    <%--  hrm 내용 영역  --%>
    <div class="hrm-content-area p-3">
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
                <th scope="col">사원번호</th>
                <th scope="col">부서</th>
                <th scope="col">직책</th>
                <th scope="col">사원명</th>
                <th scope="col">입사일</th>
                <th scope="col">근속연수</th>
                <th scope="col">등급(출석률)</th>
                <th scope="col">승진대상</th>
                <th scope="col">승인 / 반려</th>
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
                        <input type="checkbox" class="chk btn-check" id="btn-check-${loop.index}"
                               autocomplete="off"
                               value="${hrmDto.empNo}" name="check"
                               style="width: 20px; height: 20px">
                        <label class="btn"
                               for="btn-check-${loop.index}">${((page -1) * listPerPage) + loop.count}</label>
                    </td>
                    <td>${hrmDto.empNo}</td>
                    <td>${hrmDto.deptName}</td>
                    <td>${hrmDto.posName}</td>
                    <td>${hrmDto.ename}</td>
                    <td>${hrmDto.hireDate}</td>
                        <%--                            hrmBoard 서블릿에 setRequestAttributes(....,... hrmList 를 참조함 --%>
                        <%--Evaluations 서블릿에 req.getRequestDispatcher("/WEB-INF/hrm/evaluation-board.jsp").forward(req, resp);--%>
                    <td>
                            ${hrmDto.yosYear}년${hrmDto.yosMonth}개월
                    </td>

                    <td>${hrmDto.attendanceRate}%</td>
                    <td>
<%--                        <c:choose>--%>
<%--                        <c:when test="${hrmDto.isPromotable eq true}">O</c:when>--%>
<%--                        <c:otherwise>X</c:otherwise>--%>
<%--                        </c:choose>--%>
        ${hrmDto.isPromo}
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${hrmDto.isPromo eq 'O'}"><button class="btn btn-primary">승인</button></c:when>
                            <c:otherwise><button class="btn btn-dark" disabled>반려</button></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="text-end">
            <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
                    data-bs-target="#insertModal">신규
            </button>
        </div>
    </div>
    <%--      hrm page 영역      --%>
    <div class="hrm-ev-area d-flex justify-content-between align-items-center ">
        <c:choose>
            <c:when test="${empty search}">
                <c:set var="firstPage" value="../hrm/evaluation?page=1"></c:set>
                <c:set var="prePage" value="../hrm/evaluation?page=${previousPage}"></c:set>
                <c:set var="selectPage" value="../hrm/evaluation?page="></c:set>
                <c:set var="nextPage" value="../hrm/evaluation?page=${nextPage}"></c:set>
                <c:set var="lastPage" value="../hrm/evaluation?page=${totalPage}"></c:set>
            </c:when>
            <c:otherwise>
                <c:set var="firstPage"
                       value="../hrm/evaluation?search=${search}&searchWord=${searchWord}&page=1"></c:set>
                <c:set var="prePage"
                       value="../hrm/evaluation?search=${search}&searchWord=${searchWord}&page=${previousPage}"></c:set>
                <c:set var="selectPage"
                       value="../hrm/evaluation?search=${search}&searchWord=${searchWord}&page="></c:set>
                <c:set var="nextPage"
                       value="../hrm/evaluation?search=${search}&searchWord=${searchWord}&page=${nextPage}"></c:set>
                <c:set var="lastPage"
                       value="../hrm/evaluation?search=${search}&searchWord=${searchWord}&page=${totalPage}"></c:set>
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
        <%--<div class="text-end">
            &lt;%&ndash;                <a href="#" data-bs-toggle="modal" class="openModal btn btn-danger"&ndash;%&gt;
            &lt;%&ndash;                   data-bs-target="#staticBackdropView" onclick="return chk_form()"&ndash;%&gt;
            &lt;%&ndash;                   data-show="delete">삭제</a>&ndash;%&gt;
            <button type="button" class="btn btn-primary" style="width: 100px" data-bs-toggle="modal"
                    data-bs-target="#insertModal">신규
            </button>
            <form action="../hrm/insert" class="row d-flex align-items-center">
                <input type="hidden" value="addEmployee" name="addEmployee">
                <button class="btn btn-primary mt-2">사원 30명+</button>
            </form>
        </div>--%>
    </div>
    <%--      hrm page 영역 끝      --%>
</div>
</div>