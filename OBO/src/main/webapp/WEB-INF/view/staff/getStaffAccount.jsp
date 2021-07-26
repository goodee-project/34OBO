<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffAccount</title>
<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- CSS here -->

<!-- 위의 cdn과 충돌로 인해 모달창 오류 발생. 주석처리함
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
 -->
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
	$('#myAccountClick').click(function() {
		//$('.modal').modal('show');
		
		console.log('내 정보 클릭');
		
		$('#ckBtn').click(function(){
			console.log('pw 입력 후 확인버튼 클릭!');
			$.ajax({
				url: '${pageContext.request.contextPath}/checkStaffPw',
				type: 'post',
				data: {staffPw : $('#staffPw').val()},
				success: function(jsonData){
					// console.log('계정클릭 ajax 성공!');
					if(jsonData != 1){
						alert('PW가 일치하지 않습니다.');
						return;
					}
					console.log('pw일치 합니다.');
					location.href='${pageContext.request.contextPath}/staff/modifyStaff';	//일치하면 페이지 이동
				}
			});	// ajax; pw 일치
		});	// ckBtn; 모달창 pw 입력 후 확인버튼 클릭
	});	// myAccountClick; 내 정보 클릭
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
					<h3>계정</h3>
				</div>
			</div>
		</div>
	</div>

	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->

	<div class="service_area">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-5 col-md-5">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account">
						<div class="service_content text-center">
							<a class="d-inline-block" href="${pageContext.request.contextPath}/staff/modifyStaff"
								id="myAccountClick" data-toggle="modal" data-target="#login-modal">
								<h3>내 정보</h3>
							</a>
							<p>
								<!-- id, email, name, phone, level -->
								<table class="table">
									<tr>
										<td>ID</td>
										<td>${staffOne.staffId}</td>
									</tr>
									<tr>
										<td>이름</td>
										<td>${staffOne.staffName}</td>
									</tr>
									<tr>
										<td>email</td>
										<td>${staffOne.staffEmail}</td>
									</tr>
									<tr>
										<td>phone</td>
										<td>${staffOne.staffPhone}</td>
									</tr>
									<tr>
										<td>레벨</td>
										<td>${staffOne.staffLevel}</td>
									</tr>
								</table>
							</p>
						</div>
					</div>
				</div>

				<div class="col-lg-5 col-md-5">
					<div class="single_service staff_account">
						<div class="service_content text-center">
							<c:if test="${loginStaff.staffLevel == 2}">
								<a class="d-inline-block" href="${pageContext.request.contextPath}/staff/modifyStaffState">
									<h3>승인 대기</h3>
								</a>
							</c:if>
							
							<c:if test="${loginStaff.staffLevel != 2}">
								<h3>승인 대기</h3>
							</c:if>
							<div>
								<table class="table">
									<tr>
										<td>ID</td>
										<td>이름</td>
									</tr>
									<c:forEach var="s" items="${staffLevel0}">
										<tr>
											<td>${s.staffId}</td>
											<td>${s.staffName}</td>
										</tr>
									</c:forEach>
								</table>
							</div>
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

	<!-- pw 모달 -->
	<div class="modal fade modal_pw" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">비밀번호를 입력하세요</h5>
					<br>
					<input id="staffPw" class="form-control" type="password"  name="password" placeholder="PW 입력" required="required"> <br />
					<div style="float:right;">
						<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
						<button id="ckBtn" type="button" class="genric-btn primary-border radius">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

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