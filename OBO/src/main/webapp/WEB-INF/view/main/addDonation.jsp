<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반후원</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
<style>
	th{
		width: 30%;
	}
	
	td{
		width: 70%;
	}
	button {
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
				<div class="col-lg-12 text-center">
					<h3>일반후원</h3>
				</div>
			</div>
		</div>
	</div>
	
	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->

	<div class="service_area">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-md-8">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account">
						<div class="service_content text-center">
								<h3>일반후원 신청</h3>
							
								<form id="donationForm" action="${pageContext.request.contextPath}/member/addDonation" method="post">
									<span id="target"></span>
									<table class="table">
										<tr>
											<th>보호소</th>
											<th>
												<select id="shelter" name="shelterId">
													<c:forEach var="s" items="${shelterList}">
														<option value="${s.shelterId}">${s.shelterName}
													</c:forEach>
												</select>
											</th>
										</tr>
										<tr>
											<th>ID</th>
											<th><input id="memberId" type="text" name="memberId" readonly="readonly" value="${memberId}"></th>
										</tr>
										<tr>
											<th>금액</th>
											<th><input id="amount" type="number" name="amount"></th>
										</tr>
									
									</table>
									<br>
									<br>
									<button type="button" id="donationFormBtn" onclick="addDonationBtn()" class="genric-btn primary-border radius">후원하기</button>
								</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================Blog Area =================-->
	
	<!-- pw 모달 -->
	<div class="modal fade" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">비밀번호를 입력하세요</h5>
					<br>
					<input id="pw" class="form-control" type="password"  name="password" placeholder="PW 입력" required="required"> <br />
					<div style="float:right;">
						<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
						<button id="ckBtn" type="button" onclick="checkedPw(pw.value)" class="genric-btn primary-border radius">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	

<script>
	//<input type="hidden" name="device" value="">
	let device = null;
	console.log(navigator.platform);
	//사용자가 pc인지 mobile 인지 확인하기 -> 윈도우와 맥이 아니면 mobile
 	let filter = "win16|win32|win64|mac|macintel";
	
    if(0 > filter.indexOf(navigator.platform.toLowerCase())){
        device = 'mobile';     
    }else{
        device = 'pc';
    }
    
    console.log(device);
    $('#target').append('<input type="hidden" name="device" value="'+device+'">');
	
    
	//후원하기 버튼 클릭
	function addDonationBtn(){
		console.log('버튼 click');
		
		if($('#shelter').val() == ''){
			alert('보호소를 선택해주세요.');
			$('#shelter').focus();
		} else if($('#amount').val() == ''){
			alert('금액을 입력하시오.');
			$('#amount').focus();
		} else if($('#amount').val() < 4999 ){
			alert('5000원 이상 후원해주세요.');
			$('#amount').focus();
		} else {
			console.log('비밀번호 검사 시작합니다.');
			//비밀번호 검사 - 모달창 열기
			//let checkPw = prompt('비밀번호를 입력하시오.');
			 $('#login-modal').modal();
			 
		}		
	}
	
		function checkedPw(checkPw){
			
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
						$('#pw').val('');
					} else {//회원 정보 수정 페이지로 이동하기 
						$('#donationForm').submit();
					}
				}
			})				
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


</body>
</html>