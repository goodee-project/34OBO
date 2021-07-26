<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getVolunteerRecruitP</title>

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
					<h3>봉사 > 일반봉사 > 모집공고</h3>
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
							<jsp:include page="/WEB-INF/view/staff/inc/side/volunteerMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					
					<div class="single-post">
						<a href="${pageContext.request.contextPath}/staff/addVolunteerRecruitN"><button type="button" class="genric-btn primary-border radius">등록</button></a>
						
						<div class="blog_details">
							<table class="table">
								<tr>
									<td>직원</td> <!-- 이름 혹은 이름,ID로 수정 시 쿼리 수정 필수 -->
									<td>카테고리</td>
									<td>제목</td>
									<td>모집인원</td>
									<td>신청인원</td>
									<td>봉사일</td>
									<td>등록일</td>
								</tr>
								<c:forEach var="v" items="${volunteerRecruitN}">
									<tr>
										<td>${v.staffId}</td>
										<td>${v.volunteerCategoryName}</td>
										<td>${v.volunteerTitle}</td>
										<td>${v.recruitCount}</td>
										<td>${v.applyCount}</td>
										<td>${v.volunteerDate}</td>
										<td>${v.registerDate}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					
					<!-- 페이징 & 검색 -->
					<div class="search_form">
					<div class="blog_left_sidebar">
					
						<!-- 페이징 -->
						<nav class="blog-pagination justify-content-center d-flex">
							<ul class="pagination">
								<!-- 이전 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/" class="page-link" aria-label="Previous"><i class="ti-angle-left"></i></a>
								</li>
								<li class="page-item"><a href="${pageContext.request.contextPath}/staff/" class="page-link">1</a></li>
								<li class="page-item active"><a href="${pageContext.request.contextPath}/staff/" class="page-link">2</a></li>
								
								<!-- 다음 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/" class="page-link" aria-label="Next"><i class="ti-angle-right"></i></a>
								</li>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getVolunteerRecruitN">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="categoryName" class="select_box">
										<option value="non">카테고리</option>
										<c:forEach var="c" items="${categoryNameList}">
											<c:if test="${categoryName == c}">
												<option value="${c}" selected>${c}</option>
											</c:if>
											<c:if test="${categoryName != c}">
												<option value="${c}">${c}</option>
											</c:if>
										</c:forEach>
									</select>
									<select id="searchSelect" class="select_box">
										<option value="non">==검색명==</option>
										<c:if test="${searchSelect == 'title'}">
											<option value="title" selected>제목</option>
										</c:if>
										<c:if test="${searchSelect != 'title'}">
											<option value="title">제목</option>
										</c:if>
										<c:if test="${searchSelect == 'staffId'}">
											<option value="staffId" selected>직원ID</option>
										</c:if>
										<c:if test="${searchSelect != 'staffId'}">
											<option value="staffId">직원ID</option>
										</c:if>
									</select>
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요"
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