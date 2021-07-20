<!-- 작성자 : 남민정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>getAnimalList</title>

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
                        <h3>동물리스트</h3>
                    </div>
                </div>
            </div>
		            

	<div class="container">
		<table class="table">
		      <thead>
		          <tr>   
		            <th>동물 사진</th>
		            <th>동물 이름</th>
		            <th>동물 개월</th>
		            <th>동물 성별</th>         
		            <th>동물 상태</th>
		            
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="a" items="${animalList}">
		            <tr>
		            	<td><img src="${pageContext.request.contextPath}/static/img/animal/${a.animalFileName}" height="150px" width="150px"></td>
		            	<td><a href="${pageContext.request.contextPath}/staff/getAnimalOne?animalId=${a.animalId}">${a.animalName}</a></td>
		            	<td>${a.animalAge}</td>
		            	<td>${a.animalSex}</td>
		            	<td>${a.animalState}</td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>
	 
	 	
		<div>
			<form id="animalForm" action="${pageContext.request.contextPath}/staff/getAnimalList" method="get">
				동물 이름 :
				<input type="text" name="searchWord" value="${searchWord}">
				
				<button id="btn" type="button">검색</button>
			</form>
		</div>
		<br>
	 
	 	
	     <div>
	    	<a  href="${pageContext.request.contextPath}/staff/addAnimal">동물 등록</a>	
	    </div>
	
		<!-- 페이징 -->
	    <ul class="pager">
			<c:if test="${currentPage > 1}">
			   	<a href="${pageContext.request.contextPath}/staff/getAnimalList?currentPage=${currentPage-1}&searchWord=${searchWord}&animalId=${a.animalId}">이전</a>
			</c:if>
			<c:if test="${currentPage < lastPage}">
			    <a href="${pageContext.request.contextPath}/staff/getAnimalList?currentPage=${currentPage+1}&searchWord=${searchWord}&animalId=${a.animalId}">다음</a>
			</c:if>
	   </ul>
   
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
	    $(document).ready(function() {
	   	 $('#btn').click(function() {
	   		 console.log('btn click...');
	           $('#animalForm').submit();   
	        });  
	  	 });
    </script>
</body>
</html>