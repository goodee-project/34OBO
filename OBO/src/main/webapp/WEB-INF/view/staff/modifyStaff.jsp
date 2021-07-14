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

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<!-- Place favicon.ico in the root directory -->

<!-- CSS here -->
<link rel="stylesheet" href="../static/css/bootstrap.min.css">
<link rel="stylesheet" href="../static/css/owl.carousel.min.css">
<link rel="stylesheet" href="../static/css/magnific-popup.css">
<link rel="stylesheet" href="../static/css/font-awesome.min.css">
<link rel="stylesheet" href="../static/css/themify-icons.css">
<link rel="stylesheet" href="../static/css/nice-select.css">
<link rel="stylesheet" href="../static/css/flaticon.css">
<link rel="stylesheet" href="../static/css/gijgo.css">
<link rel="stylesheet" href="../static/css/animate.css">
<link rel="stylesheet" href="../static/css/slicknav.css">
<link rel="stylesheet" href="../static/css/style.css">
<!-- <link rel="stylesheet" href="css/responsive.css"> -->

<script>
$(document).ready(function(){	
	let idBtn = false;
	let pwCheck = false;
	
	
	// 가입 버튼 클릭 시 -> 유효성 검사 필요
	$('#modifyBtn').click(function(){
		console.log('modifyBtn 버튼 클릭!');
		$('#modifyForm').submit();
		
		//보호소 -> 이름 -> 아이디 -> 패스워드 -> 연락처 -> 이메일
		/*
		if($('#staffName').val() == null){
			alert('이름을 입력하세요.');
		} else if(idBtn == false){
			alert('ID 중복확인은 필수입니다.');
		} else if(pwCheck == false){
			alert('PW를 정확하게 입력하세요.');
		} else if($('#staffPhone').val().length != 11){
			alert('연락처는 13자리입니다.');
		} else if($('#staffEmail').val() == null){
			alert('email을 입력하세요.');
		} else{
			$('#addForm').submit();
		}*/
	});
});
</script>
</head>
<body>
	<h1>modifyStaff</h1>
	
	<form id="modifyForm" action="${pageContext.request.contextPath}/staff/modifyStaff" method="post">
		<table class="table">
			<tr>
				<td>이름</td>
				<td>
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
						<input id="staffPwCheck" type="password" name="" placeholder="변경 시 입력해주세요">
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
					<input id="staffEmail" type="text" name="staffEmail" placeholder="example@gmail.coom" value="${staffOne.staffEmail}">
				</td>
			</tr>
			
		</table>
		
		<button id="modifyBtn" type="button">수정</button>
		<a href="${pageContext.request.contextPath}/staff/getStaffAccount"><button type="button">취소</button></a>
	</form>

	<!-- JS here -->
	<script src="../static/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="../static/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="../static/js/popper.min.js"></script>
	<script src="../static/js/bootstrap.min.js"></script>
	<script src="../static/js/owl.carousel.min.js"></script>
	<script src="../static/js/isotope.pkgd.min.js"></script>
	<script src="../static/js/ajax-form.js"></script>
	<script src="../static/js/waypoints.min.js"></script>
	<script src="../static/js/jquery.counterup.min.js"></script>
	<script src="../static/js/imagesloaded.pkgd.min.js"></script>
	<script src="../static/js/scrollIt.js"></script>
	<script src="../static/js/jquery.scrollUp.min.js"></script>
	<script src="../static/js/wow.min.js"></script>
	<script src="../static/js/nice-select.min.js"></script>
	<script src="../static/js/jquery.slicknav.min.js"></script>
	<script src="../static/js/jquery.magnific-popup.min.js"></script>
	<script src="../static/js/plugins.js"></script>
	<script src="../static/js/gijgo.min.js"></script>
	
	<!--contact js-->
	<script src="../static/js/contact.js"></script>
	<script src="../static/js/jquery.ajaxchimp.min.js"></script>
	<script src="../static/js/jquery.form.js"></script>
	<script src="../static/js/jquery.validate.min.js"></script>
	<script src="../static/js/mail-script.js"></script>
	<script src="../static/js/main.js"></script>
	
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