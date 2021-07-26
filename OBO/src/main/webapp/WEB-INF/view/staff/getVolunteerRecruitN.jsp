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
						<a href="javascript:void(0);" data-toggle="modal" data-target="#add-modal" onclick="clickAddFunc();">
							<button type="button" class="genric-btn primary-border radius">등록</button>
						</a>
						
						<div class="blog_details">
							<table class="table">
								<tr>
									<th>직원</th>
									<th>카테고리</th>
									<th>제목</th>
									<th>모집인원</th>
									<th>신청인원</th>
									<th>봉사일</th>
									<th>등록일</th>
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
									<select id="categoryName" class="select_box" name="categoryName">
										<option value="">카테고리</option>
										<c:forEach var="c" items="${categoryNameList}">
											<c:if test="${categoryName == c.categoryName}">
												<option value="${c.categoryName}" selected>${c.categoryName}</option>
											</c:if>
											<c:if test="${categoryName != c.categoryName}">
												<option value="${c.categoryName}">${c.categoryName}</option>
											</c:if>
										</c:forEach>
									</select>
									<select id="searchSelect" class="select_box" name="searchSelect">
										<option value="">==검색명==</option>
										<c:if test="${searchSelect == 'staffId'}">
											<option value="staffId" selected>직원ID</option>
										</c:if>
										<c:if test="${searchSelect != 'staffId'}">
											<option value="staffId">직원ID</option>
										</c:if>
										<c:if test="${searchSelect == 'title'}">
											<option value="title" selected>제목</option>
										</c:if>
										<c:if test="${searchSelect != 'title'}">
											<option value="title">제목</option>
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
	
	<!-- 공고 등록 모달 -->
	<div class="modal fade" id="add-modal" role="dialog" aria-labelledby="add-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">일반 봉사 모집 공고 등록</h4>
					<br><br>
					<form id="addForm" action="${pageContext.request.contextPath}/staff/addVolunteerRecruitN" method="post">
						<table class="table">
							<tr>
								<td>제목</td>
								<td>
									<input id="volunteerTitle" name="volunteerTitle" type="text" class="form-control">
								</td>
							</tr>
							<tr>
								<td>카테고리</td>
								<td>
									<select id="volunteerCategory" name="volunteerCategoryId" class="select_box">
										<option value="">==선택==</option>
									</select>
								</td>
							</tr>
							<tr>
								<td>봉사일</td>
								<td>
									<input id="volunteerDate" name="volunteerDate" type="date" class="form-control">
								</td>
							</tr>
							<tr>
								<td>모집인원</td>
								<td>
									<input id="recruitCount" name="recruitCount" type="number" min="1" class="form-control" value="숫자만 입력해주세요">
								</td>
							</tr>
						</table>
						<br>
						<div style="float:right;">
							<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
							<button type="button" class="genric-btn primary-border radius" onclick="addVolunteerFunc();">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	// 공고 등록 버튼
	function clickAddFunc(){
		console.log('등록 버튼 클릭');
		let addSelect = "";
		//카테고리 리스트 불러오기
		$.ajax({
			url: '${pageContext.request.contextPath}/getVolCategoryList',
			type: 'get',
			success: function(jsonData){
				console.log('카테고리 가져오기 성공');
				addSelect += '<option value="">==선택==</option>';
				
				$(jsonData).each(function(index, item){
					addSelect += '<option value="'+item.categoryId+'">'+item.categoryName+'</option>';
					console.log('카테고리->'+item.categoryName)
				})
				
				$('#volunteerCategory').empty();
				$('#volunteerCategory').append(addSelect);
			}
		});
	}
	
	// 등록 확인 버튼
	function addVolunteerFunc(){
		console.log('공고 등록 action-');
		
		if($('#volunteerTitle').val() == ''){
			alert('제목을 입력하세요');
			$('#volunteerTitle').focus();
		} else if($('#volunteerCategoryId').val() == ''){
			alert('카테고리를 선택하세요');
			$('#volunteerCategoryId').focus();
		} else if($('#volunteerDate').val() == ''){
			alert('봉사일을 선택하세요');
			$('#volunteerDate').focus();
		} else if($('#recruitCount').val() == ''){
			alert('모집인원을 입력하세요');
			$('#recruitCount').focus();
		} else{
			alert('공고 등록 완료!');
			$('#addForm').submit();
		}
	}
	
	// 검색어 검색
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