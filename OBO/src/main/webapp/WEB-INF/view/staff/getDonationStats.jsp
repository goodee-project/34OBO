<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getDonationStats</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- CSS here -->
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
$(document).ready(function(){	
	
	
});
</script>
</head>
<body>
	<header>
		<div class="header-area ">
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<jsp:include page="/WEB-INF/view/staff/inc/myMenu.jsp"></jsp:include>

			<!-- 흰색 바탕 : 메인 메뉴 -->
			<jsp:include page="/WEB-INF/view/staff/inc/staffMenu.jsp"></jsp:include>
		</div>
	</header>

	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h3>후원 > 통계</h3>
				</div>
			</div>
		</div>
	</div>
	
	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<jsp:include page="/WEB-INF/view/staff/inc/side/donationMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<h2>
								<a href="${pageContext.request.contextPath}/staff/getDonationStats"><i class="fa fa-home"></i></a> <a>|</a> 
								<a href="${pageContext.request.contextPath}/staff/getDonationStatsItem">물품</a> <a>|</a> 
								<a href="${pageContext.request.contextPath}/staff/getDonationStatsMoney">금액</a>
							</h2>
							
							<p>이번 달 후원받은 금액과 최근 후원받은 내역을 간략하게 확인 할 수 있습니다.</p>
							
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-xl-5 col-lg-5">
							<div class="blog_details">
								<h4>이번 달 후원받은 금액 : @@@@@@@@</h4>
								<h4>이번 달 후원받은 금액 : 바차트</h4>
								<p>아름다운 이 땅에 금수강산에 단군할아버지가 터잡으시고 홍익인간 뜻으로 나라 세우니 대대손손 훌륭한 인물도 많아.
								고구려 세운 동명왕, 백제 온조왕, 알에서 나온 혁거세. 만주벌판 달려라 광개토대왕, 신라장군 이사부.
								백결 선생 떡방아, 삼천궁녀 의자왕. 황산벌의 계백, 맞서싸운 관창. 역사는 흐른다.</p>
							</div>
						</div>
						
						<div class="col-xl-7 col-lg-7">
							<div class="blog_details">
								<h4>이번 달 후원받은 금액 : @@@@@@@@@@@@</h4>
								<h4>이번 달 후원받은 금액 : 테이블</h4>
								<p>아름다운 이 땅에 금수강산에 단군할아버지가 터잡으시고 홍익인간 뜻으로 나라 세우니 대대손손 훌륭한 인물도 많아.
								고구려 세운 동명왕, 백제 온조왕, 알에서 나온 혁거세. 만주벌판 달려라 광개토대왕, 신라장군 이사부.
								백결 선생 떡방아, 삼천궁녀 의자왕. 황산벌의 계백, 맞서싸운 관창. 역사는 흐른다.</p>
								<table class="table">
									<tr>
										<td>카테고리</td>
										<td>수량</td>
										<td>날짜</td>
									</tr>
									<tr>
										<td>test</td>
										<td>test</td>
										<td>test</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<!-- 페이징, 검색 없음 -->
				</div>
			</div>
		</div>
	</section>
	<!--================Blog Area =================-->	
	
	
	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->	
	
	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
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
</body>
</html>