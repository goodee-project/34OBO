<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getVolunteerCheckN</title>

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
					<h3>봉사 > 일반봉사 > 확인목록</h3>
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
						<div class="blog_details">
							<div>
								<c:if test="${categoryName != null}">
									[카테고리 - ${categoryName}] 
								</c:if>
								<c:if test="${searchSelect == 'member'}">
									회원정보 
								</c:if>
								<c:if test="${searchSelect != null}">
									"${searchWord}" 
								</c:if>
								<c:if test="${categoryName != null || (searchSelect != null && searchWord != null)}">
									검색결과 &nbsp;<a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							<br>
							
							<table class="table">
								<tr>
									<th>회원정보</th> <!-- 이름(아이디) -->
									<th>카테고리</th>
									<th>제목</th>
									<th>봉사시간</th>
									<th>봉사일</th>
									<th>확인일</th>
									<th>확인직원</th>
								</tr>
								<c:forEach var="v" items="${volunteerCheckN}">
									<tr>
										<td>${v.memberName}(${v.memberId})</td>
										<td>${v.volunteerCategoryName}</td>
										<td>${v.volunteerTitle}</td>
										<td>${v.volunteerTime}</td>
										<td>${v.volunteerDate}</td>
										<td>${v.checkDate}</td>
										<td>${v.staffId}</td>
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
								<c:if test="${currentPage > 1}">
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN?currentPage=${currentPage-1}&categoryName=${categoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN?currentPage=${currentPage-1}&categoryName=${categoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link">${currentPage-1}
									</a></li>
								</c:if>
								<c:if test="${currentPage == 1}">
									<!-- 이전 페이지 보이지 않음 -->
								</c:if>
								
								<!-- 현재 페이지 setting -->
								<li class="page-item active"><a href="javascript:void(0);" class="page-link">${currentPage}</a></li>
									
								<!-- 다음 페이지 setting -->
								<c:if test="${currentPage < lastPage}"> <!-- currentPage+1 <= lastPage -->
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN?currentPage=${currentPage+1}&categoryName=${categoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Next">${currentPage+1}
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN?currentPage=${currentPage+1}&categoryName=${categoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Next"><i class="ti-angle-right"></i>
									</a></li>
								</c:if>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getVolunteerCheckN">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="categoryName" class="select_box" name="categoryName">
										<option value="">카테고리</option>
										<c:forEach var="c" items="${categoryNameList}">
											<c:if test="${categoryName == c.categoryName}">
												<option value="${c.categoryName}" selected>${c.categoryName}</option>
											</c:if>
											<c:if test="${categoryName != c}">
												<option value="${c.categoryName}">${c.categoryName}</option>
											</c:if>
										</c:forEach>
									</select>
									<select id="searchSelect" class="select_box" name="searchSelect">
										<option value="">==검색명==</option>
										<c:if test="${searchSelect == 'member'}">
											<option value="member" selected>회원정보</option>
										</c:if>
										<c:if test="${searchSelect != 'member'}">
											<option value="member">회원정보</option>
										</c:if>
									</select>
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '검색어를 입력해주세요'" >
									<button id="searchBtn" class="btn" type="button" onclick="searchFunc();"><i class="fa fa-search"></i></button>
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
	
	<script>
	// 검색어
	function searchFunc(){
		console.log('검색어 클릭');
		
		if($('#categoryName').val() == $('#searchSelect').val() && $('#searchWord').val() == ''){
			alert('카테고리 혹은 검색어를 선택해주세요');
		} else if($('#searchSelect').val() != '' && $('#searchWord').val() == ''){
			alert('해당 검색어를 입력해주세요!');
		} else if($('#searchSelect').val() == '' && $('#searchWord').val() != ''){
			alert('검색할 내역을 선택해주세요!');
		} else{
			$('#searchForm').submit();
		}
	}
	</script>
	
	
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