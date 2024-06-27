<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../include/header.jsp"%>
<div class="content-area d-flex flex-column flex-shrink-0 position-relative col-12">
    <div class="board-title">
<h2 class="title">공지사항 상세 내용</h2>
</div>
    <div class="notice-content-area p-3 bg-body-tertiary">
        <h3>${notice.title}</h3>
        <p><strong>작성자:</strong> ${notice.author}</p>
        <p><strong>작성일:</strong> ${notice.createdDate}</p>
        <p><strong>조회수:</strong> ${notice.views}</p>
        <hr>
        <p>${notice.content}</p>
        <hr>

        <div class="d-grid gap-2 d-md-block">
            <button id="updateBtn" class="btn btn-secondary" type="button">수정</button>
            <a href="/notice/board"><button class="btn btn-primary" type="button">목록</button></a>
        </div>
    </div>
</div>

<script>
    // JSP 변수를 JavaScript 변수에 할당
    var noticeNo = '${notice.noticeNo}';

    // 수정 버튼 클릭 시 이벤트 처리
    document.addEventListener('DOMContentLoaded', function() {
        var updateBtn = document.getElementById('updateBtn');
        if (updateBtn) {
            updateBtn.addEventListener('click', function() {
                window.location.href = '/notice/update?noticeNo=' + noticeNo;
            });
        }
    });
</script>
