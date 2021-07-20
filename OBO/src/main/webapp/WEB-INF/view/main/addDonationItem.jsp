<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물품 후원신청</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
					<h3>물품후원</h3>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->

	<div class="service_area">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-11 col-md-10">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 100%;">
						<div class="service_content">
								<h3 class="text-center">물품후원 신청</h3>
							
								<form id="donationForm" action="${pageContext.request.contextPath}/member/addDonation" method="post">
									<table class="table">
										<tr>
											<th>보호소</th>
											<td>
												<select id="shelter" name="shelterId">
													<c:forEach var="s" items="${shelterList}">
														<option value="${s.shelterId}">${s.shelterName}
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>물품</th>
											<td>
												<select id="item" name="itemCategoryId">
													<c:forEach var="i" items="${itemCategoryList}">
														<option value="${i.itemCategoryId}">${i.itemCategoryName}
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th>ID</th>
											<td>
												<input id="memberId" type="text" name="memberId" readonly="readonly" value="${memberId}">
											</td>
										</tr>
										<tr>
											<th>물품명</th>
											<td>
												<input id="itemName" type="text" name="itemName">
											</td>
										</tr>
										<tr>
											<th>수량</th>
											<td>
												<input id="itemQuantity" type="text" name="itemQuantity">
											</td>
										</tr>
										<tr>
											<th>설명</th>
											<td>
												<textarea id="itemDescription" name="itemDescription" rows="10" cols="50"></textarea>	
											</td>
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
	
	


<script>
//후원하기 버튼 클릭
function addDonationBtn(){
	console.log('버튼 click');
	
	if($('#shelter').val() == ''){
		alert('보호소를 선택해주세요.');
		$('#shelter').focus();
	} else if($('#item').val() == ''){
		alert('물품 카테고리를 선택해주세요.');
		$('#item').focus();
	} else if($('#itemName').val() == ''){
		alert('물품명을 입력해주세요.');
		$('#itemName').focus();
	} else if($('#itemQuantity').val() == ''){
		alert('수량을 입력해주세요.');
		$('#itemQuantity').focus();
	} else {
		console.log('비밀번호 검사 시작합니다.');
		//비밀번호 검사
		let checkPw = prompt('비밀번호를 입력하시오.');
		
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
					
					//ajax로 보냄...
					
					$.ajax({
						type: 'post',
						url: '${pageContext.request.contextPath}/member/addDonationItem',
						data: $('#donationForm').serialize()
					}).done(function(jsonData){
						//true면 성공 false면 실패
						
						if(jsonData == false){
							alert('후원 실패....');
						} else {
							window.location.href = '${pageContext.request.contextPath}/member/getMemberDonation'
						}
					});
				}
			}
		})
	}		
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