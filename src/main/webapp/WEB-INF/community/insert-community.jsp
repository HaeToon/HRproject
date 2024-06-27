<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">새로운 커뮤니티 등록</h2>
    </div>
    <div class="community-content-area p-3 bg-body-tertiary">
        <%--새로운 공지 입력 폼--%>
        <form action="../community/insert" id="communityInsert" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title">

            </div>

            <div class="mb-3">
                <label for="category" class="form-label">카테고리</label>
                <select class="form-control" id="category" name="category">
                    <option selected value="">카테고리를 선택해주세요</option>
                    <option value="자유게시판">자유게시판</option>
                    <option value="질문게시판">질문게시판</option>
                    <option value="자료실">자료실</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="author" class="form-label">작성자</label>
                <input type="text" class="form-control" id="author" name="author">
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="10"></textarea>
            </div>

        </form>

        <button type="submit" form="communityInsert" id="communityInsertBtn" class="btn btn-primary justify-content-end">등록</button>
        <a href="/community/board" class="btn btn-danger">취소</a>
    </div>

</div>

<script>
    document.getElementById('communityInsertBtn').addEventListener('click', function(event) {
        // 폼 서브밋 전에 입력 값 유효성 검사
        var title = document.getElementById('title').value.trim();
        var category = document.getElementById('category').value.trim();
        var author = document.getElementById('author').value.trim();
        var content = document.getElementById('content').value.trim();

        if (title === '' || author === '' || content === '' || category === '') {
            alert('모든 내용을 입력해주세요.');
            event.preventDefault(); // 서브밋 막기
        }
    });
</script>
