<!-- 작성자 : 김선유 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>getShelterList</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<!-- Place favicon.ico in the root directory -->

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
<!-- <link rel="stylesheet" href="css/responsive.css"> -->

<script>
	$(document).ready(function(){
		// 검색어 선택 옵션에 따라 비동기 방식으로 인풋창이 다르게 나오도록함. 숨겨진 인풋창의 값은 비우기.
		$('#sName').show();
		$('#sAddress').hide().val('');
		$('#searchBtn').click(function(){
			console.log('보호소 이름 검색');
			$('#shelterList').submit();
		});
		$('#searchSelect').change(function(){
			var optionVal = $('#searchSelect option:selected').val();
			if (optionVal == 'shelterName'){
				$('#sName').show();
				$('#sAddress').hide().val('');
				$('#searchBtn').click(function(){
					console.log('보호소 이름 검색');
					$('#shelterList').submit();
				});
			} else {
				$('#sName').hide().val('');
				$('#sAddress').show();
				$('#searchBtn').click(function(){
					console.log('보호소 주소 검색');
					$('#shelterList').submit();
				});
			}
		});
	});
</script>
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
					<h3>보호소 리스트</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="pet_care_area">
        <div class="container">
            <div class="row align-items-center">
               <table class="table table-hover text-center">
                	<thead>
                		<tr>
                			<th>No.</th>
                			<th>보호소 이름</th>
                			<th>설립일</th>
                			<th>보호소 전화번호</th>
                		</tr>
                	</thead>
                	<tbody>
                	<c:forEach var="s" items="${shelterList}">                		
	                		<tr>
	                			<td>${s.shelterId}</td>
	               				<td><a href="${pageContext.request.contextPath}/getShelterOne?shelterId=${s.shelterId}">${s.shelterName}</a></td>
	               				<td>${s.createDate}</td>
	               				<td>${s.shelterPhone}</td>
	                		</tr>                		
                	</c:forEach>
                	</tbody>
                </table>
            </div>
    <!-- 페이징 -->
	<div class="blog_left_sidebar">
		<nav class="blog-pagination justify-content-center d-flex">
			<ul class="pagination">
			<!-- 이전 페이지 -->
			<c:if test="${currentPage-1 >0}">
				<li class="page-item"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage-1}
					&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
				</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage-1}
					&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link">${currentPage-1}
				</a></li>
			</c:if>
			<c:if test="${currentPage-1 <= 0}">
			</c:if>
			<!-- /이전 페이지 -->
			<!-- 현재 페이지 -->
				<li class="page-item active"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage}
					&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link">${currentPage}
				</a></li>
			<!-- /현재 페이지 -->
			<!-- 다음 페이지 -->
			<c:if test="${currentPage+1 <= lastPage}">
				<li class="page-item"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage+1}
					&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Next"> ${currentPage+1}
				</a></li>
				<li class="page-item"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage+1}
					&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
				</a></li>
			</c:if>
			<!-- /다음 페이지 -->
			</ul>
		</nav>
		<hr>
	</div>
	<!-- /페이징 -->
		
	<!-- 검색 -->
	<div class="default-select" id="default-select">
	</div>
	<form action="${pageContext.request.contextPath}/getShelterList" id="shelterList">
		<div class="form-group">
			<div class="input-group mb-4">
				<select id="searchSelect">
					<option value="shelterName">이름</option>
					<option value="searchAddress">주소</option>
				</select>
				<input type="text" id="sName" class="form-control" placeholder='Search Name' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Name'" name="shelterName">
				<input type="text" id="sAddress" class="form-control" placeholder='Search Address' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Address'" name="searchAddress">
				<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
			</div>
		</div>
	</form>
	<!-- /검색 -->
        </div>
    </div>
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