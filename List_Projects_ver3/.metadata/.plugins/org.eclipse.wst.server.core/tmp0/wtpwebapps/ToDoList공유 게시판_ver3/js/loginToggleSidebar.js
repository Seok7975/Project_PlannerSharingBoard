$(document).ready(function() {
    function toggleSidebar() {
        if ($(window).width() > 768) {
            $('.sidebar').addClass('show');
            $('.main-content').removeClass('expanded');
        } else {
            $('.sidebar').removeClass('show');
            $('.main-content').addClass('expanded');
        }
    }

    // 초기 로드 시 사이드바 상태 설정
    toggleSidebar();

    // 창 크기가 변경될 때마다 사이드바 상태 업데이트
    $(window).resize(function() {
        toggleSidebar();
    });

    // 사이드바 토글 버튼 (필요한 경우)
    $('.navbar-toggle').click(function() {
        $('.sidebar').toggleClass('show');
        if ($('.sidebar').hasClass('show')) {
            $('.main-content').removeClass('expanded');
        } else {
            $('.main-content').addClass('expanded');
        }
    });
});