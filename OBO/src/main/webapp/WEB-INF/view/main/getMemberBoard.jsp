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
				
				
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<h3 class="text-center">내 작성글</h3>
							<!-- 자격승인목록 -->
							<table class="table">
								<thead id="thead">
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
	</section>
	
	
	
	
	
<script>
	let boardPage = 1;
	
	myBoardTable();
	
	
	
	function moveMyBoard(no){
		boardPage = boardPage+no;
		myBoardTbody(boardPage);
	}

	//내 작성글 목록 누르기....
	function myBoardTable(){
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
	
	//내 작성글 tbody
	function myBoardTbody(page){
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
				tbody += '<td>'+data.boardTitle+'</td>';
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
</script>
</body>
</html>