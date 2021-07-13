<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addStaff</title>
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
	
	
	// id 중복확인
	$('#idBtn').click(function(){
		console.log('idBtn 버튼 클릭!');
		$.ajax({
			type:'get',
			url:'/obo/staffIdCheck',
			data: {staffId : $('#staffId').val()},
			success: function(jsonData){
				console.log('id 중복확인 ajax 성공');
				if(jsonData != 0){
					$('#idCheck').text('중복된 id 입니다.');
				} else{
					$('#idCheck').text('사용가능 합니다.');
					idBtn = true;
				}
			}
		});
	});
	
	// pw 일치확인 -> 자세한 수정 필요
	$('#staffPwCheck').keyup(function(){
		let pwLength = $('#staffPwCheck').val().length;
		
		if(pwLength > 5){
			if($('#staffPw').val() != $('#staffPwCheck').val()){
				$('#pwCheck').text('패스워드가 일치하지 않습니다.');
			} else{
				$('#pwCheck').text('패스워드가 일치합니다.');
				pwCheck = true;
			}
		}
	});
	
	// 가입 버튼 클릭 시 -> 유효성 검사 필요
	$('#addBtn').click(function(){
		console.log('addBtn 버튼 클릭!');
		$('#addForm').submit();
	});
});
</script>
</head>
<body>
	<h1>addStaff</h1>
	
	<form id="addFormEx" class="form-contact contact_form" action="${pageContext.request.contextPath}/staff/login" method="post">
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<input class="form-control valid" name="name" id="name" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter your name'" placeholder="Enter your name">
				</div>
			</div>
			<div class="col-sm-6">
				<div class="form-group">
					<input class="form-control valid" name="email" id="email" type="email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter email address'" placeholder="Email">
				</div>
			</div>
			<div>
				<div class="form-group">
					<input class="form-control" name="subject" id="subject" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Subject'" placeholder="Enter Subject">
				</div>
			</div>
		</div>
		<div class="form-group mt-3">
			<button type="submit" class="button button-contactForm boxed-btn">Send</button>
		</div>
	</form>
	<span>↑ css testing용</span>
	<br><br>
	
	<form id="addForm" action="${pageContext.request.contextPath}/staff/login" method="post">
		<table>
			<tr>
				<td>보호소</td>
				<td>
					<select id="shelterId" name="shelterId">
						<option value="">==선택==</option>
						<c:forEach var="s" items="${shelterList}">
							<option value="${s.shelterId}">${s.shelterName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input id="staffName" type="text" name="staffName">
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<div>
						<input id="staffId" type="text" name="staffId">
					</div>
					<div>
						<button id="idBtn" type="button">확인</button>
						<span id="idCheck"></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td>
					<input id="staffPw" type="password" name="staffPw">
				</td>
			</tr>
			<tr>
				<td>패스워드 확인</td>
				<td>
					<div>
						<input id="staffPwCheck" type="password" name="">
					</div>
					<div>
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
					<input id="staffEmail" type="text" name="staffEmail" placeholder="example@gmail.coom">
				</td>
			</tr>
			
		</table>
		
		<button id="addBtn" type="button">가입</button>
		<a href="${pageContext.request.contextPath}/staff/home"><button type="button">취소</button></a>
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