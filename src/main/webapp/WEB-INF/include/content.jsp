<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-relative col-12">
    <div class="main d-flex">
    <div class="main-img-box">
        <img src="../../images/mainImage.jpg" class="main-img">
    </div>
    <div class="main-img-info">
        <h2>한화오션 폴란드 잠수함 수주 현지 협력 확대</h2>
        <h3>대한민국 대표 잠수함 명가 한화오션, 폴란드에서 Industry Day 개최</h3>
        <h3>한화오션(대표이사 권혁웅 부회장)은 <br> 지난5월21일 폴란드 해양 산업의 <br> 핵심 도시 그단스크에서 <br>  인더스트리 데이(Industry Day) 를 <br> 주최하고 폴란드 오르카(Orka) 잠수함 사업 협력 방안을 <br>현지 업체들과 토의했다.</h3>
    </div>
    </div>
    <div class="community-img-card">
        <span>이미지카드</span>
    </div>
    <div class="notice-img-card">
        <span>공지사항 글 이미지 카드</span>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-element-bundle.min.js">
    const bannerSwiper = new Swiper(".banner .mask", {
        slidesPerView: 3,
        spaceBetween: 30,
        navigation: {
            prevEl: ".btn-prev",
            nextEl: ".btn-next",
        },
        pagination: {
            el: ".pagination",
            clickable: true,
        },
    });
</script>
</body>
</html>