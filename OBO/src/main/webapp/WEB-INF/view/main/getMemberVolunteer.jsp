<!-- 작성자: 남궁혜영 -->
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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
					<h3>봉사내역</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>
				
				
				
				<div class="col-lg-9 mb-5 mb-lg-0">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<p style="text-align: right;">회원님의 총 봉사 시간은 <b id="totalTarget"></b> 입니다.</p>
							<h3>총 봉사내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>봉사시간</th>
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
				
				<!-- 달력 들어갈 것 -->
				<div class="col-lg-3">
						<div class="service_content text-center">
							<h5>봉사 스케줄</h5>
							<table class="table">
								<thead>
									<tr>
										<th>일</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th>토</th>
									</tr>
								</thead>
								<tbody id="">
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="pPaging">
										
										
									</ul>
								</nav>
							</div>
						</div>
				</div>
				
				<div class="col-lg-9 mb-6 mb-lg-0">
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>일반봉사 신청내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>신청취소</th>
									</tr>
								</thead>
								<tbody id="">
								
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="pPaging">
										
										
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 정기봉사 내역 -->
				<div class="col-lg-9 mb-6 mb-lg-0 offset-3">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>정기봉사 진행내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>신청취소</th>
									</tr>
								</thead>
								<tbody id="">
								
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="iPaging">
										
										
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>
	</section>
	
	
	
	<script>

		let fullCurrentPage = 1;//총 후원내역 페이지
		let perCurrentPage = 1;//정기후원 페이지
		let iCurrentPage = 1;//물품후원 페이지
		
		$('#totalTarget').text('0시간');
		
		//총 후원금액
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getTotalVolunteerTime'
		}).done(function (jsonData){
			console.log(jsonData);
			$('#totalTarget').text(jsonData +'시간');

		});
		
		//총 봉사내역
		function fullVolunteer(page){
			$.ajax({
				type:'get',
				url: '${pageContext.request.contextPath}/member/getFullVolunteer',
				data: {'currentPage':page},
				success: function (jsonData){
				console.log(jsonData);
				prePage = page-1;
				nextPage = page+1;
				
				$('#fullTarget').empty();
				$('#fullPaging').empty();
				
				$.each(jsonData.list, function(index, data){
					console.log(data);
					$('#fullTarget').append('<tr>');
					$('#fullTarget').append('<td>'+data.volunteerDate+'</td>');
					$('#fullTarget').append('<td>'+data.shelterName+'</td>');
					$('#fullTarget').append('<td>'+data.categoryName+'</td>');
					$('#fullTarget').append('<td>'+data.volunteerTime+'</td>');
					$('#fullTarget').append('</tr>');
				});
				
					//이전
					if(prePage > 0){
						$('#fullPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveFullVolunteer(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(-1)">'+prePage+'</button></li>');
					};
					
					//현재
					$('#fullPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(1)">'+nextPage+'</button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			})
		}
		
		fullVolunteer(fullCurrentPage);
		
		function moveFullVolunteer(num){
			fullCurentPage = fullCurrentPage+num;
			fullVolunteer(fullCurentPage);
		}
		
		
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