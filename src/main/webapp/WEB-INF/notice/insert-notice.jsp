<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="../include/header.jsp"%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
        <h2 class="title">새로운 공지 등록</h2>
    </div>
    <div class="notice-content-area p-3 bg-body-tertiary">
        <%--새로운 공지 입력 폼--%>
            <form action="../notice/insert" id="noticeInsert" method="post">
                <div class="mb-3">
                    <label for="title" class="form-label">제목</label>
                    <input type="text" class="form-control" id="title" name="title">

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

            <button type="submit" form="noticeInsert" id="noticeInsertBtn" class="btn btn-primary justify-content-end">등록</button>
            <a href="/notice/board" class="btn btn-danger">취소</a>
    </div>

</div>

<script>
    document.getElementById('noticeInsertBtn').addEventListener('click', function(event) {
        // 폼 서브밋 전에 입력 값 유효성 검사
        var title = document.getElementById('title').value.trim();
        var author = document.getElementById('author').value.trim();
        var content = document.getElementById('content').value.trim();

        if (title === '' || author === '' || content === '') {
            alert('제목, 작성자, 내용은 필수 입력 항목입니다.');
            event.preventDefault(); // 서브밋 막기
        }
    });
</script>
