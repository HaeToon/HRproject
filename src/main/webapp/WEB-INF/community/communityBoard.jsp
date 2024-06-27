<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>

<style>
    a {
        color: inherit; /* 부모 요소의 색상을 상속 */
    }

</style>

<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">커뮤니티</h2>
    </div>
    <div class="community-content-area p-3 bg-body-tertiary">
        <form action="../community/board" class="row d-flex align-items-center justify-content-start m-0">
            <div class="attend-search-area col-sm-5">
                <div class="row">
                    <div class="col">
                        <select class="form-select" aria-label="Default select example" name="search">
                            <option value="all" ${search eq "all" ? "selected": ""}>전체</option>
                            <option value="communityNo" ${search eq "communityNo" ? "selected": ""}>글번호</option>
                            <option value="title" ${search eq "title" ? "selected": ""}>제목</option>
                            <option value="category" ${search eq "category" ? "selected": ""}>카테고리</option>
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
                <th scope="col">카테고리</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
                <th scope="col">삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${communityList}" var="communityDto" varStatus="loop">
                <tr>
                    <td>${communityDto.communityNo}</td>  <%-- 글번호 --%>
                    <td>${communityDto.category}</td>  <%-- 카테고리 --%>
                    <td><a href="/community/incrementViews?communityNo=${communityDto.communityNo}">${communityDto.title}</a></td> <%-- 제목 --%>
                    <td>${communityDto.author}</td> <%-- 작성자 --%>
                    <td>${communityDto.createdDate}</td> <%-- 작성일 --%>
                    <td>${communityDto.views}</td> <%-- 조회수 --%>
                    <td>
                        <button type="button" class="community-delete-button btn btn-danger" data-id="${communityDto.communityNo}">삭제</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <a href="/community/insert" class="btn btn-primary w-80">글 작성하기</a>
    </div>

</div>

<script>
    // 삭제 버튼 클릭 이벤트
    $(document).on("click", ".community-delete-button", function () {
        const communityNo = $(this).data("id");
        const row = $(this).closest("tr");

        if (confirm("정말로 삭제하시겠습니까?")) {
            $.ajax({
                url: "/community/delete",
                method: "POST",
                data: { communityNo: communityNo },
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
