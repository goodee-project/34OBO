<!-- 작성자 : 김선유 -->
<!-- 수정자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>modifyBoard</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script>
$(document).ready(function(){	
	
	$('#modifyBtn').click(function(){
		console.log('addBtn 버튼 클릭!');
		$('#imgFileUpload').remove();
		if($('#boardCategoryId').val() == '') {
			alert('게시판 카테고리를 선택해주세요')
			$('#boardCategoryId').focus();
		}
		else if($('#boardTitle').val() == '') {
			alert('게시판 제목을 입력해주세요')
			$('#boardTitle').focus();
		}
		else if($('#boardContent').val() == '') {
			alert('게시판 내용을 입력해주세요')
			$('#boardContent').focus();
		}
		else{
			$('#modifyForm').submit();			
		}		
	});
});
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
				<div class="col-12">
					<h3>자유게시판 > 수정</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-9 mb-5 mb-lg-0" style="float: none; margin:auto;">
					<div class="single-post">
						<div class="blog_details">
							<form class="form-contact contact_form" id="modifyForm" action="${pageContext.request.contextPath}/modifyBoard" method="post" enctype="multipart/form-data" >
								<input type="hidden" name="board.boardId" value="${boardMap.boardId}">
								<table class="table">
									<tr>
										<td>제목</td>
										<td>
											<input class="form-control" id="boardTitle" name="board.boardTitle" type="text" value="${boardMap.boardTitle}">
										</td>
									</tr>
									<tr>
										<td>작성자</td>
										<td>
											<input class="form-control" name="board.memberId" id="memberId" type="text" value="${boardMap.memberId}" readonly>
										</td>
									</tr>
									<tr>
										<td width="40%">카테고리</td>
										<td width="60%">
											<select name="board.boardCategoryId" class="form-control">
												<c:forEach var="b" items="${boardCategoryList}">
													<c:if test="${b.boardCategoryName == boardCategoryName}">
														<option value="${b.boardCategoryId}" id="boardCategoryId"
															selected="selected">${b.boardCategoryName}</option>
													</c:if>
													<c:if test="${b.boardCategoryName != boardCategoryName}">
														<option value="${b.boardCategoryId}">${b.boardCategoryName}</option>
													</c:if>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td>종</td>
										<td>
											<select name="board.animalCategoryId" class="form-control">
												<c:forEach var="a" items="${animalCategoryList}">
													<c:if test="${a.species == species}">
														<option value="${a.animalCategoryId}" id="animalCategoryId"
															selected="selected">${a.species}</option>
													</c:if>
													<c:if test="${a.species != species}">
														<option value="${a.animalCategoryId}">${a.species}</option>
													</c:if>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td>내용</td>
										<td>
											<textarea class="form-control w-100" name="board.boardContent" id="boardContent" cols="30" rows="9">${boardMap.boardContent}</textarea>
										</td>
									</tr>
									<tr>
										<td style="vertical-align:middle;">이미지 등록</td>	
										<td>
											<div class="row">
												<c:forEach var="bf" items="${boardFileList}">
													<input hidden="" id="boardFileId" value="${bf.boardFileId}">
													<img src="static/img/board/${bf.boardFileName}" width="300"
														height="300" alt=""> &nbsp;
														<a
														href="${pageContext.request.contextPath}/removeBoardFile?boardFileId=${bf.boardFileId}&boardId=${bf.boardId}">삭제</a>
												</c:forEach>
											</div>
											<div style="display: inline;">
												<label for="imgFileUpload"> <img
													src="${pageContext.request.contextPath}/static/img/imgUpload.png" />
												</label> <span id="target"></span> <input id="imgFileUpload"
													name="boardFile" type="file" style="display: none;"
													accept="image/*" onchange="setThumbnail(event);"
													multiple="multiple" class="imgCheck" />
												<div id="image_container" style="display: inline;"></div>
												<!-- 업로드 된 이미지 미리보기 생성 -->
											</div>
										</td>	
									</tr>
								</table>
								<br>
								<div style="float:right;">
									<a href="${pageContext.request.contextPath}/member/getBoardOne?boardId=${boardMap.boardId}"><button type="button" class="genric-btn primary-border radius">취소</button></a>
									<input id="modifyBtn" type="button" value="등록" class="genric-btn primary-border radius">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
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

   	function setThumbnail(event){ 
   		  		
   		for (var image of event.target.files) {
   			
   			var reader = new FileReader(); 
   			
   			reader.onload = function(event) {
   				var img = document.createElement("img"); 
   				img.setAttribute("src", event.target.result);
   				img.setAttribute("width", 203);
   				img.setAttribute("height", 203);
   				img.setAttribute("style", "margin-right: 4.5px; border: 1px solid rgb(220, 219, 228);");
   				document.querySelector("div#image_container").appendChild(img); 
   			};
   			
   			console.log(image); 
   			reader.readAsDataURL(image); 
   		}
   		
   		$('#target').prepend('<input id="imgFileUpload" name="boardFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple"/>');
   	
   	
   	} 
</script>

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