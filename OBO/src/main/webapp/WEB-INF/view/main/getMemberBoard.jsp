<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성글 내역</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
				<div class="col-lg-12 text-center">
					<h3>작성글</h3>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>
				
				<!-- Nav tabs -->
				<div  class="col-lg-9 mb-5 mb-lg-0">
					<ul class="nav nav-tabs">
					  <li class="nav-item">
					    <a class="nav-link active" href="javascript:void(0);" onclick="myBoardTbody(1)">내 작성글</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link" href="javascript:void(0);" onclick="myBoardLikeTbody(1)">관심글</a>
					  </li>
					</ul>
					
					
			  		<div>
						<div class="single-post">
							<div class="blog_details">
								<h3 id="target" class="text-center">내 작성글</h3>
								<!-- 자격승인목록 -->
								<table class="table text-center">
									<thead>
										<tr>
											<th>No.</th>
											<th>카테고리</th>
											<th>제목</th>
											<th>작성자</th>
											<th>등록일</th>											
										</tr>
									</thead>
									<tbody id="tbody">
									
									</tbody>
								</table>
								
								<!-- 페이징 -->
								<div class="blog_left_sidebar">
									<nav class="blog-pagination justify-content-center d-flex">
										<ul class="pagination" id="paging">
											
											
										</ul>
									</nav>
								</div>
								
							</div>
						</div>
					</div>
					
				</div>	
				
			</div>
		</div>
	</section>
	
	
	
	
	
<script>

	let boardPage = 1;
	let likePage = 1;
	
	myBoardTbody(boardPage)
	
	
	
	function moveMyBoard(no){
		boardPage = boardPage+no;
		myBoardTbody(boardPage);
	}
	
	function moveLikePage(no){
		likePage = likePage+no;
		myBoardLikeTbody(likePage);
	}
	
	/*
	//내 작성글 목록 누르기.... 필요업음 ㅠㅠㅠ
	function myBoardTable(){
		boardPage = 1;
		$('#thead').empty();
		let thead;
		thead += '<tr>';
		thead += '<th>No.</th>';
		thead += '<th>카테고리</th>';
		thead += '<th>제목</th>';
		thead += '<th>작성자</th>';
		thead += '<th>등록일</th>';
		thead += '</tr>';
		$('#thead').append(thead);
		
		myBoardTbody(boardPage);
	}
	*/
	
	//내 작성글 tbody
	function myBoardTbody(page){
		$('#target').text('내 작성글');
		
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/member/getBoardHistory',
			data: {'memberId': '${memberId}', 'currentPage': page}
		}).done(function(jsonData){
			
			prePage = page-1;
			nextPage = page+1;
			
			$('#tbody').empty();
			$('#paging').empty();
			
			
			//tbody 그리기
			let tbody;
			
			$.each(jsonData.boardList, function(index,data){
				console.log(data);
				tbody += '<tr>';
				tbody += '<td>'+data.boardId+'</td>';
				tbody += '<td>'+data.boardCategoryName+'</td>';
				tbody += '<td class="text-left"><a href="${pageContext.request.contextPath}/member/getBoardOne?boardId='+data.boardId+'">'+data.boardTitle+'</a></td>';
				tbody += '<td>'+data.memberId+'</td>';
				tbody += '<td>'+data.createDate+'</td>';
				tbody += '</tr>';
			})
			
			$('tbody').append(tbody);
			
			//페이징
			
			//이전
			if(prePage > 0){
				$('#paging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveMyBoard(-1)"><i class="ti-angle-left"></i></button></li>');
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveMyBoard(-1)">'+prePage+'</button></li>');
			}
			
			//현재
			$('#paging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
			
			//다음
			if(nextPage <= jsonData.lastPage){						
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveMyBoard(1)">'+nextPage+'</button></li>');
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveMyBoard(1)"><i class="ti-angle-right"></i></button></li>');
			}
			
		})
	}
	
	//내 좋아요 tbody
	function myBoardLikeTbody(page){
		$('#target').text('관심글');
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/member/getBoardLikeByMemberId',
			data: {'memberId': '${memberId}', 'currentPage': page}
		}).done(function(jsonData){
			//console.log(jsonData);
			
			prePage = page-1;
			nextPage = page+1;
			
			$('#tbody').empty();
			$('#paging').empty();
			
			
			//tbody 그리기
			let tbody;
			
			$.each(jsonData.likeList, function(index,data){
				console.log(data);
				tbody += '<tr>';
				tbody += '<td>'+data.boardId+'</td>';
				tbody += '<td>'+data.boardCategoryName+'</td>';
				tbody += '<td class="text-left"><a href="${pageContext.request.contextPath}/member/getBoardOne?boardId='+data.boardId+'">'+data.boardTitle+'</a></td>';
				tbody += '<td>'+data.memberId+'</td>';
				tbody += '<td>'+data.createDate+'</td>';
				tbody += '</tr>';
			})
			
			$('tbody').append(tbody);
			
			//페이징
			
			//이전
			if(prePage > 0){
				$('#paging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveLikePage(-1)"><i class="ti-angle-left"></i></button></li>');
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveLikePage(-1)">'+prePage+'</button></li>');
			}
			
			//현재
			$('#paging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
			
			//다음
			if(nextPage <= jsonData.lastPage){						
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveLikePage(1)">'+nextPage+'</button></li>');
				$('#paging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveLikePage(1)"><i class="ti-angle-right"></i></button></li>');
			}
			
		})
	}
</script>
</body>
</html>