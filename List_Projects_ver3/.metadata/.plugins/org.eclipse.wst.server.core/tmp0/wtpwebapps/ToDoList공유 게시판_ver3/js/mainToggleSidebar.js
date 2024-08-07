$(document).ready(function() {
    function toggleSidebar() {
        if ($(window).width() > 768) {
            $('.sidebar').addClass('show');
            $('.jumbotron').css('margin-left', '250px'); // 사이드바 너비만큼 마진 추가
        } else {
            $('.sidebar').removeClass('show');
            $('.jumbotron').css('margin-left', '0'); // 마진 제거
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
            $('.jumbotron').css('margin-left', '250px');
        } else {
            $('.jumbotron').css('margin-left', '0');
        }
    });
});


	