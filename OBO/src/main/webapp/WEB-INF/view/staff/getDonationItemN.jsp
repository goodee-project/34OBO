<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getDonationItemN</title>

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
					<h3>후원 > 물품후원</h3>
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
							<ul class="list cat-list">
								<li>
									<a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="d-flex"><p>물품후원</p></a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/staff/getDonationMoneyN" class="d-flex"><p>일반후원</p></a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/staff/getDonationMoneyP" class="d-flex"><p>정기후원</p></a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/staff/getDonationStats" class="d-flex"><p>통계</p></a>
								</li>
							</ul>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<table class="table">
								<tr>
									<td>No</td>
									<td>회원ID</td>
									<td>카테고리</td>
									<td>물품명</td>
									<td>수량</td>
									<td>설명</td>
									<td>후원일</td>
								</tr>
								<c:forEach var="d" items="${itemList}">
									<tr>
										<td>${d.donationItemListId}</td>
										<td>${d.memberId}</td>
										<td>${d.itemCategoryId}</td>
										<td>${d.itemName}</td>
										<td>${d.itemQuantity}</td>
										<td>${d.itemDescription}</td>
										<td>${d.donationDate}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<br>

					<!-- 페이징 & 검색 -->
					<div class="blog_left_sidebar">
					
						<!-- 페이징 -->
						<nav class="blog-pagination justify-content-center d-flex">
							<ul class="pagination">
								<!-- 이전 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="page-link" aria-label="Previous"><i class="ti-angle-left"></i></a>
								</li>
								<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="page-link">1</a></li>
								<li class="page-item active"><a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="page-link">2</a></li>
								
								<!-- 다음 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="page-link" aria-label="Next"><i class="ti-angle-right"></i></a>
								</li>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getDonationItemN">
							<div class="form-group col-xl-8 col-lg-6">
								<div class="input-group mb-4" >
									<select id="categoryName">
										<option value="0">카테고리</option>
										<option value="searchAddress">주소</option>
									</select>
									<select id="searchSelect">
										<option value="memberId">회원ID</option>
										<option value="itemName">물품명</option>
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
	</section>
	<!--================Blog Area =================-->


	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->


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

</body>
</html>