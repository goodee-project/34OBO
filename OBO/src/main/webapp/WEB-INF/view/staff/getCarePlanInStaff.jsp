<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCarePlanInStaff</title>

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
					<h3>입양&케어 > 케어 > Plan목록</h3>
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
						<h3>다가오는 Plan</h3>
						<div class="blog_details">
							<table class="table">
								<tr>
									<td>D-day</td>
									<td>이름</td> <!-- care_info & animal_category 조인 -->
									<td>케어Info</td>
									<td>회원정보</td>
									<td>케어일</td>
									<td>Record</td>
								</tr>
								<c:forEach var="c" items="${carePlanDdayList}">
									<tr>
										<td>D-${c.dDay}</td>
										<td>${c.animalName}</td>
										<td>${c.careInfo}</td>
										<td>${c.memberName}(${c.memberId})</td>
										<td>${c.careDate}</td>
										<td style="text-align:center;">
											<a href="javascript:void(0);" data-toggle="modal" data-target="#record-modal" onclick="addRecordFunc('${c.animalName}','${c.careInfo}','${c.memberName}','${c.memberId}','${c.careDate}','${c.carePlanId}');">
												<i class="fa fa-external-link"></i>
											</a>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<br><br>
					<div class="single-post">
						<div class="blog_details">
						<div class="row">
						&emsp;<h3>Care Plan</h3> <span>&emsp;*미작성 record만 확인 가능합니다.*</span>
						</div>
							<!-- 검색결과 -->
							<div>
								<c:if test="${selectOption == 'animal' && searchWord != null}">
									[동물이름]
								</c:if>
								<c:if test="${selectOption == 'care' && searchWord != null}">
									[케어Info]
								</c:if>
								<c:if test="${selectOption == 'member' && searchWord != null}">
									[회원정보]
								</c:if>
								<c:if test="${searchWord != null}">
									"${searchWord}" 검색결과 &nbsp;<a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							<br>
							
							<table class="table">
								<thead>
									<tr>
										<th>이름</th> <!-- care_info & animal_category 조인 -->
										<th>케어Info</th>
										<th>회원정보</th> <!-- 이름(아이디) -->
										<th>작성직원</th>
										<th>케어일</th>
										<th>작성일</th>
										<th>Record</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${carePlanList}">
										<tr>
											<td>${c.animalName}</td>
											<td>${c.careInfo}</td>
											<td>${c.memberName}(${c.memberId})</td>
											<td>${c.staffId}</td>
											<td>${c.careDate}</td>
											<td>${c.createDate}</td>
											<td style="text-align:center;">
												<a href="javascript:void(0);" data-toggle="modal" data-target="#record-modal" onclick="addRecordFunc('${c.animalName}','${c.careInfo}','${c.memberName}','${c.memberId}','${c.careDate}','${c.carePlanId}');">
													<i class="fa fa-external-link"></i>
												</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
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
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff?currentPage=${currentPage-1}
										&selectOption=${selectOption}&searchWord=${searchWord}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff?currentPage=${currentPage-1}
										&selectOption=${selectOption}&searchWord=${searchWord}" class="page-link">${currentPage-1}
									</a></li>
								</c:if>
								<c:if test="${currentPage == 1}">
									<!-- 이전 페이지 보이지 않음 -->
								</c:if>
								
								<!-- 현재 페이지 setting -->
								<li class="page-item active"><a href="javascript:void(0);" class="page-link">${currentPage}</a></li>
									
								<!-- 다음 페이지 setting -->
								<c:if test="${currentPage < lastPage}"> <!-- currentPage+1 <= lastPage -->
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff?currentPage=${currentPage+1}
										&selectOption=${selectOption}&searchWord=${searchWord}" class="page-link" aria-label="Next">${currentPage+1}
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff?currentPage=${currentPage+1}
										&selectOption=${selectOption}&searchWord=${searchWord}" class="page-link" aria-label="Next"><i class="ti-angle-right"></i>
									</a></li>
								</c:if>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getCarePlanInStaff">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="selectOption" class="select_box" name="selectOption">
										<c:if test="${selectOption == 'animal'}">
											<option value="animal" selected>동물이름</option>
										</c:if>
										<c:if test="${selectOption != 'animal'}">
											<option value="animal">동물이름</option>
										</c:if>
										<c:if test="${selectOption == 'care'}">
											<option value="care" selected>케어Info</option>
										</c:if>
										<c:if test="${selectOption != 'care'}">
											<option value="care">케어Info</option>
										</c:if>
										<c:if test="${selectOption == 'member'}">
											<option value="member" selected>회원정보</option>
										</c:if>
										<c:if test="${selectOption != 'member'}">
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
	
	<!-- 케어 record 작성 모달 -->
	<div class="modal fade" id="record-modal" role="dialog" aria-labelledby="record-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title" style="text-align:center;"><span id="animalName"></span>의 Care Plan 작성하기</h4>
					<br>
					<form id="addForm" action="${pageContext.request.contextPath}/staff/getCarePlanInStaff" method="post">
						<table class="table" style="text-align:center;">
							<tr>
								<td width="30%">케어Info</td>
								<td>
									<input id="careInfo" class="form-control" name="careInfo" type="text" readonly>
								</td>
							</tr>
							<tr>
								<td>케어일</td>
								<td>
									<input id="careDate" class="form-control" name="careDate" type="date" readonly>
								</td>
							</tr>
							<tr>
								<td>회원정보</td>
								<td>
									<input id="member" class="form-control" name="member" type="text" readonly>
								</td>
							</tr>
							<tr>
								<td>특이사항</td>
								<td>
									<input id="carePlanId" name="carePlanId" type="hidden">
									<textarea rows="5" cols="80" id="features" class="form-control" name="features"></textarea>
								</td>
							</tr>
						</table>
						
						<br>
						<div style="float:right;">
							<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
							<button type="button" class="genric-btn primary-border radius" onclick="addFunc();">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	// 검색어 버튼 클릭
	function searchFunc(){
		console.log('검색버튼 클릭');
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요');
		} else{
			$('#searchForm').submit();
		}
	}
	
	// record 아이콘 클릭 -> 모달창
	function addRecordFunc(aNama, info, mName, mId, date, planId){
		console.log('모달창 클릭');
		console.log('aNama->'+aNama);
		console.log('info->'+info);
		console.log('mName->'+mName);
		console.log('mId->'+mId);
		console.log('date->'+date);
		console.log('planId->'+planId);
		
		$('#animalName').text(aNama);
		$('#careInfo').val(info);
		$('#careDate').val(date);
		$('#member').val(mName+"("+mId+")");
		$('#carePlanId').val(planId);
	}
	
	// record 작성 모달 -> 모달창에서 확인
	function addFunc(){
		console.log('작성 확인');
		if($('#features').val() == ''){
			alert('특이사항을 입력해주세요.');
			return;
		}
		alert('Care Plan 작성 완료 되었습니다');
		$('#addForm').submit();
		
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