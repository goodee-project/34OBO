<!-- 작성자 : 남민정 -->

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
</head>
<body>
	<h3>동물 등록</h3>
	<form id="addAnimal" action="${pageContext.request.contextPath}/staff/addAnimal" method="post">
		<table>
			<tr>
				<td>동물 이름</td>
				<td>
					<input id="animalName" type="text" name="animalName">
				</td>
			</tr>
			<tr>
				<td>동물 나이(개월)</td>
				<td>
					<div>
						<input id="animalAge" type="text" name="animalAge">
					</div>
					
				</td>
			</tr>
			<tr>
				<td>동물 성별</td>
				<td>
					<input id="animalSex" type="text" name="animalSex">
				</td>
			</tr>
			<tr>
				<td>동물 무게</td>
				<td>
					<div>
						<input id="animalWeight" type="text" name="animalWeight">
					</div>
				</td>
			</tr>
			<tr>
				<td>동물 종류</td>
				<td>
					<input id="animalKind" type="text" name="animalKind">
				</td>
			</tr>
			<tr>
				<td>발견한 장소</td>
				<td>
					<input id="animalFindPlace" type="text" name="animalFindPlace">
				</td>
			</tr>
			<tr>
				<td>동물 상세정보(회원 보여줄 노트)</td>
				<td>
					<input id="animalNote" type="text" name="animalNote">
				</td>
			</tr>
			<tr>
				<td>동물 상태</td>
				<td>
					<input id="animalState" type="text" name="animalState">
				</td>
			</tr>
		</table>
		
		<button id="addBtn" type="button">등록</button>
		<a href="${pageContext.request.contextPath}/staff/getAnimalList"><button type="button">뒤로가기</button></a>
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