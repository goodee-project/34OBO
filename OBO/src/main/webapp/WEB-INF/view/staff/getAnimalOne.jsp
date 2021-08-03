<!-- 작성자 : 남민정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>getAnimalOne</title>

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
	<header>
		<div class="header-area ">
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<jsp:include page="/WEB-INF/view/staff/inc/myMenu.jsp"></jsp:include>

			<!-- 흰색 바탕 : 메인 메뉴 -->
			<jsp:include page="/WEB-INF/view/staff/inc/staffMenu.jsp"></jsp:include>
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
                        <h3>동물 상세정보</h3>
                    </div>
                </div>
            </div>
            
	<div class="container">
	    <table class="table">
	    	<input type="hidden" name="animalId" value="${animalMap.animalId}">
			<input type="hidden" name="animalCategoryId" value="${animalMap.animalCategoryId}">
			<input type="hidden" name="shelterId" value="${animalMap.shelterId}">
	        <tbody>
	        	<tr>
	               <td>사진 :</td>
	               <td><img src="${pageContext.request.contextPath}/static/img/animal/${animalMap.animalFileName}" height="200px" width="200px"></td>
	           </tr>
	         
	           <tr>
	               <td>동물 이름 :</td>
	               <td>${animalMap.animalName}</td>
	           </tr>
	           <tr>
	               <td>종 :</td>
	               <td>${animalMap.species}</td>
	           </tr>
	           <tr>
	               <td>동물 나이 :</td>
	               <td>${animalMap.animalAge}</td>
	              </tr>
	           <tr>
	               <td>동물 성별 :</td>
	               <td>${animalMap.animalSex}</td>
	           </tr>
	           <tr>
	               <td>동물 무게 :</td>
	               <td>${animalMap.animalWeight}</td>
	           </tr>
	           <tr>
	               <td>동물 종류 :</td>
	               <td>${animalMap.animalKind}</td>
	           </tr>
	           <tr>
	               <td>발견 장소 :</td>
	               <td>${animalMap.animalFindPlace}</td>
	           </tr>
	           <tr>
	               <td>동물 정보 :</td>
	               <td>${animalMap.animalNote}</td>
	              </tr>
	           <tr>
	               <td>동물 입소 날짜 :</td>
	               <td>${animalMap.animalEnterDate}</td>
	           </tr>
	           <tr>
	               <td>동물 퇴소 날짜 :</td>
	               <td>${animalMap.animalExitDate}</td>
	           </tr>
	           <tr>
	               <td>동물 소개 :</td>
	               <td>${animalMap.animalIntroduce}</td>
	           </tr>
	           <tr>
	               <td>동물 상태 :</td>
	               <td>${animalMap.animalState}</td>
	           </tr>
	           
			</tbody>   
		</table>
	
	     <div style="float:right;">
			<a href="${pageContext.request.contextPath}/staff/getAnimalList?currentPage=${currentPage}&searchWord=${searchWord}"><button type="button" class="genric-btn primary-border radius">뒤로가기</button></a>
			<!-- 전체수정 고유번호는 수정 x -->
			<a href="${pageContext.request.contextPath}/staff/modifyAnimal?animalId=${animalMap.animalId}"><button type="button" class="genric-btn primary-border radius">수정</button></a>
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
</body>
</html>