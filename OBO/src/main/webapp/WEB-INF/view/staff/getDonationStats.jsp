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
	
	// 이번 달 후원받은 금액
	let totalArr = [];
	let thisMonthArr = [];
	let total, thisMonth;
	let myChart = null;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/getDonationMoneyThisMonth',
		type: 'get',
		success: function(jsonData){
			console.log('이번달 후원받은 금액 jsonData 얻어오기');
			
			$(jsonData).each(function(index, item){
				totalArr.push(item.total);
				thisMonthArr.push(item.thisMonth);
			});
			
			// for문 안 돌리고 각 넣어서 chart 생성시 오류 발생
			
			total = jsonData.total;	// typeof(total) -> number
			totals = total.toLocaleString();	// typeof(total) -> String
			//thisMonth = jsonData.thisMonth;
			//console.log('thisMonth-> '+thisMonth);
			
			console.log('total-> '+total);
			
			$('#total').text(totals+'원');	// 화면에 보여줄 값
			
			let data = {
			  labels: thisMonthArr,
			  datasets: [{
					    label: 'this month',
					    data: totalArr,
					    backgroundColor: ['rgba(255, 99, 132, 0.2)'],
					    borderColor: ['rgb(255, 99, 132)'],
					    borderWidth: 1
			  }]
			};
			
			let config = {
					  type: 'bar',
					  data: data,
					  options: {plugins: {legend: {display: false}},	// 라벨 삭제 옵션, 그러나 아직 라벨 보임
					    		scales: {y: {beginAtZero: true}}}
			};
			
			myChart = new Chart(document.getElementById('myChart'), config);
		}
	});
	
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
								<h4>
									이번 달 후원받은 금액 : 
									<span id="total"></span>
								</h4>
								<div>
									<canvas id="myChart" style="width:300px; height:300px;"></canvas>
								</div>
							</div>
						</div>
						
						<div class="col-xl-6 col-lg-6 ml-4">
							<div class="blog_details">
								<h4>최근 후원받은 물품</h4>
								<br>
								<table class="table">
									<tr>
										<th>카테고리</th>
										<th>수량</th>
										<th>날짜</th>
									</tr>
									<c:forEach var="d" items="${donationItemLast}">
										<tr>
											<td>${d.itemCategoryName}</td>
											<td>${d.itemQuantity}</td>
											<td>${d.donationDate}</td>
										</tr>
									</c:forEach>
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
	
	<!-- chart js -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
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