<!-- 작성자 : 김선유 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">

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
	function addBoardLike(boardId){
		$.ajax({
			type:'get',
			url: '${pageContext.request.contextPath}/getBoardLikeByMember',
			data: {'boardId':boardId}
		}).done(function (jsonData){
			console.log(boardId);
			console.log(jsonData);
			if(jsonData==0){
				window.location.href='${pageContext.request.contextPath}/addBoardLike?boardId='+boardId;
			} else {
				alert('이미 좋아요한 게시판입니다.');
			}
		});
	};

	$(document).ready(function(){
		$('#btn').click(function(){
			 console.log("btn click!");
			 
			 if($('#boardCommentContent').val() == ''){
				 alert('댓글을 입력해주세요.')
				 $('#boardCommentContent').focus();
			 } else{
				 $('#commentForm').submit();
			 }
		});
		
		$('#removeBoardClick').click(function() {
			console.log('삭제 확인');
			$('#ckBtn').click(function(){
				console.log('삭제 확인')
				$.ajax({
					url: '${pageContext.request.contextPath}/member/removeBoard?boardId=${boardMap.boardId}',
					type: 'post',
					success: function(jsonData){
						if(jsonData != 1) {
							alert('삭제 실패');
							return;
						}
						location.href='${pageContext.request.contextPath}/getBoardList';
					}				
				});
			});
		});
		
		$('#removeBoardCommentClick').click(function() {
			console.log('댓글 삭제 확인')
			let comment = $("#boardCommentId").val(); 
			$('#ckBtn2').click(function() {
				console.log('삭제 확인')
				$.ajax({
					url: '${pageContext.request.contextPath}/member/removeBoardComment',
					data: {'boardCommentId':comment},
					type: 'post',
					success: function(jsonData) {
						if(jsonData != 1) {
							alert('삭제 실패');
							return;
						}
						location.href='${pageContext.request.contextPath}/getBoardOne?boardId=${boardMap.boardId}';
					}
				});
			});			
		});
	});		
</script>
<meta charset="UTF-8">
<title>getBoardOne</title>
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

	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 posts-list">
					<div class="single-post">
						<div class="feature-img">
							사진위치
							<img class="img-fluid" src="img/blog/#" alt="">
						</div>
						<div class="blog_details">
							<h2>글제목${boardMap.boardTitle}</h2>
							<ul class="blog-info-link mt-3 mb-4">
								<li><i class="fa fa-user"></i> 작성자${boardMap.memberId}</li>
								<li><a href="#" onclick="clickFunc();"><span id="like"><i class="fa fa-heart-o"></i></span></a></li>
							</ul>
							<p>글내용 하... 자유게시판 새로 뜯어 고치는 중 <br>
							${boardMap.boardContent}</p>
						</div>
					</div>
					<div class="navigation-top">
						<div class="d-sm-flex justify-content-between text-center">
							<p class="like-info">
								<span class="align-middle"><i class="fa fa-heart"></i></span>
							</p>
							<div class="col-sm-4 text-center my-2 my-sm-0">
								<!-- <p class="comment-count"><span class="align-middle"><i class="fa fa-comment"></i></span> 06 Comments</p> -->
							</div>
						</div>
						<div class="navigation-area">
							<div class="row">
								<div
									class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
									<div class="thumb">
										<a href="#"> <img class="img-fluid" src="img/post/preview.png" alt="">
										</a>
									</div>
									<div class="arrow">
										<a href="#"> <span class="lnr text-white ti-arrow-left"></span>
										</a>
									</div>
									<div class="detials">
										<p>이전글</p>
										<a href="#">
											<h4>Space The Final Frontier</h4>
										</a>
									</div>
								</div>
								<div
									class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
									<div class="detials">
										<p>다음글</p>
										<a href="#">
											<h4>Telescopes 101</h4>
										</a>
									</div>
									<div class="arrow">
										<a href="#"> <span class="lnr text-white ti-arrow-right"></span>
										</a>
									</div>
									<div class="thumb">
										<a href="#"> <img class="img-fluid"
											src="img/post/next.png" alt="">
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="comments-area">
						<h4>05 Comments</h4>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="img/comment/comment_1.png" alt="">
									</div>
									<div class="desc">
										<p class="comment">Multiply sea night grass fourth day sea
											lesser rule open subdue female fill which them Blessed, give
											fill lesser bearing multiply sea night grass fourth day sea
											lesser</p>
										<div class="d-flex justify-content-between">
											<div class="d-flex align-items-center">
												<h5>
													<a href="#">Emilly Blunt</a>
												</h5>
												<p class="date">December 4, 2017 at 3:12 pm</p>
											</div>
											<div class="reply-btn">
												<a href="#" class="btn-reply text-uppercase">reply</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="img/comment/comment_2.png" alt="">
									</div>
									<div class="desc">
										<p class="comment">Multiply sea night grass fourth day sea
											lesser rule open subdue female fill which them Blessed, give
											fill lesser bearing multiply sea night grass fourth day sea
											lesser</p>
										<div class="d-flex justify-content-between">
											<div class="d-flex align-items-center">
												<h5>
													<a href="#">Emilly Blunt</a>
												</h5>
												<p class="date">December 4, 2017 at 3:12 pm</p>
											</div>
											<div class="reply-btn">
												<a href="#" class="btn-reply text-uppercase">reply</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="thumb">
										<img src="img/comment/comment_3.png" alt="">
									</div>
									<div class="desc">
										<p class="comment">Multiply sea night grass fourth day sea
											lesser rule open subdue female fill which them Blessed, give
											fill lesser bearing multiply sea night grass fourth day sea
											lesser</p>
										<div class="d-flex justify-content-between">
											<div class="d-flex align-items-center">
												<h5>
													<a href="#">Emilly Blunt</a>
												</h5>
												<p class="date">December 4, 2017 at 3:12 pm</p>
											</div>
											<div class="reply-btn">
												<a href="#" class="btn-reply text-uppercase">reply</a>
											</div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="comment-form">
						<h4>Leave a Reply</h4>
						<form class="form-contact comment_form" action="#"
							id="commentForm">
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<textarea class="form-control w-100" name="comment"
											id="comment" cols="30" rows="9" placeholder="Write Comment"></textarea>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<input class="form-control" name="name" id="name" type="text"
											placeholder="Name">
									</div>
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<input class="form-control" name="email" id="email"
											type="email" placeholder="Email">
									</div>
								</div>
								<div class="col-12">
									<div class="form-group">
										<input class="form-control" name="website" id="website"
											type="text" placeholder="Website">
									</div>
								</div>
							</div>
							<div class="form-group">
								<button type="submit"
									class="button button-contactForm btn_1 boxed-btn">Send
									Message</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================ Blog Area end =================-->


	<div class="section-top-border container">
		<h3 class="mb-30">${boardMap.boardTitle}</h3>
		<div class="text-right">
		<a href="${pageContext.request.contextPath}/getBoardList">게시판으로</a>
		<a href="${pageContext.request.contextPath}/modifyBoard?boardId=${boardMap.boardId}">수정</a>
		<a href="${pageContext.request.contextPath}/removeBoard"
					id="removeBoardClick" data-toggle="modal" data-target="#login-modal">삭제</a>
		</div>
		<div class="text-right">
			<a class="btn" data-parameter1="${boardMap.boardId}"
	               		onclick="addBoardLike(this.getAttribute('data-parameter1'))">
	               		<i class="fa fa-heart" style="size:9x"></i></a>
		</div>
		<div class="testmonial_area">
			<div class="row">
				<c:forEach var="bf" items="${boardFileList}">
							<img src="static/img/board/${bf.boardFileName}" width="300" height="300" alt=""> &nbsp;&nbsp;&nbsp;
				</c:forEach>
			</div>
		</div>
		<br>
		<div class="col-md-12 mt-sm-10">
			<div class="row align-items-center">
				<table class="table">
					<tr>
						<td>No.</td>
						<td><div id="boardId">${boardMap.boardId}</div></td>
					</tr>
					<tr>
						<td>게시판 카테고리</td>
						<td>${boardMap.boardCN}</td>
					</tr>
					<tr>
						<td>작성 날짜</td>
						<td>${boardMap.createDate}</td>
					</tr>
					<tr>
						<td>업데이트 날짜</td>
						<td>${boardMap.updateDate}</td>
					</tr>
				</table>
			</div>
		</div>
		<section class="blog_area single-post-area section-padding">
			<div class="container">
				<div class="row">
            		<div class="col-lg-8 posts-list">
				<div class="comments-area">
					<h4>댓글</h4>
					<c:forEach var="b" items="${boardCommentList}">
						<div class="comment-list">
							<div class="single-comment justify-content-between d-flex">
								<div class="user justify-content-between d-flex">
									<div class="desc">
										<input type="hidden" id="boardCommentId" value="${b.boardCommentId}">
										<p class="comment" >${b.boardCommentContent}</p>
										<div class="d-flex justify-content-between">
											<div class="d-flex align-items-center">
												<h5>${b.memberId}</h5>
												<p class="date">${b.createDate}</p>
														<a href="${pageContext.request.contextPath}/removeBoardComment"
															id="removeBoardCommentClick" data-toggle="modal"
															data-target="#login-modal2">삭제</a> 
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<form class="form-contact comment_form" action="${pageContext.request.contextPath}/member/addBoardComment" id="commentForm" method = "post">
						<input type="hidden" name="boardId" value="${boardMap.boardId}">
						<div class="row">
							<div class="col-12">
								<div class="form-group">
									 <textarea class="form-control w-100" name="boardCommentContent" id="boardCommentContent" cols="30" rows="2" placeholder="댓글을 작성해주세요"></textarea>
								</div>
							</div>
							<div class="form-group">
								<button id="btn" type="button" class="genric-btn primary-border radius small">등록</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</section>
	
	</div>
		<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">게시판을 삭제 하시겠습니까?</h5>
					<button id="ckBtn" type="button" class="btn btn-primary">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
			<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="login-modal2" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">댓글을 삭제 하시겠습니까?</h5>
					<button id="ckBtn2" type="button" class="btn btn-primary">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->

	<script>
	function clickFunc(){
		console.log('좋아요클릭');
		$('#like').html('<i class="fa fa-heart"></i>');
		
	}
	</script>

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

</body>
</html>
