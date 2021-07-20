<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
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
	button{
		float: right;
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
				<div class="col-lg-12">
					<h3>내정보</h3>
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
							<table class="table">
								<tr>
									<th>아이디</th>
									<td>${memberOne.memberId}</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>${memberOne.memberName}</td>
								</tr>
								<tr>
									<th>닉네임</th>
									<td>${memberOne.memberNickname}</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${memberOne.memberEmail}</td>
								</tr>
								<tr>
									<th>가입날짜</th>
									<td>${memberOne.createDate}</td>
								</tr>
								<tr>
									<th>휴대폰번호</th>
									<td>${memberOne.memberPhone}</td>
								</tr>
								<tr>
									<th>생일</th>
									<td>${memberOne.memberBirth}</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>${memberOne.memberGender}</td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td>${memberOne.postCode}</td>
								</tr>
								<tr>
									<th>주소</th>
									<td>
										<div>
											${memberOne.doro}
										</div>
											${memberOne.detailAddress}
										
									</td>
								</tr>
								<tr>
									<th>카카오연동</th>
									<td>
										<c:if test="${memberOne.kakaoId == null}"><!-- 연동x -->
											<a href="javascript:void(0);" onclick="kakao();">
												<img src="${pageContext.request.contextPath}/static/img/kakaolink_btn_medium.png">
											</a>
										</c:if>
										<c:if test="${memberOne.kakaoId != null}"><!-- 연동o -->
											연동되었습니다.
										</c:if>
									</td>
								</tr>
							</table>

							<button id="modifyMemberOne" type="button" onclick="modifyMemberOne()" class="genric-btn primary-border radius">내 정보 수정</button>
							
							<a href="${pageContext.request.contextPath}/member/modifyMemberPw"><button type="button" class="genric-btn primary-border radius">비밀번호 수정</button></a>
						
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
	
	
	
<script>
	//정보수정 페이지로 이동하기 전에 비밀번호 검사
	function modifyMemberOne(){
		console.log('click!');
		
		let checkPw = prompt("비밀번호를 입력하시오");
		
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/getMemberByPwCheck',
			data: {memberPw: checkPw},
			success: function(jsonData){
				console.log('성공');
				console.log(jsonData);
				
				//true면 성공, false면 실패
				if(jsonData == false){
					alert('비밀번호가 틀렸습니다.');
				} else {//회원 정보 수정 페이지로 이동하기 
					window.location.href = '${pageContext.request.contextPath}/member/modifyMemberOne';
				}
			}
		})
				
	}
	
	
	
	//카카오 연동 - 카카오 로그인창 불러오기!
	function kakao(){
		console.log('카카오');
		 $.ajax({
		        url: '${pageContext.request.contextPath}/kakaoLogin',
		        type: 'get',
		        data: {url: 'http://localhost/obo/member/getKakaoLink'}
		    }).done(function (jsonData) {
		        console.log('로그인창 가져왔니?');
		        window.location.href = jsonData;
		    });
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