<!-- 작성자 : 김선유 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>getBoardList</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<!-- Place favicon.ico in the root directory -->

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
<!-- <link rel="stylesheet" href="css/responsive.css"> -->
<script>
	$(document).ready(function(){
		$('#btn').click(function(){
			 console.log("btn click!");
			 $('#boardForm').submit();
		});
	});
function addBoard(loginMember){
	if(loginMember==null || loginMember==''){
		alert('로그인 후 이용 가능합니다.');
	} else {
		window.location.href='<c:url value="/member/addBoard"/>';
	}
}
function getBoardOne(loginMember, boardId){
	if(loginMember==null || loginMember==''){
		alert('로그인 후 이용 가능합니다.');
	} else {
		window.location.href='<c:url value="/member/getBoardOne?boardId='+boardId+'"/>';
	}
}
</script>
</head>
<body>
	<header>
		<div class="header-area">		
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
				<div class="col-lg-12">
					<h3>자유게시판</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="pet_care_area">
        <div class="container">
          <div><a href="${pageContext.request.contextPath}/getBoardList">[전체보기]</a></div>
            <div class="row align-items-center">           
               <table class="table table-hover text-center">
                	<thead>
						<tr>
							<th>No.</th>
							<th>제목</th>
							<th>동물 종류</th>
							<th>작성자</th>
							<th>게시판 카테고리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="b" items="${boardList}">
							<tr>
								<td>${b.boardId}</td>
								<td><a data-parameter1="${loginMember.memberId}" data-parameter2="${b.boardId}"
									onclick="getBoardOne(this.getAttribute('data-parameter1'), this.getAttribute('data-parameter2'))">${b.boardTitle}</a></td>
								<td>${b.species}</td>
								<td>${b.memberId}</td>
								<td>${b.boardCategoryName}</td>
							</tr>
						</c:forEach>
					</tbody>
                </table>
                </div>
                <div class="text-right"><a type="button" class="genric-btn primary-border circle arrow medium"
                data-parameter1="${loginMember.memberId}" onclick="addBoard(this.getAttribute('data-parameter1'))">글작성</a></div>
                <!-- 페이징 -->
				<div class="blog_left_sidebar">
					<nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
						<!-- 이전 페이지 -->
						<c:if test="${currentPage-1 >0}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage-1}&boardName=${boardName}" 
							class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i></a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage-1}&boardName=${boardName}" 
							class="page-link">${currentPage-1}
							</a></li>
						</c:if>
						<c:if test="${currentPage-1 <= 0}">
						</c:if>
						<!-- /이전 페이지 -->
						<!-- 현재 페이지 -->
							<li class="page-item active"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage}&boardName=${boardName}" 
							class="page-link">${currentPage}
							</a></li>
						<!-- /현재 페이지 -->
						<!-- 다음 페이지 -->
						<c:if test="${currentPage+1 <= lastPage}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage+1}&boardName=${boardName}" 
							class="page-link" aria-label="Next"> ${currentPage+1}
							</a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage+1}&boardName=${boardName}" 
							class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
							</a></li>
						</c:if>
						<!-- /다음 페이지 -->
						</ul>
					</nav>
					<hr>
				</div>
				<!-- /페이징 -->
                <!-- 검색 -->
				<div class="default-select" id="default-select">
				</div>
				<form action="${pageContext.request.contextPath}/getBoardList" id="boardForm">
				<div class="form-group">
					<div class="input-group mb-4">
					    <div class="list">
							<select name="species">
								<option value="">종 선택</option>
								<c:forEach var="a" items="${animalCategoryList}">
					    			<c:if test="${a.species == species}"> 
					    				<option value="${a.species}" selected="selected">${a.species}</option>
					    			</c:if>
					    			<c:if test="${a.species != species}"> 
					    				<option value="${a.species}">${a.species}</option>
					    			</c:if>
				    			</c:forEach>
							</select>
            			</div>
						<input type="text" id="sName" class="form-control" placeholder=' 제목을 검색하세요.' onfocus="this.placeholder = ''" onblur="this.placeholder = '제목을 검색하세요.'" name="boardTitle">
						<button id="btn" class="btn" type="button"><i class="fa fa-search"></i></button>
					</div>
				</div>
				</form>
			<!-- /검색 -->
			</div>
    </div>

	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->


	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
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

<script>
	$('#datepicker').datepicker({
		iconsLibrary: 'fontawesome',
		disableDaysOfWeek: [0, 0],
		//icons: {
		//rightIcon: '<span class="fa fa-caret-down"></span>'
		//}
	});
	
	$('#datepicker2').datepicker({
		iconsLibrary: 'fontawesome',
		icons: {
			rightIcon: '<span class="fa fa-caret-down"></span>'
		}
	});
	
	var timepicker = $('#timepicker').timepicker({
		format: 'HH.MM'
	});
</script>
</body>
</html>