<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyStaff</title>
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
	let pwCheck = false;
	let emailBtn = false;
	
	// pw 변경 시 pw 확인 일치 여부
	$('#staffPwCk').keyup(function(){
		if($('#staffPwCk').val().length > 3){
			if($('#staffPw').val() != $('#staffPwCk').val()){
				$('#pwCheck').text('패스워드가 일치하지 않습니다.');
			} else{
				$('#pwCheck').text('패스워드가 일치합니다.');
				pwCheck = true;
			}
		}
		
		// 4자리에서 3자리로 바꿀경우 true 값 유지 상태 false로 변경
		if($('#staffPwCk').val().length < 4){
			pwCheck = false;
		}
	});
	
	// 기존 email 값
	let emailBefore = $('#staffEmail').val();
	
	// email 인증키
	let emailKey;
	
	// email 인증버튼 클릭 시
	$('#emailBtn').click(function(){
		console.log('emailBtn 클릭!');
		$('#emailCk').empty();
		
		if($('#staffEmail').val() == emailBefore){
			alert('기존 email주소입니다.');
			$('#staffEmail').focus();
		} else if($('#staffEmail').val() == ''){
			alert('수정할 email을 입력해주세요.');
			$('#staffEmail').focus();
		} else{
			alert('인증 번호가 전송되었습니다.');
			
			$('#emailCk').append(
				'<input id="staffEmailCk" type="text" placeholder="숫자 6자리 입력"> '
				+'<button id="emailCkBtn" type="button" class="genric-btn default-border radius">확인</button>'
				+'<span id="emailCkInfo"></span>'
			)
			
			// email 전송 ajax
			$.ajax({
				url: '${pageContext.request.contextPath}/checkEmail',
				type: 'post',
				data: {email : $('#staffEmail').val()},
				success: function(jsonData){
					emailKey = jsonData;
					console.log('email 인증 번호-> '+emailKey);
				}
			});
		}
		
	});
	
	//[확인] 버튼 클릭 시 -> 유효한 메일인지?
	$(document).on('click', '#emailCkBtn', function(){	// 동적으로 생성된 staffEmailCk, emailCkBtn, emailCkInfo를 바인딩한다.
		console.log('인증번호[확인]버튼 클릭!');
	
		if(emailKey == $('#staffEmailCk').val()){
			$('#emailCkInfo').text('email 인증에 성공했습니다.');
			emailBtn = true;
		} else{
			$('#emailCkInfo').text('인증번호를 다시 확인해주세요.');
		}
	});
	
	
	// 수정 버튼 클릭 시 -> 유효성 검사 필요
	$('#modifyBtn').click(function(){
		console.log('modifyBtn 버튼 클릭!');
		
		// pw 수정 후 일치하지 않을 때
		if(!pwCheck && ($('#staffEmail').val() != '')){
			console.log('pw != pw확인 : 둘 다름');
			alert('PW가 일치하지 않습니다.');
			return;
		}
		
		
		// email 수정 후 인증절차 안 했을 때
		if(!emailBtn && ($('#staffEmail').val() != emailBefore)){
			console.log('email 수정했지만 인증확인을 안 했다!');
			alert('email 수정 후 인증절차를 진행해주세요.');
			return;
		}
		
		if($('#staffName').val() == ''){
			alert('이름을 입력하세요.');
			$('#staffName').focus();
		} else if($('#staffPw').val() != $('#staffPwCk').val()){
			alert('패스워드를 확인하세요.');
			$('#staffPw').focus();
		} else if($('#staffPhone').val() == ''){
			alert('연락처를 입력하세요.');
			$('#staffPhone').focus();
		} else if($('#staffEmail').val() == ''){
			alert('email을 입력하세요.');
		} else{
			alert('정보 수정 완료');
			$('#modifyForm').submit();
		}
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
									<img src="${pageContext.request.contextPath}/static/img/logo.png" alt="">
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
					<h3>정보 수정</h3>
				</div>
			</div>
		</div>
	</div>
	
		<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 mb-5">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<ul class="list cat-list">
								<li>
									<a href="${pageContext.request.contextPath}/staff/modifyStaff" class="d-flex"><p>정보 수정</p></a>
								</li>
								<li>
									<c:if test="${loginStaff.staffLevel == 2}">
										<a href="${pageContext.request.contextPath}/staff/modifyStaffState" class="d-flex"><p>상태 관리</p></a>
									</c:if>
								</li>
							</ul>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<form id="modifyForm" action="${pageContext.request.contextPath}/staff/modifyStaff" method="post">
								<table class="table">
									<tr>
										<td width="25%">이름</td>
										<td width="75%">
											<input id="staffName" type="text" name="staffName" value="${staffOne.staffName}">
										</td>
									</tr>
									<tr>
										<td>ID</td>
										<td>
											<div>
												${staffOne.staffId}
												<input id="staffId" type="hidden" name="staffId" value="${staffOne.staffId}">
											</div>
										</td>
									</tr>
									<tr>
										<td>PW</td>
										<td>
											<input id="staffPw" type="password" name="staffPw" placeholder="변경 시 입력해주세요">
										</td>
									</tr>
									<tr>
										<td>PW 확인</td>
										<td>
											<div>
												<input id="staffPwCk" type="password" name="" placeholder="변경 시 입력해주세요">
											</div>
											<div>
												<span id="pwCheck"></span>
											</div>
										</td>
									</tr>
									<tr>
										<td>연락처</td>
										<td>
											<input id="staffPhone" type="text" name="staffPhone" value="${staffOne.staffPhone}">
										</td>
									</tr>
									<tr>
										<td>이메일</td>
										<td>
											<div>
												<input id="staffEmail" type="text" name="staffEmail" placeholder="example@gmail.coom" value="${staffOne.staffEmail}">
												<button id="emailBtn" type="button" class="genric-btn default-border radius">인증</button>
											</div>
											<div id="emailCk">
											</div>
										</td>
									</tr>
								</table>
								
								<button id="modifyBtn" type="button" class="genric-btn primary-border radius">수정</button>
								<a href="${pageContext.request.contextPath}/staff/getStaffAccount"><button type="button" class="genric-btn primary-border radius">취소</button></a>
							</form>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- 정보 수정 페이지에서 정보 수정을 다시 클릭할 경우 모달을 따로 띄우진 않도록 한다. -->
	<!-- pw 모달 -->
	<div class="modal fade modal_pw" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">비밀번호를 입력하세요</h5>
					<br>
					<input id="staffPw" class="form-control" type="password"  name="password" placeholder="PW 입력" required="required"> <br />
					<button id="ckBtn" type="button" class="btn btn-primary">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

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