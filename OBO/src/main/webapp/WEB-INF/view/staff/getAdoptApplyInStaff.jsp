<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getAdoptApplyInStaff</title>

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
		console.log('검색버튼 클릭!');
		
		// 유효성 검사
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요');
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
					<h3>입양&케어 > 입양 > 신청목록</h3>
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
							<!-- 검색결과 -->
							<div>
								<c:if test="${searchWord != null}">
									"${searchWord}" 검색결과 &nbsp;<a href="${pageContext.request.contextPath}/staff/getAdoptApplyInStaff"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							
							<br>
							<table class="table">
								<tr>
									<td>동물</td>
									<td>회원ID</td>
									<td>회원이름</td>
									<td>신청서류</td> <!-- 클릭 시 다운로드 -->
									<td>승인</td>
								</tr>
								<c:forEach var="a" items="${adoptApplyList}">
									<tr>
										<td>${a.animalName}</td>
										<td>${a.memberId}</td>
										<td>${a.memberName}</td>
										<td>${a.adoptApplyDocumentId}</td>
										<td> <!-- 아이콘 클릭 시 새 창으로 열지? 아님 모달창 사용할지? -->
											<!-- 승인 btn -->
											<a id="approvalBtn" data-toggle="modal" data-target="#approval-modal" onclick="approvalFun(${a.adoptApplyId});">
												<i class="fa fa-check-circle fa"></i>
											</a>
											<!-- 거절 btn --> 
											<a id="rejectBtn" data-toggle="modal" data-target="#reject-modal" onclick="rejectFun(${a.adoptApplyId});">
												<i class="fa fa-times-circle fa"></i>
											</a> 
										</td>
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
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getAdoptApplyInStaff">
							<div class="form-group">
								<div class="input-group mb-4">
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="동물 이름을 입력해주세요"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 이름을 입력해주세요'" >
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
	
	<!-- 승인 확인 모달 -->
	<div class="modal fade" id="approval-modal" role="dialog" aria-labelledby="approval-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">입양 승인 하시겠습니까?</h4>
					<br>
					<br>
					<div><input id="input" type="hidden"></div>
					<button id="approvalBtn" class="genric-btn primary-border radius" onclick="yesApprovalFun($('#input').val());">확인</button>
					<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 승인 거절 -->
	<div class="modal fade" id="reject-modal" role="dialog" aria-labelledby="reject-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">입양 거절 하시겠습니까?</h4>
					<br>
					<br>
					<div><input id="input" type="hidden"></div>
					<button id="rejectBtn" class="genric-btn primary-border radius" onclick="yesRejectFun($('#input').val());">확인</button>
					<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<script>

	function approvalFun(id){
		console.log('입양 승인 버튼 클릭');
		console.log('넘어온 id'+id);
		$('#input').val(id);
		
	}
	
	function rejectFun(id){
		console.log('입양 거절 버튼 클릭');
		console.log('넘어온 id'+id);
		$('#input').val(id);
	}
	
	function yesApprovalFun(id){
		console.log('모달창 -> 입양 확인 버튼 클릭');
		console.log('넘어온 id'+id);
		
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/addAdopt',
			data: {adoptApplyId : id},
			success: function(jsonData){
				if(jsonData != 1){
					alert('승인 에러!');
					return;
				}
				
				alert('입양 승인이 완료되었습니다.');
				location.href='${pageContext.request.contextPath}/staff/getAdoptApplyInStaff';
				
				// 바로 plan 작성하겠냐는 창 만들어보기.
			}
		});
	}
	
	function yesRejectFun(id){
		console.log('모달창 -> 입양 거절 버튼 클릭');
		console.log('넘어온 id'+id);
		
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/modifyReject',
			data: {adoptApplyId : id},
			success: function(jsonData){
				if(jsonData != 1){
					alert('거절 에러!');
					return;
				}
				
				alert('입양 거절이 완료되었습니다.');
				location.href='${pageContext.request.contextPath}/staff/getAdoptApplyInStaff';
			}
		});
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