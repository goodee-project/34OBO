<!-- 작성자: 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 동물</title>
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
				<div class="col-lg-12 text-center">
					<h3>관심 동물</h3>
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
					<div class="row">
						<c:forEach var="al" items="${animalList}">
						<div class="col-xl-3 col-lg-3 card align-items-center" style="margin:30px">
						<a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&shelterId=${al.shelterId}">
							<img class="card-img-top" src="${pageContext.request.contextPath}/static/img/animal/${al.animalFileName}" alt=""></a>
							<div class="card-body">
							    <h4 class="card-title text-center">${al.animalName}</h4>
							    <p class="card-text"><a href="${pageContext.request.contextPath}/getShelterOne?shelterId=${al.shelterId}">
							    	<i class="fa fa-home"></i> ${al.shelterName}</a></p>
							    <a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&shelterId=${al.shelterId}">
							    보러 가기 <i class="fa fa-arrow-right"></i></a>
							  </div>
						</div>
						</c:forEach>
					</div>
		        	<!-- 페이징 -->
		        	<div class="blog_left_sidebar">
					<nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
						<!-- 이전 페이지 -->
						<c:if test="${currentPage-1 >0}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getMemberAnimalLike?currentPage=${currentPage-1}" 
							class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
							</a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getMemberAnimalLike?currentPage=${currentPage-1}" 
							class="page-link">${currentPage-1}
							</a></li>
						</c:if>
						<c:if test="${currentPage-1 <= 0}">
						</c:if>
						<!-- /이전 페이지 -->
						<!-- 현재 페이지 -->
							<li class="page-item active"><a href="${pageContext.request.contextPath}/getMemberAnimalLike?currentPage=${currentPage}" 
							class="page-link">${currentPage}
							</a></li>
						<!-- /현재 페이지 -->
						<!-- 다음 페이지 -->
						<c:if test="${currentPage+1 <= lastPage}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/getMemberAnimalLike?currentPage=${currentPage+1}" 
							class="page-link" aria-label="Next"> ${currentPage+1}
							</a></li>
							<li class="page-item"><a href="${pageContext.request.contextPath}/getMemberAnimalLike?currentPage=${currentPage+1}" 
							class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
							</a></li>
						</c:if>
						<!-- /다음 페이지 -->
						</ul>
					</nav>
					<hr>
					<!-- /페이징 -->
				</div>

			</div>
				
			</div>
			
		</div>
	</section>
	
	
	
	<script>

		let fullCurrentPage = 1;//총 후원내역 페이지
		let perCurrentPage = 1;//정기후원 페이지
		let iCurrentPage = 1;//물품후원 페이지
		
		$('#totalTarget').text('0시간');
		
		//총 후원금액
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getTotalVolunteerTime'
		}).done(function (jsonData){
			console.log(jsonData);
			$('#totalTarget').text(jsonData +'시간');

		});
		
		//총 봉사내역
		function fullVolunteer(page){
			$.ajax({
				type:'get',
				url: '${pageContext.request.contextPath}/member/getFullVolunteer',
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
		
		fullVolunteer(fullCurrentPage);
		
		function moveFullVolunteer(num){
			fullCurentPage = fullCurrentPage+num;
			fullVolunteer(fullCurentPage);
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