<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCarePlanInStaff</title>

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
	
	//plan 작성할 동물 선택
	$('#animalId').change(function(){
		console.log('동물선택~');
		$.ajax({
			url: '${pageContext.request.contextPath}/getAdoptApprovalList',
			type: 'get',
			data: {animalId : $('#animalId').val()},
			success: function(jsonData){
				console.log('ajax 성공');
				
				// for문 돌려서 정보 가져오기 -> 회원 id, 이름, 신청일, 입양일
			}
		});
	});
	
	$('#addBtn').click(function(){
		console.log('등록버튼 클릭');
		
		$('#addForm').submit();
	});
	
	$('#checkBtn').click(function(){
		console.log('아이콘클릭 ㅠ');
		
	});
	
});
</script>
</head>
<body>
	<header>
		<div class="header-area ">
		
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<div class="header-top_area">
				<div class="container">
					<div class="row">
						<jsp:include page="/WEB-INF/view/staff/inc/myMenu.jsp"></jsp:include>
					</div>
				</div>
			</div>
			
			<!-- 흰색 바탕 : 메인 메뉴 -->
			<div id="sticky-header" class="main-header-area">
				<div class="container">
					<div class="row align-items-center">
						<div class="col-xl-3 col-lg-3">
							<div class="logo">
								<a href="${pageContext.request.contextPath}/staff/">
									<img src="../static/img/logo.png" alt="">
								</a>
							</div>
						</div>
						
						<div class="col-xl-9 col-lg-9">
							<div class="main-menu  d-none d-lg-block">
								<nav>
									<ul id="navigation">
										<jsp:include page="/WEB-INF/view/staff/inc/staffMenu.jsp"></jsp:include>
									</ul>
								</nav>
							</div>
						</div>
						
						<div class="col-12">
							<div class="mobile_menu d-block d-lg-none"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h3>입양&케어 > 케어 > Plan작성</h3>
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
							<jsp:include page="/WEB-INF/view/staff/inc/side/adoptCareMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<!-- form 형식 작성 -->
							<form id="addForm" action="" method="post">
								<table class="table">
									<tr>
										<td width="25%">직원ID</td>
										<td width="75%">
											${loginStaff.staffId}
											<input id="staffId" class="form-control" name="staffId" type="hidden">
										</td>
									</tr>
									<tr>
										<td>동물 선택</td>
										<td>
											<div class="add_form">
												<select id="animalId" name="animalId" class="select_box">
													<option>한글</option>
													<option>1</option>
													<option>1</option>
													<c:forEach var="a" items="${adoptApprovalList}">
														<option value="${a.animalId}">${a.animalName}</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
								</table>
								
								<div>* 회원정보 *</div>
								<table class="table">
									<tr>
										<td width="25%">회원ID</td>
										<td width="75%">
											<input id="memberId" class="form-control" name="memberId" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>회원이름</td>
										<td>
											<input id="memberName" class="form-control" name="memberName" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>신청일</td>
										<td>
											<input id="applyDate" class="form-control" name="applyDate" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>입양일</td>
										<td>
											<input id="adoptDate" class="form-control" name="adoptDate" type="text" readonly>
										</td>
									</tr>
								</table>
								
								<div>
									* 실행할 Plan *
								</div>
								
								<table class="table">
									<tr>
										<!-- type="date" 넘어가는 값 : 2021-07-20 -->
										<td width="25%">정기검진</td>
										<td width="75%">
											<!-- 정기검진 defalut : 입양일 1년 후 -->
											<input id="careDate" class="form-control" name="careDate" type="date" value="">
										</td>
									</tr>
								</table>
								<div>
									<a id="planAddBtn" type="button"><i class="fa fa-plus-square-o fa-2x"></i></a>
									<a id="planRemoveBtn" type="button"><i class="fa fa-minus-square-o fa-2x"></i></a>
								</div>
								<br><br>
								<button id="addBtn" type="button" class="genric-btn primary-border radius">Plan 작성</button>
							</form>
							
							
						</div>
					</div>
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