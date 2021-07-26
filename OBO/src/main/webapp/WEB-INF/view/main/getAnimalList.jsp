<!-- 작성자 : 남궁혜영 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Animal</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

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

<script>
$(document).ready(function(){	
	$('#searchBtn').click(function(){
		console.log('검색');
		$('#searchForm').submit();
	});
});
</script>
</head>
<body>
	<header>
		<div class="header-area ">
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
				<div class="col-lg-12 text-center">
					<h3>동물 목록</h3>
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
							<form action="${pageContext.request.contextPath}/getAnimalList" id="searchForm">
							<h3 class="widget_title">검색 옵션</h3>
							<hr>
							<h5>동물 종류</h5>
								<ul class="list cat-list">
									<li>
										<select class="select" name="species">
											<option value="">동물 종류 선택</option>
											<c:forEach var="cl" items="${categoryList}">
												<option value="${cl.species}">${cl.species}</option>
											</c:forEach>
										</select>
									</li>
								</ul>
								<hr>
								<h5>보호소 이름</h5>
								<ul class="list cat-list form-group">
									<li>
										<select class="select" name="shelterId">
											<option value="">보호소 선택</option>
											<c:forEach var="sl" items="${shelterList}">
												<option value="${sl.shelterId}">${sl.shelterName}</option>
											</c:forEach>
										</select>
									</li>
								</ul>
								<hr>
								<h5>동물 이름</h5>
								<ul class="list cat-list">
									<li>
										<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="동물 이름 검색"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 이름 검색'" >
									</li>
									<li>
										<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
									</li>
								</ul>
								</form>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="row">
						<c:forEach var="al" items="${animalList}">
						<div class="col-xl-3 col-lg-3 card align-items-center" style="margin:30px">
						<a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&currentPage=${currentPage}&searchWord=${animalName}&species=${species}&shelterId=${shelterId}">
							<img class="card-img-top" src="${pageContext.request.contextPath}/static/img/animal/${al.animalFileName}" alt=""></a>
							<div class="card-body">
							    <h4 class="card-title text-center">${al.animalName}</h4>
							    <p><strong>보호 종료 날짜 : ${fn:substring(al.expectedDay, 0, 10)}</strong></p>
							    <p class="card-text"><a href="${pageContext.request.contextPath}/getShelterOne?shelterId=${al.shelterId}">
							    	<i class="fa fa-home"></i> ${al.shelterName}</a></p>
							    <a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&currentPage=${currentPage}&searchWord=${animalName}&species=${species}&shelterId=${al.shelterId}">
							    보러 가기 <i class="fa fa-arrow-right"></i></a>
							  </div>
						</div>
						</c:forEach>
					</div>
		        	<!-- 페이징 -->
		        	<div class="blog_left_sidebar">
					<nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
						<!-- 이전 페이지 -->
						<c:if test="${currentPage-1 >0}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage-1}
								&searchWord=${animalName}&species=${species}&shelterId=${shelterId}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
							</a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage-1}
								&searchWord=${animalName}&species=${species}&shelterId=${shelterId}" class="page-link">${currentPage-1}
							</a></li>
						</c:if>
						<c:if test="${currentPage-1 <= 0}">
						</c:if>
						<!-- /이전 페이지 -->
						<!-- 현재 페이지 -->
							<li class="page-item active"><a href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage}
								&searchWord=${animalName}&species=${species}&shelterId=${shelterId}" class="page-link">${currentPage}
							</a></li>
						<!-- /현재 페이지 -->
						<!-- 다음 페이지 -->
						<c:if test="${currentPage+1 <= lastPage}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage+1}
								&searchWord=${animalName}&species=${species}&shelterId=${shelterId}" class="page-link" aria-label="Next"> ${currentPage+1}
							</a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage+1}
								&searchWord=${animalName}&species=${species}&shelterId=${shelterId}" class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
							</a></li>
						</c:if>
						<!-- /다음 페이지 -->
						</ul>
					</nav>
					<hr>
					<!-- /페이징 -->
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