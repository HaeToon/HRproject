<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>

<style>
    a {
        color: inherit; /* 부모 요소의 색상을 상속 */
        
    }

</style>

<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">Notice list</h2>
    </div>
    <div class="notice-content-area p-3 bg-body-tertiary">
        <form action="../notice/board" class="row d-flex align-items-center justify-content-start m-0">
            <div class="attend-search-area col-sm-5">
                <div class="row">
                    <div class="col">
                        <select class="form-select" aria-label="Default select example" name="search">
                            <option value="all" ${search eq "all" ? "selected": ""}>전체</option>
                            <option value="noticeNo" ${search eq "noticeNo" ? "selected": ""}>글번호</option>
                            <option value="title" ${search eq "title" ? "selected": ""}>제목</option>
                            <option value="author" ${search eq "author" ? "selected": ""}>작성자</option>
                        </select>
                    </div>
                    <div class="col w-auto">
                        <input type="text" name="searchWord" class="form-control" value="${searchWord}">
                    </div>
                    <div class="col-sm-3">
                        <button class="btn btn-primary w-80">SEARCH</button>
                    </div>
                </div>
            </div>
        </form>

        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">글번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
                <th scope="col">삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${noticeList}" var="noticeDto" varStatus="loop">
                <tr>
                    <td>${noticeDto.noticeNo}</td>  <%-- 글번호 --%>
                    <td><a href="/notice/incrementViews?noticeNo=${noticeDto.noticeNo}">${noticeDto.title}</a></td> <%-- 제목 --%>
                    <td>${noticeDto.author}</td> <%-- 작성자 --%>
                    <td>${noticeDto.createdDate}</td> <%-- 작성일 --%>
                    <td>${noticeDto.views}</td> <%-- 조회수 --%>
                    <td>
                        <button type="button" class="notice-delete-button btn btn-danger" data-id="${noticeDto.noticeNo}">삭제</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <a href="/notice/insert" class="btn btn-primary w-80">글 작성하기</a>
    </div>

</div>

<script>
    // 삭제 버튼 클릭 이벤트
    $(document).on("click", ".notice-delete-button", function () {
        const noticeNo = $(this).data("id");
        const row = $(this).closest("tr");

        if (confirm("정말로 삭제하시겠습니까?")) {
            $.ajax({
                url: "/notice/delete",
                method: "POST",
                data: { noticeNo: noticeNo },
                success: function (response) {
                    if (response.success) {
                        row.remove(); // 성공적으로 삭제되면 해당 행을 제거
                        alert("삭제되었습니다.");
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                },
                error: function () {
                    alert("삭제 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 삽입, 수정 완료 메세지
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('updateSuccess') === 'true') {
            alert('수정 되었습니다.');
        }

        if (urlParams.get('insertSuccess') === 'true') {
            alert('등록 되었습니다.');
        }
    };

</script>
