<!-- 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후원</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<!-- Place favicon.ico in the root directory -->

<!-- CSS here -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/owl.carousel.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/magnific-popup.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/themify-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/nice-select.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/flaticon.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/gijgo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/animate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/slicknav.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

<script>
function loginCkN(loginMember){
	console.log(loginMember);
	if(loginMember==null || loginMember==''){
		alert('로그인 후 이용 가능합니다.');
	} else {
		window.location.href='<c:url value="/member/addDonation"/>';
	}
}
function loginCkP(loginMember){
	console.log(loginMember);
	if(loginMember==null || loginMember==''){
		alert('로그인 후 이용 가능합니다.');
	} else {
		window.location.href='<c:url value="/member/addPeriodicallyDonation"/>';
	}
}
function loginCkI(loginMember){
	console.log(loginMember);
	if(loginMember==null || loginMember==''){
		alert('로그인 후 이용 가능합니다.');
	} else {
		window.location.href='<c:url value="/member/addDonationItem"/>';
	}
}
</script>
</head>
<body>
	<header>
		<div class="header-area">		
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<jsp:include page="/WEB-INF/view/main/inc/myMenu.jsp"></jsp:include>			
			<!-- 흰색 바탕 : 메인 메뉴 -->
			<jsp:include page="/WEB-INF/view/main/inc/MainMenu.jsp"></jsp:include>
					
		</div>
	</header>
	
	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h3>후원</h3>
				</div>
			</div>
		</div>
	</div>
	
	
	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->
	<div class="service_area">
		<div class="container">
			<div class="row justify-content-center">
				
				<div class="col-lg-4 col-md-6">
					<div class="single_service volunteer_option">
						<div class="service_thumb service_icon_bg_1 d-flex align-items-center justify-content-center">
							<div class="service_icon">
								<a class="d-inline-block">
									<img src="${pageContext.request.contextPath}/static/img/service/service_icon_2.png" alt="">
								</a>
							</div>
						</div>
						<div class="service_content text-center">
							<h3>
								<a class="d-inline-block">일반후원</a>
							</h3>
							<h4>
								<a class="d-inline-block" data-parameter1="${loginMember.memberId}"
								onclick="loginCkN(this.getAttribute('data-parameter1'))">후원하러 가기 <i class="fa fa-arrow-right"></i></a>
							</h4>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6">
					<div class="single_service volunteer_option">
						<div
							class="service_thumb service_icon_bg_1 d-flex align-items-center justify-content-center">
							<div class="service_icon">
								<a class="d-inline-block">
									<img src="${pageContext.request.contextPath}/static/img/service/service_icon_3.png" alt="">
								</a>
							</div>
						</div>
						<div class="service_content text-center">
							<h3>
								<a class="d-inline-block">정기후원</a>
							</h3>
							<h4>
								<a class="d-inline-block" data-parameter1="${loginMember.memberId}"
								onclick="loginCkP(this.getAttribute('data-parameter1'))">후원하러 가기 <i class="fa fa-arrow-right"></i></a>
							</h4>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6">
					<div class="single_service volunteer_option">
						<div
							class="service_thumb service_icon_bg_1 d-flex align-items-center justify-content-center">
							<div class="service_icon">
								<a class="d-inline-block">
									<img src="${pageContext.request.contextPath}/static/img/service/service_icon_1.png" alt="">
								</a>
							</div>
						</div>
						<div class="service_content text-center">
							<h3>
								<a class="d-inline-block">물품후원</a>
							</h3>
							<h4>
								<a class="d-inline-block" data-parameter1="${loginMember.memberId}"
								onclick="loginCkI(this.getAttribute('data-parameter1'))">후원하러 가기 <i class="fa fa-arrow-right"></i></a>
							</h4>
						</div>
					</div>
				</div>
				
				
				
			</div>
		</div>
	</div>
	<!--================Blog Area =================-->
	

<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->


	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/isotope.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/ajax-form.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.counterup.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/imagesloaded.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/scrollIt.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.scrollUp.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/wow.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/nice-select.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.slicknav.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.magnific-popup.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/plugins.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/gijgo.min.js"></script>
	
	<!--contact js-->
	<script src="${pageContext.request.contextPath}/static/js/contact.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.ajaxchimp.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/mail-script.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/main.js"></script>

<script>
	$('#datepicker').datepicker({
		iconsLibrary: 'fontawesome',
		disableDaysOfWeek: [0, 0],
		//icons: {
		//rightIcon: '<span class="fa fa-caret-down"></span>'
		//}
	});
	
	$('#datepicker2').datepicker({
		iconsLibrary: 'fontawesome',
		icons: {
			rightIcon: '<span class="fa fa-caret-down"></span>'
		}
	});
	
	var timepicker = $('#timepicker').timepicker({
		format: 'HH.MM'
	});
</script>
</body>
</html>