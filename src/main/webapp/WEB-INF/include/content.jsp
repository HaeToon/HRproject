<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="content-area d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary position-relative col-12">
    <div class="main d-flex">
    <div class="main-img-box">
        <img src="../../images/mainImage02.jpg" class="main-img">
    </div>
        <div class="main-img-info">
            <h2><한화오션 폴란드 잠수함 수주 현지 협력 확대></h2>
            <div class="summary">
                <h4>「폴란드 안보포럼에 참가, 잠수함 운용 개념 및 교육 훈련 분야 등 발전 방안 제시」</h4>
                <h4>「한국의 잠수함 발전 경험 등 공유…양국간 경제∙산업 및 해군 발전에 기여할 것」</h4>
                <p class="intro">
                    당사 한화오션은 폴란드에서의 잠수함 사업 협력을 확대하기 위해 Industry Day를 개최했습니다.
                </p>
                <a href="#" class="read-more">∙∙∙</a>
                <div class="full-text">
                    <p>
                        이 행사는 폴란드의 주요 해양 산업 도시 그단스크에서 지난 5월 21일에 열렸으며, 폴란드 오르카(Orka) 잠수함 프로젝트에 관련된 현지 업체들과의 협력 방안을 탐구했습니다. 폴란드 안보포럼에 참가하여 잠수함 운용 개념 및 교육 훈련 분야 등 발전 방안을 제시했습니다. 한국의 잠수함 발전 경험을 공유하여 양국 간 경제, 산업 및 해군 발전에 기여할 것임을 강조했습니다.
                    </p>
                </div>
            </div>
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var readMoreBtn = document.querySelector('.read-more');
        var fullText = document.querySelector('.full-text');
        var expandBtn = document.createElement('a');
        expandBtn.textContent = '접기';
        expandBtn.classList.add('expand');
        fullText.appendChild(expandBtn);

        readMoreBtn.addEventListener('click', function(event) {
            event.preventDefault();
            fullText.style.display = 'block';
            readMoreBtn.style.display = 'none';
        });

        expandBtn.addEventListener('click', function(event) {
            event.preventDefault();
            fullText.style.display = 'none';
            readMoreBtn.style.display = 'block';
        });
    });

</script>
</body>
</html>