<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
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

<style>
	th{
		width: 30%;
	}
	
	td{
		width: 70%;
	}
</style>
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
					<h3>비밀번호 수정</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>			
				
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<form id="modifyMemberPwForm" method="post">
								<table class="table">
									<tr>
										<th>기존 비밀번호</th>
										<td><input id="originalPw" name="originalPw" type="password"></td>
									</tr>
									<tr>
										<!-- 비밀번호 확인 넣기 -->
										<th>새 비밀번호</th>
										<td><input id="changedPw" name="changedPw" type="password"></td>
									</tr>
									<tr>
										<!-- 비밀번호 확인 넣기 -->
										<th>비밀번호 확인</th>
										<td>
											<input id="memberPwCheck" type="password">
											<div>
												<span id="pwCheck"></span>
											</div>
										</td>
									</tr>
								
								
								</table>
								<div id="google_recaptha">
									<script src='https://www.google.com/recaptcha/api.js'></script>
									<div class="g-recaptcha" data-sitekey="6LdGerYbAAAAABbvuXggPlqem93nw9QNgREOXHE5"></div>
								</div>
								
								
								<button id="modifyMemberPwFormBtn" type="button" class="genric-btn primary-border radius">비밀번호 수정</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
	
	

<script>
	let pwChecked;
	//pw 검사코드
	$("#memberPwCheck").on("propertychange change keyup paste input", function() {
		if($('#changedPw').val().length >3){
			
			if ($("#changedPw").val() == $("#memberPwCheck").val()) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
					$("#pwCheck").text("인증 성공").css("color", "black");
					$('#changedPw').attr( 'readonly', 'readonly' );
					$('#memberPwCheck').attr( 'readonly', 'readonly' );
					pwChecked = true;  //인증 성공여부 check
				} else {
					$("#pwCheck").text("불일치").css("color", "red");
					pwChecked = false; //인증 실패
				}
						
		}
		
	});
	
	$('#modifyMemberPwFormBtn').click(function(){
		console.log('click');
		
		if($('#originalPw').val() == ''){
			alert('비밀번호를 입력해주세요.')
			$('#originalPw').focus();
		} else if($('#changedPw').val() == ''){
			alert('변경할 비밀번호를 입력해 주세요.')
			$('#changedPw').focus();
		} else if(pwChecked != true){
			alert('비밀번호 검사를 해주세요.')
		} else{
			//비밀번호 변경
			
			$.ajax({
				type:'post',
				url: '${pageContext.request.contextPath}/member/modifyMemberPw',
				data: $('#modifyMemberPwForm').serialize(), //form 의 정보 끌어옴
				success: function(jsonData){
					
					if(jsonData == true){ //변경 성공
						//로그아웃으로 이동
						window.location.href = '${pageContext.request.contextPath}/memberLogout';
					} else {//변경 실패시
						alert('비밀번호가 틀렸습니다.');
					}				
				}
			})
			
		}
	});
	
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