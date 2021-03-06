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
							<jsp:include page="/WEB-INF/view/staff/inc/side/donationMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<div>
								<c:if test="${itemCategoryName != null}">
									[카테고리 - ${itemCategoryName}] 
								</c:if>
								<c:if test="${searchSelect == 'member'}">
									회원정보 
								</c:if>
								<c:if test="${searchSelect == 'itemName'}">
									물품명 
								</c:if>
								<c:if test="${searchSelect != null}">
									"${searchWord}" 
								</c:if>
								<c:if test="${itemCategoryName != null || (searchSelect != null && searchWord != null)}">
									검색결과 &nbsp;<a href="${pageContext.request.contextPath}/staff/getDonationItemN"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							
							<br>
							<table class="table">
								<tr>
									<td width="14%">회원정보</td>
									<td>카테고리</td>
									<td>물품명</td>
									<td>수량</td>
									<td width="14%">후원일</td>
									<td style="text-align:center;">상세보기</td>
								</tr>
								<c:forEach var="d" items="${donationItemList}">
									<tr>
										<td>${d.memberName}(${d.memberId})</td>
										<td>${d.itemCategoryName}</td>
										<td>${d.itemName}</td>
										<td>${d.itemQuantity}</td>
										<td>${d.donationDate}</td>
										<td style="text-align:center;">
											<a href="javascript:void(0);" data-toggle="modal" data-target="#item-modal" onclick="descriptionFunc('${d.memberId}','${d.memberName}','${d.itemCategoryName}','${d.itemName}','${d.itemQuantity}','${d.itemDescription}');">
											<i class="fa fa-external-link"></i></a>
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
					
						<!-- 페이징 -->
						<nav class="blog-pagination justify-content-center d-flex">
							<ul class="pagination">
								<!-- 이전 페이지 setting -->
								<c:if test="${currentPage > 1}">
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getDonationItemN?currentPage=${currentPage-1}&itemCategoryName=${itemCategoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getDonationItemN?currentPage=${currentPage-1}&itemCategoryName=${itemCategoryName}
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
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getDonationItemN?currentPage=${currentPage+1}&itemCategoryName=${itemCategoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Next">${currentPage+1}
									</a></li>
									<li class="page-item"><a href="${pageContext.request.contextPath}/staff/getDonationItemN?currentPage=${currentPage+1}&itemCategoryName=${itemCategoryName}
										&searchSelect=${searchSelect}&searchWord=${searchWord}" class="page-link" aria-label="Next"><i class="ti-angle-right"></i>
									</a></li>
								</c:if>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getDonationItemN">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="itemCategoryName" class="select_box" name="itemCategoryName">
										<option value="">카테고리선택</option>
											<c:forEach var="i" items="${itemCategoryList}">
												<c:if test="${itemCategoryName == i.itemCategoryName}">
													<option value="${i.itemCategoryName}" selected>${i.itemCategoryName}</option>
												</c:if>
												<c:if test="${itemCategoryName != i.itemCategoryName}">
													<option value="${i.itemCategoryName}">${i.itemCategoryName}</option>
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
										<c:if test="${searchSelect == 'itemName'}">
											<option value="itemName" selected>물품명</option>
										</c:if>
										<c:if test="${searchSelect != 'itemName'}">
											<option value="itemName">물품명</option>
										</c:if>
									</select> 
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요" value="${searchWord}"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '검색어를 입력해주세요'" >
									<button id="searchBtn" class="btn" type="button" onclick="clickFun();"><i class="fa fa-search"></i></button>
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
	
	<!-- 후원 물품 모달 -->
	<div class="modal fade" id="item-modal" role="dialog" aria-labelledby="item-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h3 class="modal-title" style="text-align:center;"><span id="memberOne"></span>님의 후원 내역</h3>
					<br>
					<table class="table" style="text-align:center;">
						<tr>
							<td width="40%">카테고리</td>
							<td width="60%"><span id="categoryOne"></span></td>
						</tr>
						<tr>
							<td>물품명</td>
							<td><span id="itemOne"></span></td>
						</tr>
						<tr>
							<td>수량</td>
							<td><span id="quantityOne"></span></td>
						</tr>
						<tr>
							<td>설명</td>
							<td><span id="descOne"></span></td>
						</tr>
					</table>
					<div style="float:right;">
						<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	function clickFun(){
		console.log('검색어 클릭');
		
		if($('#itemCategoryName').val() == $('#searchSelect').val() && $('#searchWord').val() == ''){
			alert('카테고리 혹은 검색어를 선택해주세요');
		} else if($('#searchSelect').val() != '' && $('#searchWord').val() == ''){
			alert('해당 검색어를 입력해주세요!');
		} else if($('#searchSelect').val() == '' && $('#searchWord').val() != ''){
			alert('검색할 내역을 선택해주세요!');
		} else{
			$('#searchForm').submit();
		}
	}
	
	// 설명 클릭
	function descriptionFunc(id, name, category, item, quantity, desc){
		$('#memberOne').text(name+"("+id+")");
		$('#categoryOne').text(category);
		$('#itemOne').text(item);
		$('#quantityOne').text(quantity);
		$('#descOne').text(desc);
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