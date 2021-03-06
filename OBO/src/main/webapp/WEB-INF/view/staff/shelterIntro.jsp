<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shelterIntro</title>

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
<style>
  .carousel-inner img {
    width: 100%;
    height: 100%;
  }



</style>
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
					<h3>보호소 > 보호소 소개</h3>
				</div>
			</div>
		</div>
	</div>

	<div class="section-top-border container">
		<p>우리 보호소는</p>
		<h3 class="mb-30">${shelterMap.shelterName}</h3>
			<div class="testmonial_area">
				
				<div class="col-lg-7 mb-7 mb-lg-7" >
					
					<div id="demo" class="carousel slide" data-ride="carousel">

					  <!-- Indicators -->
					  <ul class="carousel-indicators">
					    <c:set var="i" value="0"></c:set>
					    <c:forEach items="${imgList}" var="il">
					    	<li data-target="#demo" data-slide-to="0" class="${i==0? 'active' : '' }"></li>
					    	 <c:set var="i" value="${i + 1}"/>
					    </c:forEach>
					  </ul>
					  
					  <!-- The slideshow -->
					  <div class="carousel-inner">
					    
					   
					   	<c:set var="i" value="0"></c:set>
					    <c:forEach items="${imgList}" var="il">
					    	<div class="carousel-item ${i==0? 'active' : '' }">
						      <img src="${pageContext.request.contextPath}/static/img/shelter/${il.shelterFileName}" class="rounded" style="height: 400px;">
						    </div>
					    	 <c:set var="i" value="${i + 1}"/>
					    </c:forEach>
					  
					  
					  
					  </div>
					  
					  <!-- Left and right controls -->
					  <a class="carousel-control-prev" href="#demo" data-slide="prev">
					    <span class="carousel-control-prev-icon"></span>
					  </a>
					  <a class="carousel-control-next" href="#demo" data-slide="next">
					    <span class="carousel-control-next-icon"></span>
					  </a>
					</div>
				
				
				</div>			
					
			</div>
			<br>
			<div class="col-md-9 mt-sm-10">
				<div class="row align-items-center">
               <table class="table table-hover">
					<tr>
						<td>주소</td>
						<td>${shelterMap.doro}</td>
					</tr>
					<tr>
						<td>설립일</td>
						<td>${shelterMap.createDate}</td>
					</tr>
					<tr>
						<td>소개글</td>
						<td>${shelterMap.introduction}</td>
					</tr>
					<tr>
						<td>보호기간</td>
						<td>${shelterMap.protectDuration}</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>${shelterMap.shelterPhone}</td>
					</tr>
					<tr>
						<td>계좌</td>
						<td>${shelterMap.account}</td>
					</tr>
					<tr>
						<td>활동</td>
						<td>
							<c:if test="${shelterMap.active==1}">
								영업중
							</c:if>
							<c:if test="${shelterMap.active==0}">
								휴업중
							</c:if>
						</td>
					</tr>			                	
                </table>
				
            </div>
		</div>
	</div>
	
	
	
	<!-- 뭔가 여러가지 통계 넣기... -->	
	<!-- pet_care_area_start  -->
    <div class="pet_care_area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5 col-md-6">
                    <div class="pet_thumb">
                         <canvas id="myChart"></canvas>
                    </div>
                </div>
                <div class="col-lg-6 offset-lg-1 col-md-6">
                    <div class="pet_info">
                        <div class="section_title">
                            <h3><span>보호중인 동물</span> <br>
                                통계</h3>
                            <p> 보호중인 동물 수: ${protect}
                            	<br> 이번달 입양 : ${adopt}
                            	<br> 이번달 안락사 : ${euthanasia}
                            <p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- pet_care_area_end  -->
	
	
	
	<!-- 찾아오시는걸 -->
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
			
				<div class="col-lg-10 mb-10 mb-lg-0"  >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account">
						<div class="service_content text-center">
							<h3>찾아오는 길</h3>
							<div class="row">
								<div id="map" style="width:100%;height:300px;"></div>
								<br>
								<br>
								<div>
									도로명 주소 : <strong>${shelterMap.doro}</strong> 
								</div>
							</div>
									
						</div>
					</div>
				</div>
			
			</div>
		</div>
	</section>
	
	
	
	
	<!-- 카카오 지도 api -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2bb162c8a9e8239a272ea493b332a37f"></script>
	<script>
		let x = ${x};
		let y = ${y};
		
		console.log(x);
		console.log(y);
	
		//카카오 지도
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
		        level: 3, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 지도에 마커를 생성하고 표시한다
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(y, x), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});
		

	</script>
	
	<!-- 차트 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script>
		//보호중인 동물 종별로 통계하기...
		let i = 0;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getAnimalSpeciesCount',
			type: 'get',
			data: {shelterId: '${shelterMap.shelterId}'}
		}).done(function(jsonData){
			console.log(jsonData);
			
			let species = jsonData.map(item => item.species);
			let cnt = jsonData.map(item => item.cnt);
			
			
			console.log(species);
			console.log(cnt);
			
			//차트 그리기....
			/*
			const DATA_COUNT = 5;
			const NUMBER_CFG = {count: DATA_COUNT, min: 0, max: 100};
			*/
			const color = ['rgb(255, 99, 132)', 'rgb(54, 162, 235)', 'rgb(102, 204, 153)', 'rgb(255, 153, 102)', 'rgb(255, 153, 102)']

			const data = {
			  labels: species,
			  datasets: [
				 
			    {
			      label: species,
			      data: cnt,
			      backgroundColor: color,
			    }
			  ]
			};
			
			const config = {
					  type: 'doughnut',
					  data: data,
					  options: {
					    responsive: true,
					    plugins: {
					      legend: {
					        position: 'top',
					      },
					      title: {
					        display: true,
					        text: '보호중인 동물종'
					      }
					    }
					  },
					};
			
			 var myChart = new Chart(
					    document.getElementById('myChart'),
					    config
					  );
		})
	
	</script>
	
	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->
	
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