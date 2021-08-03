<!-- 작성자 : 김선유 -->
<!-- 수정자 : 이윤정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>getBoardOne</title>

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
				$('#like').html('<i class="fa fa-heart"></i>');
			} else {
				alert('이미 좋아요한 게시판입니다.');
			}
		});
	};

	$(document).ready(function(){
		//좋아요 선택 되어있으면 $('#like').html('<i class="fa fa-heart"></i>'); -> 꽉찬 하트로
		let boardId = $('#getBoardId').val();
		console.log('boardId?->'+boardId);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getBoardLikeNow',
			data: {boardId : boardId},
			type: 'get',
			success: function(jsonData) {
				console.log('좋아요 확인!!!');
				if(jsonData == 0) {
					console.log('좋아요 안 눌렀음');
					return;
				}
				console.log('이미 좋아요한 게시글입니다.');
				$('#like').html('<i class="fa fa-heart"></i>');
				$('#likeCk').text('');
				//location.href='${pageContext.request.contextPath}/member/getBoardOne?boardId='+boardId;
			}
		});
		
	});		
</script>
<meta charset="UTF-8">
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
				<div class="col-lg-9 posts-list" style="float: none; margin:auto;">
					<!-- 목록 -->
					<div class="row">
						<div class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
						</div>
						<div class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
							<div class="detials">
								<p>
									<a href="${pageContext.request.contextPath}/getBoardList">목록</a>&emsp;
								</p>
							</div>
						</div>
					</div>
					
					<div class="single-post">
						<div class="blog_details">
							<h2>
								${boardMap.boardTitle} 
							</h2>
							<div class="row">
								<ul class="blog-info-link mt-3 mb-4">
									<li>&emsp;<i class="fa fa-user"></i> ${boardMap.memberId}</li>
									<c:if test="${loginMember.memberId == boardMap.memberId}">
										<li><a href="${pageContext.request.contextPath}/member/modifyBoard?boardId=${boardMap.boardId}">수정</a></li>
										<li><a href="javascript:void(0);" onclick="delBoardFunc();" data-toggle="modal" data-target="#login-modal">삭제</a></li>
									</c:if>
									<li><a href="javascript:void(0)" data-parameter1="${boardMap.boardId}" onclick="clickFunc(this.getAttribute('data-parameter1'));"><span id="like"><i class="fa fa-heart-o"></i></span></a><span id="likeCk">클릭!</span></li>
								</ul>
								<ul class="blog-info-link mt-3 mb-4" style="margin-left:auto;">
									<li>작성일 ${boardMap.createDate}</li>
									<li>최근 수정일 ${boardMap.updateDate}</li>
								</ul>
							</div>
							
							<!-- 사진 -->
							<div class="feature-img">
								<c:forEach var="bf" items="${boardFileList}">
									<img class="img-fluid" src="${pageContext.request.contextPath}/static/img/board/${bf.boardFileName}" width="300" height="300" alt="">
								</c:forEach>
							</div>
							<br>
							
							<!-- 글 내용 -->
							<p>${boardMap.boardContent}</p>
							<input type="hidden" id="getBoardId" name="boardId" value="${boardMap.boardId}">
						</div>
					</div>
					
					<!-- 댓글창 -->
					<div class="comments-area">
						<h5>댓글</h5>
						<br>
						<!-- 댓글 출력 -->
						<c:forEach var="b" items="${boardCommentList}">
							<div class="comment-list">
								<div class="single-comment justify-content-between d-flex">
									<div class="user justify-content-between d-flex">
										<div class="desc">
											<p class="comment">
												${b.boardCommentContent}
											</p>
											<div class="d-flex justify-content-between">
												<div class="d-flex align-items-center">
													<h5>${b.memberId}</h5>
													<p class="date">${b.createDate}</p>
												</div>
												<div class="reply-btn">
													<c:if test="${loginMember.memberId == b.memberId}">
														<a href="${pageContext.request.contextPath}/removeBoardComment" data-toggle="modal" data-target="#delComment-modal" data-parameter1="${b.boardCommentId}"
														 class="btn-reply text-uppercase" onclick="delCommentModal(this.getAttribute('data-parameter1'));">삭제</a>
													</c:if>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						
						<!-- 댓글 등록 -->
						<form id="commentForm" class="form-contact comment_form" action="${pageContext.request.contextPath}/member/addBoardComment" method="post">
							<input type="hidden" id="boardId" name="boardId" value="${boardMap.boardId}">
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<textarea class="form-control w-100" name="boardCommentContent" id="comment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
										<button type="submit" class="genric-btn primary-border radius" onclick="commentFunc()" style="float:right;">등록</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================ Blog Area end =================-->

	
	<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title" style="text-align:center;">게시글을 삭제 하시겠습니까?</h5>
					<hr>
					<br>
					<input type="hidden" id="delBoardId" name="boardId">
					<div style="float:right;">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger" onclick="delBoardFunc(document.getElementById('delBoardId').value);">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 댓글 삭제 모달 -->
	<div class="modal fade" id="delComment-modal" role="dialog" aria-labelledby="delComment-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title" style="text-align:center;">댓글을 삭제 하시겠습니까?</h5>
					<hr>
					<br>
					<input type="hidden" id="boardCommentId" name="boardCommentId">
					<div style="float:right;">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger" onclick="delCommentFunc(document.getElementById('boardCommentId').value);">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->

	<script>
	function clickFunc(id){
		console.log('좋아요 클릭');
		console.log('id='+id);
		let boardId = id;
		$.ajax({
			type:'get',
			url: '${pageContext.request.contextPath}/getBoardLikeNow',
			data: {boardId : boardId},
			success: function (jsonData){
				console.log('좋아요 클릭 후 ajax 불러오기!');
				
				if(jsonData==0){	// 좋아요 안 했음
					console.log('좋아요 안했음->하자!');
					
					// 좋아요 해주기
					$.ajax({
						type:'get',
						url: '${pageContext.request.contextPath}/addBoardLike',
						data: {boardId : boardId},
						success: function (jsonData){
							if(jsonData==0){	// 실패
								console.log('좋아요 안함->하기 실패');
								return;
							} 	
							// 좋아요 하기 성공
							console.log('좋아요 클릭 성공');
							$('#like').html('<i class="fa fa-heart"></i>');
							$('#likeCk').text('');
							
						}
					});
					
				} else {	// 좋아요 했음
					console.log('좋아요 했음->취소');
				
					// 좋아요 취소
					$.ajax({
						type:'get',
						url: '${pageContext.request.contextPath}/removeBoardLike',
						data: {boardId : boardId},
						success: function (jsonData){
							if(jsonData==0){	// 좋아요 취소 실패
								console.log('좋아요 했다가 취소 실패');
								return;
							}	
							// 좋아요 취소 성공
							console.log('좋아요 취소 성공');
							$('#like').html('<i class="fa fa-heart-o"></i>');
							$('#likeCk').text('클릭!');
						}
					});
				}
			}
		});
	}
	
	//게시글 삭제 모달
	function delBoardModal(){
		console.log('게시글 삭제 모달창!');
		let boardId = $('#getBoardId').val();
		$('#delBoardId').val(boardId);
		console.log('삭제할 id->'+boardId);
	}
	
	//게시판 삭제
	function delBoardFunc(){
		console.log('게시글 삭제 클릭');
		let boardId = $('#delBoardId').val();
		console.log('삭제할 id->'+boardId);
		$.ajax({
			url: '${pageContext.request.contextPath}/member/removeBoard',
			type: 'post',
			data: {boardId : boardId},
			success: function(jsonData){
				if(jsonData != 1) {
					alert('게시글 삭제 실패');
					return;
				}
				alert('게시글 삭제 완료');
				location.href='${pageContext.request.contextPath}/getBoardList';
			}				
		});
	}
	
	//댓글 등록
	function commentFunc(){
		console.log('댓글 등록 클릭');
		if($('#comment').val() == ''){
			 alert('댓글을 입력해주세요.')
			 $('#comment').focus();
		 } else{
			 $('#commentForm').submit();
		 }
	}
	
	//댓글 삭제 모달
	function delCommentModal(id){
		console.log('댓글 삭제 클릭!');
		console.log('삭제할 코멘트id->'+id);
		$('#boardCommentId').val(id);
		
	}

	//댓글 삭제
	function delCommentFunc(id){
		console.log('댓글 삭제 클릭!');
		console.log('삭제할 코멘트id->'+id);
		let boardId = $('#boardId').val();
		
		$.ajax({
			url: '${pageContext.request.contextPath}/member/removeBoardComment',
			data: {boardCommentId : id},
			type: 'post',
			success: function(jsonData) {
				if(jsonData != 1) {
					alert('댓글 삭제 실패');
					return;
				}
				alert('댓글 삭제 완료');
				location.href='${pageContext.request.contextPath}/member/getBoardOne?boardId='+boardId;
			}
		});
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
