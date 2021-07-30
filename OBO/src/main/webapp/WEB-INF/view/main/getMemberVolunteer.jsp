<!-- 작성자: 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원봉사내역</title>
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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<header>
		<div class="header-area ">
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
					<h3>봉사내역</h3>
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
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<p style="text-align: right;">회원님의 총 봉사 시간은 <b id="totalTarget"></b> 입니다.</p>
							<h3>총 봉사내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>봉사시간</th>
									</tr>
								</thead>
								<tbody id="fullTarget">
								</tbody>							
							</table>
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="fullPaging">
										
										
									</ul>
								</nav>
							</div>
							
						</div>
					</div>
				</div>
				
				<!-- 달력 들어갈 것 -->
				<div class="col-lg-3">
						<div class="service_content text-center">
							<h5 id="thisMonth"></h5>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사내용</th>
									</tr>
								</thead>
								<tbody id="calTarget">
								</tbody>
								<tbody id="calTargetP">
								</tbody>
							</table>
						</div>
				</div>
				
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>일반봉사 신청내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>신청취소</th>
									</tr>
								</thead>
								<tbody id="nTarget">
								
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="nPaging">
										
										
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 정기봉사 내역 -->
				<div class="col-lg-9 mb-5 mb-lg-0 offset-3">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>정기봉사 진행내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>날짜</th>
										<th>보호소</th>
										<th>봉사종류</th>
										<th>신청취소</th>
									</tr>
								</thead>
								<tbody id="pTarget">
								
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="pPaging">
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

		let fullCurrentPage = 1;//총 봉사내역 페이지
		let pCurrentPage = 1;//정기 봉사내역 페이지
		let nCurrentPage = 1;//일반 봉사내역 페이지
		
		var now = new Date();// 현재 날짜 및 시간
		var year = now.getFullYear();
		var month = now.getMonth()+1; //이번달
		var last = new Date(year, month, 0).getDate();
		console.log("========마지막날?"+last);
		
		$('#thisMonth').text(year+'년'+month+'월 봉사 일정');
		
		//기본 총 봉사 시간
		$('#totalTarget').text('0시간');
		
		//총 봉사 시간
		$.ajax({
			type: 'get',
			url: '<c:url value='/member/getTotalVolunteerTime' />'
		}).done(function (jsonData){
			console.log(jsonData);
			$('#totalTarget').text(jsonData +'시간');

		});
		
		//총 봉사내역 ajax로 값 불러 와서 테이블을 만드는 함수 호출
		function fullVolunteer(page){
			$.ajax({
				type:'post',
				url: '<c:url value='/member/getFullVolunteer' />',
				data: {'currentPage':page},
				success: function (jsonData){
				console.log(jsonData);
				prePage = page-1;
				nextPage = page+1;
				
				$('#fullTarget').empty();
				$('#fullPaging').empty();
				
				$.each(jsonData.list, function(index, data){
					console.log(data);
					$('#fullTarget').append('<tr>');
					$('#fullTarget').append('<td>'+data.volunteerDate+'</td>');
					$('#fullTarget').append('<td>'+data.shelterName+'</td>');
					$('#fullTarget').append('<td>'+data.categoryName+'</td>');
					$('#fullTarget').append('<td>'+data.volunteerTime+'</td>');
					$('#fullTarget').append('</tr>');
				});
				
					//이전
					if(prePage > 0){
						$('#fullPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveFullVolunteer(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(-1)">'+prePage+'</button></li>');
					};
					
					//현재
					$('#fullPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(1)">'+nextPage+'</button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullVolunteer(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			})
		}
		//일반 봉사내역
		function nVolunteer(page){
			$.ajax({
				type:'post',
				url: '<c:url value='/member/getVolunteerApplyList' />',
				data: {'currentPage':page},
				success: function (jsonData){
				console.log(jsonData);
				prePage = page-1;
				nextPage = page+1;
				
				$('#nTarget').empty();
				$('#nPaging').empty();
				
				$.each(jsonData.list, function(index, data){
					console.log(data);
					$('#nTarget').append('<tr>');
					$('#nTarget').append('<td>'+data.volunteerDate+'</td>');
					$('#nTarget').append('<td>'+data.shelterName+'</td>');
					$('#nTarget').append('<td>'+data.categoryName+'</td>');
					$('#nTarget').append('<td> <a type="button" onclick="deleteVolunteer('+data.applyId+')"><i class="fa fa-ban" style="color:black"></i></a></td>');
					$('#nTarget').append('</tr>');
				});
				
					//이전
					if(prePage > 0){
						$('#nPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveNVolunteer(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#nPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveNVolunteer(-1)">'+prePage+'</button></li>');
					};
					
					//현재
					$('#nPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#nPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveNVolunteer(1)">'+nextPage+'</button></li>');
						$('#nPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveNVolunteer(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			})
		}
		//정기 봉사내역
		function pVolunteer(page){
			$.ajax({
				type:'post',
				url: '<c:url value='/member/getVolunteerPList'/>',
				data: {'currentPage':page},
				success: function (jsonData){
				console.log(jsonData);
				console.log("정기봉사페이지"+page);
				
				prePage = page-1;
				nextPage = page+1;
				
				$('#pTarget').empty();
				$('#pPaging').empty();
				
				$.each(jsonData.list, function(index, data){
					console.log(data);
					if(data.state=='신청'){
						$('#pTarget').append('<tr>');
						$('#pTarget').append('<td><strong> 신청중 </strong></td>');
						$('#pTarget').append('<td>'+data.shelterName+'</td>');
						$('#pTarget').append('<td>'+data.categoryName+'</td>');
						$('#pTarget').append('<td> <a type="button" onclick="deleteVolunteerP('+data.applyId+')"><i class="fa fa-ban" style="color:black"></i></a></td>');
						$('#pTarget').append('</tr>');
					} else {
						$('#pTarget').append('<tr>');
						$('#pTarget').append('<td>'+data.volunteerDate+'</td>');
						$('#pTarget').append('<td>'+data.shelterName+'</td>');
						$('#pTarget').append('<td>'+data.categoryName+'</td>');
						$('#pTarget').append('<td> - </td>');
						$('#pTarget').append('</tr>');
					}
				});
				
					//이전
					if(prePage > 0){
						$('#pPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="movePVolunteer(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#pPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="movePVolunteer(-1)">'+prePage+'</button></li>');
					};
					
					//현재
					$('#pPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#pPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="movePVolunteer(1)">'+nextPage+'</button></li>');
						$('#pPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="movePVolunteer(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			})
		}
		function volunteerNCal(){
			$.ajax({
				type:'post',
				url: '<c:url value='/member/getVolunteerCal'/>',
				success: function (jsonData){
				console.log(jsonData);

				$('#calTarget').empty();
				
				$.each(jsonData, function(index, data){
					console.log(data);
					$('#calTarget').append('<tr>');
					$('#calTarget').append('<td>'+data.dd+'</td>');
					$('#calTarget').append('<td>'+data.shelterName+'</td>');
					$('#calTarget').append('<td>'+data.categoryName+'</td>');
					$('#calTarget').append('</tr>');
				})
				}
			})
		}
		function volunteerPCal(){
			$.ajax({
				type:'post',
				url: '<c:url value='/member/getVolunteerPCal'/>',
				success: function (jsonData){
				console.log(jsonData);

				$('#calTargetP').empty();
				
				$.each(jsonData, function(index, data){
					console.log(data);
					let pDate = new Date(data.startDate);
					console.log("========정기날짜"+pDate);
						if(data.yyyy==year && data.mm==month && data.dd>=now.getDate()){
							$('#calTargetP').append('<tr>');
							$('#calTargetP').append('<td>'+data.dd+'</td>');
							$('#calTargetP').append('<td>'+data.shelterName+'</td>');
							$('#calTargetP').append('<td>'+data.categoryName+'</td>');
							$('#calTargetP').append('</tr>');
						} else {
							while(pDate.getMonth()==thisMonth){
								pDate.setDate(pDate.getDate()+7);
								console.log("========정기날짜 추가된거!"+pDate);
								$('#calTargetP').append('<tr>');
								$('#calTargetP').append('<td>'+pDate+'</td>');
								$('#calTargetP').append('<td>'+data.shelterName+'</td>');
								$('#calTargetP').append('<td>'+data.categoryName+'</td>');
								$('#calTargetP').append('</tr>');
							}
						}
					})	
				}
			})
		}
		
		//함수 실행
		fullVolunteer(fullCurrentPage);
		nVolunteer(nCurrentPage);
		pVolunteer(pCurrentPage);
		volunteerNCal();
		volunteerPCal();
		
		//페이징 함수 실행
		function moveFullVolunteer(num){
			fullCurrentPage = fullCurrentPage+num;
			fullVolunteer(fullCurrentPage);
		}
		function moveNVolunteer(num){
			nCurrentPage = nCurrentPage+num;
			nVolunteer(nCurrentPage);
		}
		function movePVolunteer(num){
			pCurrentPage = pCurrentPage+num;
			pVolunteer(pCurrentPage);
		}
		
		//봉사 취소 함수
		function deleteVolunteer(num){
			var ck = confirm('취소 하시겠습니까?');
			if(ck==true){
				$.ajax({
					type:'post',
					url: '<c:url value='/member/removeVolunteer'/>',
					data: {'applyId':num},
					success: function (jsonData){
					console.log(jsonData);
					location.reload();
					}
				})
			} else {
				return;
			}
		}
		//정기 봉사 취소 함수
		function deleteVolunteerP(num){
			var ck = confirm('취소 하시겠습니까?');
			if(ck==true){
				$.ajax({
					type:'post',
					url: '<c:url value='/member/removeVolunteerP'/>',
					data: {'applyId':num},
					success: function (jsonData){
					console.log(jsonData);
					location.reload();
					}
				})
			} else {
				return;
			}
		}
		
		
	</script>
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