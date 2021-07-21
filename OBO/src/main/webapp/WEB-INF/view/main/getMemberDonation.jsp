<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원후원내역</title>
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
					<h3>후원내역</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>
				
				
				
				<div class="col-lg-9 mb-5 mb-lg-0"  >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<p style="text-align: right;">회원님께서 총 기부하신 금액은 <b id="totalTarget"></b> 입니다.</p>
							<h3>총 후원내역</h3>
							<table class="table">
								<thead>
									<tr>
										<th>보호소</th>
										<th>후원금</th>
										<th>후원날짜</th>
										<th>종류</th>
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
				
				<div class="col-lg-8 mb-5 mb-lg-0">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>정기후원</h3>
							<table class="table">
								<thead>
									<tr>
										<th>보호소</th>
										<th>후원금</th>
										<th>신청날짜</th>
										<th>취소날짜</th>
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
				
				<!-- 물품후원 내역 -->
				<div class="col-lg-9 mb-5 mb-lg-0">
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content text-center">
							<h3>물품후원</h3>
							<table class="table">
								<thead>
									<tr>
										<th>보호소</th>
										<th>물품종류</th>
										<th>물품이름</th>
										<th>수량</th>
										<th>후원날짜</th>
									</tr>
								</thead>
								<tbody id="iTarget">
								
								</tbody>
							</table>
							
							<!-- 페이징 -->
							<div class="blog_left_sidebar">
								<nav class="blog-pagination justify-content-center d-flex">
									<ul class="pagination" id="iPaging">
										
										
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
			<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">일반물품 상세보기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
	        <table class="table">
	         	<tr>
	         		<th>보호소</th>
	  				<td id="sherlterTarget"></td>
	         	</tr>
	         	<tr>
	         		<th>물품이름</th>
	  				<td id="nameTarget"></td>
	         	</tr>
	         	<tr>
	         		<th>물품카테고리</th>
	  				<td id="categoryTarget"></td>
	         	</tr>
	         	<tr>
	         		<th>수량</th>
	  				<td id="quantitiyTarget"></td>
	         	</tr>
	         	<tr>
	         		<th>물품설명</th>
	  				<td id="descriptionTarget"></td>
	         	</tr>
	         	<tr>
	         		<th>후원날짜</th>
	  				<td id="dateTarget"></td>
	         	</tr>
	        </table>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
			
			
			
		</div>
	</section>
	
	
	
	<script>
		
		
		//총 후원내역
		function fullDonationList(page){
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getFullDonation',
				data: {'currentPage': page},
				success: function(jsonData){
				
					prePage = page-1;
					nextPage = page+1;
					
					$('#fullTarget').empty();
					$('#fullPaging').empty();
					
					$.each(jsonData.list, function(index, data) {
						$('#fullTarget').append('<tr>');
						$('#fullTarget').append('<td>'+data.shelterName+'</td>');
						$('#fullTarget').append('<td>'+(data.amount).toLocaleString('ko-KR')+'</td>');
						$('#fullTarget').append('<td>'+data.donationDate+'</td>');
						$('#fullTarget').append('<td>'+data.kind+'</td>');
						$('#fullTarget').append('</tr>');
				
					});

					
					//페이징
					//이전
					if(prePage > 0){
						$('#fullPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveFullDonation(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullDonation(-1)">'+prePage+'</button></li>');
					}
					
					//현재
					$('#fullPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullDonation(1)">'+nextPage+'</button></li>');
						$('#fullPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveFullDonation(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			
			})
		}
		
		//물품내역
		function iDonationList(page){
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getDonationItemByMemberId',
				data: {'currentPage': page},
				success: function(jsonData){
					prePage = page-1;
					nextPage = page+1;
					
					$('#iTarget').empty();
					$('#iPaging').empty();
					
					
					$.each(jsonData.list, function(index, data) {
						console.log((data.itemName).length);
						console.log(data.itemName.substring());
						$('#iTarget').append('<tr>');
						$('#iTarget').append('<td>'+data.shelterName+'</td>');
						$('#iTarget').append('<td>'+data.itemCategoryName+'</td>');
						if((data.itemName).length > 7){
							$('#iTarget').append('<td><a href="javascript:void(0);" onclick="donationItemOne('+data.donationItemListId+');" data-toggle="modal" data-target="#myModal">'+data.itemName.substring(0,7)+'...</a></td>');
						} else {
							$('#iTarget').append('<td><a href="javascript:void(0);" onclick="donationItemOne('+data.donationItemListId+');"  data-toggle="modal" data-target="#myModal">'+data.itemName+'</a></td>');
						}			
						//$('#iTarget').append('<td>'+data.itemName+'</td>');
						$('#iTarget').append('<td>'+data.itemQuantity+'</td>');
						$('#iTarget').append('<td>'+data.donationDate+'</td>');
						$('#iTarget').append('</tr>');
				
					});
					
					//페이징
					
					//이전
					if(prePage > 0){
						$('#iPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveIDonation(-1)"><i class="ti-angle-left"></i></button></li>');
						$('#iPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveIDonation(-1)">'+prePage+'</button></li>');
					}
					
					//현재
					$('#iPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
					
					//다음
					if(nextPage <= jsonData.lastPage){						
						$('#iPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveIDonation(1)">'+nextPage+'</button></li>');
						$('#iPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveIDonation(1)"><i class="ti-angle-right"></i></button></li>');
					}
				}
			})
		}
		
		//정기후원
		function pDonationList(pPage){
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getPeriodicallyDonationByMemberId',
				data: {'currentPage': pPage},
				success: function(result){
					
					pPrePage = pPage-1;
					pNextPage = pPage+1;
					
					$('#pTarget').empty();
					$('#pPaging').empty();

					
					$.each(result.list, function(index, table) {
						$('#pTarget').append('<tr>');
						$('#pTarget').append('<td>'+table.shelterName+'</td>');
						$('#pTarget').append('<td>'+(table.amount).toLocaleString('ko-KR')+'</td>');
						$('#pTarget').append('<td>'+table.applyDate+'</td>');
						
						if(table.endDate){
							$('#pTarget').append('<td>'+table.endDate+'</td>');
						} else {
							$('#pTarget').append('<td><button class="genric-btn default-border radius" onclick="cancelPDonation('+table.periodicallyDonationId +')">후원끊기</button></td>');				
							//$('#pTarget').append('<td><a href="endPeriodicallyDonation?periodicallyDonationId='+table.periodicallyDonationId+'">후원끊기</a></td>');				
						}
						
						$('#pTarget').append('</tr>');
						
					});
					

					//페이징
					//이전
					if(pPrePage > 0){
						$('#pPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="prePDonaiontList()"><i class="ti-angle-left"></i></button></li>');
						$('#pPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="prePDonaiontList()">'+pPrePage+'</button></li>');
					}
					
					//현재
					$('#pPaging').append('<li class="page-item active"><button type="button" class="page-link">'+pPage+'</button></li>');
					
					//다음
					if(pNextPage <= result.lastPage){						
						$('#pPaging').append('<li class="page-item nemo"><button type="button" class="page-link" onclick="nextPDonationList()">'+pNextPage+'</button></li>');
						$('#pPaging').append('<li class="page-item nemo "><button type="button" class="page-link" onclick="nextPDonationList()"><i class="ti-angle-right"></i></button></li>');
					}
				}
				
			})
		}
		
		let fullCurrentPage = 1;//총 후원내역 페이지
		let perCurrentPage = 1;//정기후원 페이지
		let iCurrentPage = 1;//물품후원 페이지
		
		fullDonationList(fullCurrentPage);
		pDonationList(perCurrentPage);
		iDonationList(iCurrentPage);
		
		
		function moveFullDonation(no){
			fullCurrentPage = fullCurrentPage+no;
			fullDonationList(fullCurrentPage);
		}
		
		/*
			스택터졌다고 에러가 계속 난다.
		function pDonationList(no){
			perCurrentPage = perCurrentPage+no;
			pDonationList(perCurrentPage);
		}
		*/
		function prePDonaiontList(){
			perCurrentPage = perCurrentPage-1;
			pDonationList(perCurrentPage);
		}
		function nextPDonationList(){
			perCurrentPage = perCurrentPage+1;
			pDonationList(perCurrentPage);
			
		}
		
		function moveIDonation(no){
			iCurrentPage = iCurrentPage+no;
			iDonationList(iCurrentPage);
		}
		
		
		//정기결제 취소		
		function cancelPDonation(num){
			
			let checked =  confirm('정기결제를 그만하시겠습니까?');
			
			if(checked){
				window.location.href = '${pageContext.request.contextPath}/member/endPeriodicallyDonation?periodicallyDonationId='+num;
			}
		}
		
		//물품내역 상세보기
		function donationItemOne(num){
			
			$.ajax({
				type: 'post',
				url: '${pageContext.request.contextPath}/member/getDonationItemOne',
				data: {'donationItemListId': num}
			}).done(function (jsonData) {
		        $('#sherlterTarget').text(jsonData.shelterName);
		        $('#nameTarget').text(jsonData.itemName);
		        $('#categoryTarget').text(jsonData.itemCategoryName);
		        $('#descriptionTarget').text(jsonData.itemDescription);
		        $('#dateTarget').text(jsonData.donationDate);
		        $('#quantitiyTarget').text(jsonData.itemQuantity);
		        
		    });
			
		}
		
		$('#totalTarget').text('0원');
		
		//총 후원금액
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getTotalDonation'
		}).done(function (jsonData){
			//let str = String(jsonData); //숫자를 문자열로
			//console.log(typeof str);
			/*
				toLocaleString() 함수는 숫자를 로컬의 language format에 맞는 문자열로 변경해 줍니다.

				파라미터로 아무것도 전달되지 않으면 사용자 로컬 환경의 locale을 default로 사용합니다.
			*/
			
			let change = jsonData.toLocaleString('ko-KR');
			//console.log(change);
			totalDonation = change
			$('#totalTarget').text(change +'원');
			
		});
		
		
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