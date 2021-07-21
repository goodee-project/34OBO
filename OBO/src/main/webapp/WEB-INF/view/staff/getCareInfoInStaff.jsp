
<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCareInfoInStaff</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

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

<script>
$(document).ready(function(){	
	$('#searchBtn').click(function(){
		console.log('검색어 입력 후 버튼 클릭!');
		if(($('#species').val() == '0') && ($('#careSorting').val() == '0') && ($('#searchWord').val() == '')){
			alert('검색할 항목을 선택 혹은 입력해주세요!');
		} else{
			$('#searchForm').submit();
		}
	});
	
});
</script>
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
					<h3>입양&케어 > 케어 > 케어Info</h3>
				</div>
			</div>
		</div>
	</div>

	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<jsp:include page="/WEB-INF/view/staff/inc/side/adoptCareMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<div>
								<c:if test="${species != null}">
									[${species}]
								</c:if>
								<c:if test="${careSorting != null}">
									[${careSorting}]
								</c:if>
								<c:if test="${searchWord != null}">
									"${searchWord}"
								</c:if>
								<c:if test="${species != null || careSorting != null || searchWord != null}">
									검색결과
									&nbsp;<a href="${pageContext.request.contextPath}/staff/getCareInfoInStaff"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							<br>
							<table class="table">
								<tr>
									<td>No</td>
									<td>종</td>
									<td>분류</td>
									<td>케어내용</td>
									<td>케어시기(월)</td>
								</tr>
								<c:forEach var="c" items="${careInfoList}">
									<tr>
										<td>${c.careInfoId}</td>
										<td>${c.species}</td>
										<td>${c.careSorting}</td>
										<td>${c.careInfoContent}</td>
										<td>${c.careTime}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<br>
					
					<!-- 페이징 & 검색 -->
					<div class="search_form">
					<div class="blog_left_sidebar">
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getCareInfoInStaff" method="get">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="species" class="select_box" name="species">
										<option value="">종</option>
										
										<c:forEach var="a" items="${animalCategoryList}">
											<c:if test="${species == a.species}">
												<option value="${a.species}" selected>${a.species}</option>
											</c:if>
											<c:if test="${species != a.species}">
												<option value="${a.species}">${a.species}</option>
											</c:if>
										</c:forEach>
									</select>
									<select id="careSorting" class="select_box" name="careSorting">
										<option value="">분류</option>
										
										<c:forEach var="c" items="${careSortingList}">
											<c:if test="${careSorting == c}">
												<option value="${c}" selected>${c}</option>
											</c:if>
											<c:if test="${careSorting != c}">
												<option value="${c}">${c}</option>
											</c:if>
										</c:forEach>
									</select>
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="케어내용을 입력해주세요."
											onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Name'" >
									<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
								</div>
							</div>
						</form>
					</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================Blog Area =================-->	


	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->	
	
	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
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
</body>
</html>