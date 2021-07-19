<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원봉사내역</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
				<div class="col-lg-12">
					<h3>후원내역</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>	
				
				<div class="col-lg-9 mb-5 mb-lg-0"  >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 80%;">
						<div class="service_content text-center">
							<h3>총 후원내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>보호소</th>
										<th>후원금</th>
										<th>후원날짜</th>
										<th>종류</th>
									</tr>
								</thead>
								<tbody id="fullTarget">
								</tbody>							
							</table>
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="fullPaging">
										
										
									</ul>
								</nav>
							</div>
							
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 mb-5 mb-lg-0">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account">
						<div class="service_content text-center">
							<h3>정기후원</h3>
							<table class="table">
								<thead>
									<tr>
										<th>보호소</th>
										<th>후원금</th>
										<th>신청날짜</th>
										<th>취소날짜</th>
									</tr>
								</thead>
								<tbody id="pTarget">
								
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
			</div>
		</div>
	</section>
	
	
	
	
	<script>
		let fullCurrentPage = 1;
		let pCurrentPage = 1;
		
		
		//실패한 코드 --> 나중에 다시 도전...
		/*
		$('.removePDonationBtn').click(function(){
			//periodicallyDonationId 구하기
			let index = $('.removePDonationBtn').index(this);
			console.log(index);
			
			let periodicallyDonationId = $('.periodicallyDonationId').val()
			console.log(periodicallyDonationId);
		});
		*/
		
		/*
			<c:forEach var="f" items="${fList}">
									<input type="hidden" class="periodicallyDonationId" value="${p.periodicallyDonationId}">
									<tr>
										<td>${f.shelterName}</td>
										<td>${f.amount}</td>
										<td>${f.donationDate}</td>
										<td>${f.kinde}</td>		
									</tr>
								</c:forEach>
		*/
		//총 후원내역
		function fullDonationList(page){
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getFullDonation',
				data: {'currentPage': page},
				success: function(jsonData){

					prePage = page-1;
					nextPage = page+1;
					
					$.each(jsonData.list, function(index, data) {
						$('#fullTarget').append('<tr>');
						$('#fullTarget').append('<td>'+data.shelterName+'</td>');
						$('#fullTarget').append('<td>'+data.amount+'</td>');
						$('#fullTarget').append('<td>'+data.donationDate+'</td>');
						$('#fullTarget').append('<td>'+data.kinde+'</td>');
						$('#fullTarget').append('</tr>');
				
					});
					
					console.log(page);
					console.log(page-1);
					console.log(page+1);

					
					//페이징
					//이전
					if(prePage > 0){
						$('#fullPaging').append('<li class="page-item"><i class="ti-angle-left"></i></li>');
						$('#fullPaging').append('<li class="page-item">'+prePage+'</li>');
					}
					
					//현재
					$('#fullPaging').append('<li class="page-item active">'+page+'</li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#fullPaging').append('<li class="page-item">'+nextPage+'</li>');
						$('#fullPaging').append('<li class="page-item"><i class="ti-angle-right"></i></li>');
					}
				}
			
			})
		}
		
		//정기후원
		function pDonationList(pPage){
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getPeriodicallyDonationByMemberId',
				data: {'currentPage': pPage},
				success: function(result){
					$.each(result.list, function(index, table) {
						$('#pTarget').append('<tr>');
						$('#pTarget').append('<td>'+table.shelterName+'</td>');
						$('#pTarget').append('<td>'+table.amount+'</td>');
						$('#pTarget').append('<td>'+table.donationDate+'</td>');
						$('#pTarget').append('<td>'+table.kinde+'</td>');
						$('#pTarget').append('</tr>');
						
					});
				}
				
			})
		}
		
		fullDonationList(fullCurrentPage);
		pDonationList(pCurrentPage);
	</script>
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