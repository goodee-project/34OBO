<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addStaff</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 검색어 자동완성 cdn  -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

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

<script>
$(document).ready(function(){	
	let idBtn = false;
	let pwCheck = false;
	let shelterId;
	
	// 보호소 검색
	$('#shelterName').autocomplete({
		source : function(request, response) {
			 $.ajax({
				type: 'get',
				url: '${pageContext.request.contextPath}/getShelterNameList',
				dataType: 'json',
				data: {searchWord : $('#shelterId').val()}, 	// 검색 키워드
				success: function(jsonData){
					console.log('보호소 리스트 가져오기 성공');
					response(
						$.map(jsonData, function(item) {
							return{
								label : item.shelterName,	// 자동완성에 표시되는 값
								value : item.shelterName,	// 자동완성 선택 시 화면에 보여줄 내용
								shelterId : item.shelterId	// 자동완성 선택 시 value에 id 대신 name 뜬다 -> id 값 설정위해 저장
							}
						})
					)
				}
					
			});
		},
		select: function(event, ui){	// 선택한 값 설정
			shelterId = ui.item.shelterId; // 변수에 값 넣어주기 -> (1)에서 넣은 값들을 다시 세팅해준다.
			console.log('선택한 보호소의 shelterId-> '+shelterId);
			$('#shelterId').val(shelterId);	// shelterId 값 설정
			console.log('val 설정 후 shelterId 값-> '+$('#shelterId').val());
		},
		focus: function(evnet, ui){ // 자동 초점
			return false;
		},
		minLength: 1,	// 최소 글자
		delay: 500		// 자동완성 뜨는 시간
	})
	
	// id 중복확인
	$('#idBtn').click(function(){
		console.log('idBtn 버튼 클릭!');
		if($('#staffId').val() == ''){
			alert('사용할 ID를 입력해주세요.');
			return;
		}
		$.ajax({
			type:'get',
			url:'${pageContext.request.contextPath}/getStaffIdCheck',
			data: {staffId : $('#staffId').val()},
			success: function(jsonData){
				console.log('id 중복확인 ajax 성공');
				if(jsonData == 1){
					$('#idCheck').text('중복된 id 입니다.');
				} else{
					$('#idCheck').text('사용가능 합니다.');
					idBtn = true;
				}
			}
		});
	});
	
	// pw 일치확인
	$('#staffPwCheck').keyup(function(){
		if($('#staffPwCheck').val().length > 3){
			if($('#staffPw').val() != $('#staffPwCheck').val()){
				$('#pwCheck').text('패스워드가 일치하지 않습니다.');
			} else{
				$('#pwCheck').text('패스워드가 일치합니다.');
				pwCheck = true;
			}
		}
	});
	
	// email 인증 번호
	let emailKey;
	let emailBtn = false;	// email [확인] 버튼 체크용
	
	// email 인증 버튼 클릭
	$("#emailBtn").click(function() {
		console.log('인증 버튼 클릭');
		let email = $("#staffEmail").val(); // 이메일 입력값.
		alert('인증번호가 전송되었습니다.');
		$('#emailKey').empty();	// 칸 초기화
		
		if(email == '') {
			alert('사용할 email을 입력해주세요.');
		} else {
			$('#emailKey').append(
				'<input id="emailCheck" type="text" placeholder="숫자 6자리"> '
				+'<button id="emailCkBtn" type="button" class="genric-btn default-border radius">확인</button> '
				+'<span id="emailCheckInfo"></span>'
			);
			
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/checkEmail',
				data: {email : email},
				success: function(jsonData){
					emailKey = jsonData;
					console.log('email 인증 번호-> '+emailKey);
				}
			});
		}
	});
	
	// email 인증 번호 일치하는지 확인하기 -> email [확인] 버튼 클릭 후 인증 번호 확인 가능하도록 
	$(document).on('click', '#emailCkBtn', function(){
		console.log('[확인] 버튼 클릭!!!');
		if(emailKey != $('#emailCheck').val()){
			console.log('인증 실패');
			$('#emailCheckInfo').text('인증 번호를 다시 확인해주세요.');
		} else{
			emailBtn = true;
			console.log('인증 성공');
			$('#emailCheckInfo').text('email 인증 성공');
		}
	});
	
	// 가입 버튼 클릭 시 -> 유효성 검사 필요
	$('#addBtn').click(function(){
		console.log('addBtn 버튼 클릭!');
		
		//보호소 -> 이름 -> 아이디 -> 패스워드 -> 연락처 -> 이메일
		if($('#shelterId').val() == ''){
			alert('보호소를 선택하세요.');
			$('#shelterId').focus();
		} else if($('#staffName').val() == ''){
			alert('이름을 입력하세요.');
			$('#staffName').focus();
		} else if(idBtn == false){
			alert('ID 중복확인 버튼을 눌러주세요.');
		} else if($('#staffPwCheck').val().length < 4){
			alert('PW는 최소 4자입니다.');
			$('#staffPw').focus();
		} else if(pwCheck == false){
			alert('PW가 일치하지 않습니다.');
			$('#staffPw').focus();
		} else if($('#staffPhone').val() == ''){
			alert('연락처를 입력하세요.');
			$('#staffPhone').focus();
		} else if(isNaN($('#staffPhone').val())){
			alert('연락처는 숫자만 입력하세요.');
			$('#staffPhone').focus();
		} else if($('#staffEmail').val() == ''){
			alert('email을 입력하세요.');
			$('#staffEmail').focus();
		} else if(emailBtn == false){
			alert('email 인증을 해주세요.');
			$('#staffEmail').focus();
		} else{
			$('#addForm').submit();
			alert('회원가입 성공. 승인 후 로그인 가능합니다.');
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
					<h3>Staff 가입</h3>
				</div>
			</div>
		</div>
	</div>

	<section class="sample-text-area">
		<div class="container">
			<div>
				<form id="addForm" action="${pageContext.request.contextPath}/staff/addStaff" method="post">
					<table class="table">
						<tr>
							<td width="30%">보호소</td>
							<td width="70%">
								<input id="shelterName" type="text">
								<input id="shelterId" type="hidden" name="shelterId">
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>
								<input id="staffName" type="text" name="staffName">
							</td>
						</tr>
						<tr>
							<td>ID</td>
							<td>
								<div>
									<input id="staffId" type="text" name="staffId">
									<button id="idBtn" type="button" class="genric-btn default-border radius">확인</button>
									<span id="idCheck"></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>PW</td>
							<td>
								<input id="staffPw" type="password" name="staffPw">
							</td>
						</tr>
						<tr>
							<td>PW 확인</td>
							<td>
								<div>
									<input id="staffPwCheck" type="password">
									<span id="pwCheck"></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>
								<input id="staffPhone" type="text" name="staffPhone">
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<div>
									<input id="staffEmail" type="email" name="staffEmail" placeholder="example@gmail.com">
									<button id="emailBtn" type="button" class="genric-btn default-border radius">인증</button>
								</div>
								<div id="emailKey">
								</div>
							</td>
						</tr>
						
					</table>
					
					<button id="addBtn" type="button" class="genric-btn primary-border radius">가입</button>
					<a href="${pageContext.request.contextPath}/staff/home"><button type="button" class="genric-btn primary-border radius">취소</button></a>
				</form>
			</div>
		</div>
	</section>
	<!-- End Sample Area -->

	
	


	<!-- JS here -->
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