<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 작성자: 손영현 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OBO</title>

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
<style>
	.list_img {
    display: inline-block;
    width: 100%;
    height: 200px;
    overflow: hidden;
    object-fit: cover;
    border-radius: 5px;
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

	<!-- slider_area_start -->
	<div class="slider_area">
		<div class="single_slider slider_bg_1 d-flex align-items-center">
			<div class="container">
				<div class="row">
					<div class="col-lg-5 col-md-6">
						<div class="slider_text">
							<h3>
								We Care <br> <span>ALL OF ANIMALS</span>
							</h3>
							<p>
								유기동물 보호 입양 사이트 <br>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="dog_thumb d-none d-lg-block">
				<img src="${pageContext.request.contextPath}/static/img/banner/animal.png" alt="">
			</div>
		</div>
	</div>
	<!-- slider_area_end -->
	
    <!-- team_area_start  -->
    <div class="team_area" >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-10">
                    <div class="section_title text-center mb-95">
                    	<a href="${pageContext.request.contextPath}/getAnimalList">
	                        <h3>보호중인 동물들</h3>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
            	
            	<c:forEach items="${animalList}" var="al">
            		
	                <div class="col-lg-3 col-md-6">
	                	<a href="${pageContext.request.contextPath}/getAnimalOne?animalId=${al.animalId}&currentPage=1&searchWord=&species=&shelterId=${al.shelterId}">  
	                    <div class="single_team">
	                        <div class="thumb">
	                        	
	                            <img src="${pageContext.request.contextPath}/static/img/animal/${al.animalFileName}" class="rounded-circle list_img" alt=""">
	                        	
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
    
    
    <!-- 보호중 동물, 입양안락사 이번달  --> 
    <div class="adapt_area">
        <div class="container">
            <div class="row justify-content-between align-items-center">
                <div class="col-lg-5">
                    <div class="adapt_help">
                        <div class="section_title">
                            <h3><span>우리 아이들과</span>
                                <br>함께해주세요</h3>
                            <p>지금도 많은 많은 사람들이 동물을 유기하고 있습니다.</p>
                            <a href="${pageContext.request.contextPath}/getAnimalList" class="boxed-btn3">입양하러 가기</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="adapt_about">
                        <div class="row align-items-center">
                            <div class="col-lg-6 col-md-6">
                                <div class="single_adapt text-center">
                                    <img src="${pageContext.request.contextPath}/static/img/adapt_icon/1.png" alt="">
                                    <div class="adapt_content">
                                        <h3 class="counter">${protect}</h3>
                                        <p>보호중</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <div class="single_adapt text-center">
                                    <img src="${pageContext.request.contextPath}/static/img/adapt_icon/3.png" alt="">
                                    <div class="adapt_content">
                                        <h3><span class="counter">${adopt}</span>+</h3>
                                        <p>입양</p>
                                    </div>
                                </div>
                                <div class="single_adapt text-center">
                                    <img src="${pageContext.request.contextPath}/static/img/adapt_icon/2.png" alt="">
                                    <div class="adapt_content">
                                        <h3><span class="counter">${euthanasia}</span></h3>
                                        <p>안락사</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    	
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				
				<!--이번달 총 후원금-->		
				<div class="col-lg-6 mb-5 mb-lg-0" >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<a href="${pageContext.request.contextPath}/getDonation">
						<div class="single_service staff_account" style="height: 90%">
							<div class="service_content">					
								
								<h3>이번달 후원금</h3>
															
								<br>
								<h2 style="text-align: right;">
									총 <fmt:formatNumber value="${totalDonation}" pattern="#,###"/>원 입니다.
								</h2>
								<br>
								<br>
								<br>
								<br>
								<div class="pet_thumb">
			                         <canvas id="myChart2"></canvas>
			                    </div>
								
								
							</div>
						</div>
					</a>	
				</div>
				
				<div class="col-lg-6 mb-5 mb-lg-0" >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<a href="${pageContext.request.contextPath}/getAnimalList">
						<div class="single_service staff_account" style="height: 90%">
							<div class="service_content">					
								
								<h3>보호중인 동물종</h3>
															
								<br>
								<div class="pet_thumb">
			                         <canvas id="myChart"></canvas>
			                    </div>
								
							</div>
						</div>
					</a>	
				</div>
							
			</div>
		</div>
	</section>		
	
	<!-- 차트 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script>
		//보호중인 동물 종별로 통계하기...
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getAnimalSpeciesCount',
			type: 'get'
		}).done(function(jsonData){
			//console.log(jsonData);
			
			let species = jsonData.map(item => item.species);
			let cnt = jsonData.map(item => item.cnt);
			
			
			//console.log(species);
			//console.log(cnt);
			
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
		
		// 이번년도 달별로 후원금 꺾은선 그래프 그리기
		var now = new Date();	// 현재 날짜 및 시간
		var year = now.getFullYear();	// 연도
		console.log('연도 : ', year);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getFullDonationTotalByMonth',
			type: 'get',
			data: {year: year}
		}).done(function(jsonData){
			console.log(jsonData);
			
			let month = jsonData.map(item => item.month);
			let amount = jsonData.map(item => item.amount);
			
			console.log(month);
			console.log(amount);
			
			//const DATA_COUNT = 7;
			//const NUMBER_CFG = {count: DATA_COUNT, min: -100, max: 100};

			//const labels = ;
			const data = {
			  labels: month,
			  datasets: [
			    {
			      label: '월별 후원금',
			      data: amount,
			      borderColor: 'rgb(255, 153, 102)',
			      backgroundColor: 'rgb(255, 153, 102)',
			    }
			  ]
			};
			
			const config = {
					  type: 'line',
					  data: data,
					  options: {
					    responsive: true,
					    plugins: {
					      legend: {
					        position: 'top',
					      },
					      title: {
					        display: false,
					        text: '월별 후원금'
					      }
					    }
					  },
					};
			 var myChart = new Chart(
					    document.getElementById('myChart2'),
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