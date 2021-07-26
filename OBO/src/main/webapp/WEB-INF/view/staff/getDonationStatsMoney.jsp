<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getDonationStatsMoney</title>

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
					<h3>후원 > 통계 > 금액</h3>
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
							
							<p>후원 받은 금액을 기간별로 조회할 수 있습니다.</p>
							<br>
							
							<!-- 검색 -->
							<form id="searchForm" action="${pageContext.request.contextPath}/staff/getDonationMoneyP" method="get">
								<div class="form-group col-xl-8 col-lg-6">
									<div class="input-group mb-4"> 
										<input id="startDate" type="month" name="startDate"> 
										&nbsp;~&nbsp;
										<input id="endDate" type="month" name="endDate"> 
										
										&nbsp;<button id="searchBtn" class="btn" type="button" onclick="searchFun();"><i class="fa fa-search"></i></button>
										&nbsp;<button class="btn" type="reset"><i class="fa fa-refresh"></i></button>
									</div>
								</div>
							</form>
							<br>
							
							<div>
								<span id="input"></span>
							</div>
							<br>
							
							<table id="moneyTable" class="table" style="width:80%; text-align:center;">
							
							</table>
							
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
	
	<script>
	function searchFun(){
		console.log('조회버튼 클릭~');
		
		if($('#startDate').val() == ''){
			alert('시작 년/월을 선택해주세요.');
			return;
		} 
		if($('#endDate').val() == ''){
			alert('종료 년/월을 선택해주세요.');
			return;
		} 
		
		let addTr = "";
		let startDate = $('#startDate').val();
		let endDate = $('#endDate').val();
		let totalByPeriod;	// 후원받은 총 금액
		
		$.ajax({
			url:'${pageContext.request.contextPath}/getDonationMoneyByPeriod',
			type:'get',
			data:{startDate : startDate,
					endDate : endDate},
			success: function(jsonData){
				console.log('기간별 금액조회 ajax!');
				$('#moneyTable').empty();	// 먼저 테이블 비워놓기
				totalByPeriod = 0;	// 재 조회 할 경우
				
				$(jsonData).each(function(index, item){
					addTr += '<tr>';
					addTr += '<td width="40%">';
					addTr += item.yearMonth;
					addTr += '</td>';
					addTr += '<td width="60%">';
					addTr += item.total.toLocaleString();
					addTr += '</td>';
					addTr += '</tr>';
					totalByPeriod += item.total;
				});
				console.log('총 후원액-> '+totalByPeriod);
				$('#moneyTable').append(addTr);
				$('#input').text('['+startDate+' - '+endDate+']  총 후원 받은 금액 '+totalByPeriod.toLocaleString()+'원');
			}
		});
	}
	
	</script>
	
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