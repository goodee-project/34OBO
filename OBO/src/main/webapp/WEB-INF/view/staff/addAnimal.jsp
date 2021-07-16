<!-- 작성자 : 남민정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
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
	    $(document).ready(function() {
	   	 $('#addBtn').click(function() {
	   		 console.log('btn click...');
	           $('#addAnimal').submit();   
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
					<h3>보호소</h3>
				</div>
			</div>
		</div>
	</div>
	
	 <!-- animalList start  -->
    <div class="team_area">
        <div class="container">
            <div class="row justify-content-center ">
                <div class="col-lg-6 col-md-10">
                    <div class="section_title text-center mb-95">
                        <h3>동물 등록</h3>
                    </div>
                </div>
            </div>
	




	<div class="container">
		<form id="addAnimal" action="${pageContext.request.contextPath}/staff/addAnimal" method="post">
			<table>
				<tr>
					<td>동물 번호</td>
					<td>
						<input class="form-control" id="animalId" type="text">
					</td>
				</tr>
				<tr>
					<td>동물 카테고리 번호</td>
					<td>
						<input class="form-control" id="animalCateogyrId" type="text" name="animalCateogyrId" >
					</td>
				</tr>
				<tr>
					<td>보호소 번호</td>
					<td>
						<input class="form-control" id="shelterId" type="text" name="shelterId" >
					</td>
				</tr>
				<tr>
					<td>동물 이름</td>
					<td>
						<input class="form-control" id="animalName" type="text" name="animalName">
					</td>
				</tr>
				<tr>
					<td>동물 나이(개월)</td>
					<td>
						<div>
							<input class="form-control" id="animalAge" type="text" name="animalAge">
						</div>
						
					</td>
				</tr>
				<tr>
					<td>동물 성별</td>
					<td>
						<select class="form-control" id="animalSex" name="animalSex">
							<option value="">==성별 선택==</option>
		                    <option value="male">수컷</option>
		                    <option value="female">암컷</option>
		                    <option value="maleNeutering">수컷(중성화)</option>
		                    <option value="femaleNeutering">암컷(중성화)</option>
		                   
	                  	</select>
					</td>
				</tr>
				<tr>
					<td>동물 무게</td>
					<td>
						<div>
							<input class="form-control" id="animalWeight" type="text" name="animalWeight">
						</div>
					</td>
				</tr>
				<tr>
					<td>동물 종류</td>
					<td>
						<input class="form-control" id="animalKind" type="text" name="animalKind">
					</td>
				</tr>
				<tr>
					<td>발견한 장소</td>
					<td>
						<input class="form-control" id="animalFindPlace" type="text" name="animalFindPlace">
					</td>
				</tr>
				<tr>
					<td>동물 상세정보(회원 보여줄 노트)</td>
					<td>
						<input class="form-control" id="animalNote" type="text" name="animalNote">
					</td>
				</tr>
				<tr>
					<td>동물 상태</td>
					<td>
						<select class="form-control" id="animalState" name="animalState">
		                    <option value="protect">보호중</option>
		                    <option value="adopt">입양</option>
		                    <option value="euthanasia">안락사</option>
		                    <option value="death">자연사</option>
	                  	</select>
					</td>
				</tr>
			</table>
			
			<button id="addBtn" type="button">등록</button>
			<a href="${pageContext.request.contextPath}/staff/getAnimalList"><button type="button">뒤로가기</button></a>
		</form>
	</div>
</div>
</div>	





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