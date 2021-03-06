<!-- 작성자 : 김선유, 수정자: 손영현 -->
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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>getShelterOne</title>
<style>
  /* Make the image fully responsive */
  .carousel-inner img {
    width: 100%;
    height: 100%;
  }
  
  .list_img {
    display: inline-block;
    width: 100%;
    height: 200px;
    overflow: hidden;
    object-fit: cover;
    border-radius: 5px;
}
	th{
		width: 20%;
		text-align: center;
	}

  </style>

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
					<h3>보호소 상세보기</h3>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="section-top-border container">
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
						<th>주소</th>
						<td>${shelterMap.doro}</td>
					</tr>
					<tr>
						<th>설립일</th>
						<td>${shelterMap.createDate}</td>
					</tr>
					<tr>
						<th>소개글</th>
						<td>${shelterMap.introduction}</td>
					</tr>
					<tr>
						<th>보호기간</th>
						<td>${shelterMap.protectDuration}</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${shelterMap.shelterPhone}</td>
					</tr>
					<tr>
						<th>활동</th>
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
					<a href="${pageContext.request.contextPath}/getShelterList">보호소 리스트</a>
            </div>
		</div>
	</div>
	
	<!-- team_area_start  -->
    <div class="team_area" style="padding-bottom: 3%; padding-top: 3%;">
        <div class="container">
            <div class="row justify-content-center ">
                <div class="col-lg-6 col-md-10">
                    <div class="section_title text-center mb-95">
                        <h3>보호중인 동물들</h3>
                        <p></p>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
            	
            	<c:forEach items="${animalList}" var="al">
            		
	                <div class="col-lg-3 col-md-6">
	                	<a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&currentPage=1&searchWord=&species=&shelterId=${shelterMap.shelterId}">  
	                    <div class="single_team">
	                        <div class="thumb">
	                        	
	                            <img src="${pageContext.request.contextPath}/static/img/animal/${al.animalFileName}" class="rounded-circle list_img"  alt="">
	                        	
	                        </div>
	                        <div class="member_name text-center">
	                            <div class="mamber_inner">
	                                <h4>${al.animalName}</h4>
	                                <p>${al.animalKind}</p>
	                            </div>
	                        </div>
	                    </div>
	                    </a>
	                </div>
	                
	                
                </c:forEach>
                
            </div>
        </div>
    </div>
    <!-- team_area_start  -->
	
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
                            <a href="${pageContext.request.contextPath}/getAnimalList?shelterId=${shelterMap.shelterId}" class="boxed-btn3">입양하러 가기</a>
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
			const color = ['rgb(255, 99, 132)', 'rgb(54, 162, 235)', 'rgb(102, 204, 153)', 'rgb(255, 153, 102)', 'rgb(153, 153, 204)']

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