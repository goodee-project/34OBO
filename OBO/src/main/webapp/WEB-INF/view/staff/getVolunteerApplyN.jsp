<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getVolunteerApplyN</title>

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
					<h3>봉사 > 일반봉사 > 신청목록</h3>
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
							<table class="table">
								<tr>
									<th>회원정보</th>
									<th>제목</th>
									<th>신청일</th>
									<th>봉사일</th>
									<th>확인</th>
								</tr>
								<c:forEach var="v" items="${volunteerApplyN}">
									<tr>
										<td>${v.memberName}(${v.memberId})</td>
										<td>
											<a href="javascript:void(0);" data-toggle="modal" data-target="#title-modal" onclick="titleOneFunc('${v.volunteerRecruitId}','${v.volunteerTitle}');"> 
											${v.volunteerTitle}
											</a>
										</td>
										<td>${v.applyDate}</td>
										<td>${v.volunteerDate}</td>
										<td>
											<!-- 확인 btn -->
											<a data-toggle="modal" data-target="#check-modal" onclick="checkFunc('${v.memberName}','${v.volunteerTitle}','${v.volunteerDate}','${v.volunteerApplyId}');">
												<i class="fa fa-check-circle fa"></i>
											</a>
										</td>
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
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getVolunteerApplyN">
							<div class="form-group">
								<div class="input-group mb-4" >
									<select id="searchSelect" class="select_box" name="searchSelect">
										<c:if test="${searchSelect == 'member'}">
											<option value="member" selected>회원정보</option>
										</c:if>
										<c:if test="${searchSelect != 'member'}">
											<option value="member">회원정보</option>
										</c:if>
										<c:if test="${searchSelect == 'title'}">
											<option value="title" selected>제목</option>
										</c:if>
										<c:if test="${searchSelect != 'title'}">
											<option value="title">제목</option>
										</c:if>
									</select>
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요"
											onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Name'" >
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
	
	<!-- 제목클릭 모달 -->
	<div class="modal fade" id="title-modal" role="dialog" aria-labelledby="title-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h3 class="modal-title" style="text-align:center;"><span id="recruitTitle"></span></h3>
					<br><br>
						<table class="table" style="text-align:center;">
							<tr>
								<td>카테고리</td>
								<td><span id="categoryName1"></span></td>
							</tr>
							<tr>
								<td>봉사일</td>
								<td><span id="volunteerDate1"></span></td>
							</tr>
							<tr>
								<td>모집인원</td>
								<td><span id="recruitCount1"></span></td>
							</tr>
							<tr>
								<td>신청인원</td>
								<td><span id="applyCount1"></span></td>
							</tr>
						</table>
					<br>
					
					<button type="button" class="genric-btn primary-border radius" data-dismiss="modal" style="float:right;">확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 확인클릭 모달 -->
	<div class="modal fade" id="check-modal" role="dialog" aria-labelledby="check-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">*<span id="name"></span>* 님의 봉사 신청을 확인하시겠습니까?</h4>
					<br><br>
					<form id="addForm" action="${pageContext.request.contextPath}/staff/addVolunteerCheckN" method="post">
						<table class="table" style="text-align:center;">
							<tr>
								<td width="40%">모집공고</td>
								<td width="60%">
									<span id="ckTitle"></span>
								</td>
							</tr>
							<tr>
								<td>봉사일</td>
								<td>
									<input id="volunteerDate" type="date" name="volunteerDate" class="form-control" readonly>
									<input id="volunteerApplyId" name="volunteerApplyId" type="hidden">
								</td>
							</tr>
							<tr>
								<td>시작시간</td>
								<td>
									<input id="startTime" name="startTime" type="time" class="form-control">
								</td>
							</tr>
							<tr>
								<td>끝난시간</td>
								<td>
									<input id="endTime" name="endTime" type="time" class="form-control">
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
	// 봉사 제목 클릭
	function titleOneFunc(id, title){
		console.log('제목 클릭');
		console.log('volunteerRecruitId->'+id);
		$('#recruitTitle').text(title);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getVolnteerRecruitOneN',
			type: 'get',
			data: {volunteerRecruitId : id},
			success : function(jsonData){
				$(jsonData).each(function(index, item){
					//span 적용
					$('#categoryName1').text(item.volunteerCategoryName);
					$('#volunteerDate1').text(item.volunteerDate);
					$('#recruitCount1').text(item.recruitCount);
					$('#applyCount1').text(item.applyCount);
					//디버깅
					console.log('volunteerCategoryName->'+item.volunteerCategoryName);
					console.log('volunteerDate->'+item.volunteerDate);
					console.log('recruitCount->'+item.recruitCount);
					console.log('applyCount->'+item.applyCount);
				});
			}
			
		});
		
	}
	
	// 신청 페이지 - 봉사 확인 버튼
	function checkFunc(name, title, date, id){
		console.log('봉사 확인 클릭');
		console.log('name->'+name);
		console.log('title->'+title);
		console.log('date->'+date);
		console.log('id->'+id);
		$('#name').text(name);
		$('#title').val(title);
		$('#ckTitle').text(title);
		$('#volunteerDate').val(date);
		$('#volunteerApplyId').val(id);
		
	}
	
	// 확인 모달 - 확인 버튼 클릭
	function addVolunteerFunc(){
		console.log('찐 등록 버튼 클릭');
		
		if($('#startTime').val() == ''){
			alert('시작시간을 선택해주세요');
			$('#startTime').focus();
		} else if($('#endTime').val() == ''){
			alert('끝난시간을 선택해주세요');
			$('#endTime').focus();
		}
		
		console.log('volunteerDate->'+$('#volunteerDate').val());
		console.log('volunteerApplyId->'+$('#volunteerApplyId').val());
		console.log('startTime->'+$('#startTime').val());
		console.log('endTime->'+$('#endTime').val());
		
		alert('봉사 확인이 완료 되었습니다.');
		$('#addForm').submit();	//form - volunteerDate, volunteerApplyId, startTime, endTime 넘어가는지 확인
		
	}
	
	//검색어
	function searchFunc(){
		console.log('검색어 클릭');
		
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요!');
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