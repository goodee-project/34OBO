<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getDonationStatsItem</title>

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
					<h3>후원 > 통계 > 물품</h3>
				</div>
			</div>
		</div>
	</div>
	
	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<jsp:include page="/WEB-INF/view/staff/inc/side/donationMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<h2>
								<a href="${pageContext.request.contextPath}/staff/getDonationStats"><i class="fa fa-home"></i></a> <a>|</a> 
								<a href="${pageContext.request.contextPath}/staff/getDonationStatsItem">물품</a> <a>|</a> 
								<a href="${pageContext.request.contextPath}/staff/getDonationStatsMoney">금액</a>
							</h2>
							
							<p>후원 받은 물품을 기간별로 조회할 수 있습니다.</p>
							
							<br>
							<!-- 검색 -->
							<form id="searchForm" action="${pageContext.request.contextPath}/staff/getDonationMoneyP" method="post">
								<div class="form-group col-xl-8 col-lg-6">
									<div class="input-group mb-4"> 
										<input type="month" id="startDate" name="startDate"> 
										&nbsp;~&nbsp;
										<input type="month" id="endDate" name="endDate"> 
										
										&nbsp;<button id="searchBtn" class="btn" type="button" onclick="searchFun();"><i class="fa fa-search"></i></button>
										&nbsp;<button class="btn" type="reset"><i class="fa fa-refresh"></i></button>
									</div>
								</div>
							</form>
							<br>
							
							<!-- 카테고리별 차트 -->
							<div>
								<canvas id="myChart" width="700" height="700"></canvas>
								 <div id='legend-div' class="legend-div"></div>
							</div>
							<br><br>
							
							<div id="input">
							</div>
							<br>
							
							<!-- 카테고리별 테이블 -->
							<table id="itemTable" class="table" style="width:80%; text-align:center;">
								<thead id="itemThead">
								</thead>
								<tbody id="itemTbody">
								</tbody>
							</table>
							
						</div>
					</div>

					<!-- 페이징, 검색 없음 -->
				</div>

			</div>
		</div>
	</section>
	<!--================Blog Area =================-->	
	
	
	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->	
	
	<script>
	let startDate, endDate;	//검색 시작-종료일
	let addThead, addTbody, addSelect;	//동적 테이블&셀렉트박스 추가할 때 사용
	let myChart;	//차트 그릴 때
	let labels = [];	//차트 그릴 때
	let datas = [];		//차트 그릴 때
	
	
	function searchFun(){
		console.log('조회버튼 클릭!!!!!!!');
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();
		
		if($('#startDate').val() == ''){
			alert('시작 년/월을 선택해주세요.');
			return;
		} 
		if($('#endDate').val() == ''){
			alert('종료 년/월을 선택해주세요.');
			return;
		} 
		
		addThead = "";
		addTbody = "";
		addSelect = "";
		
		// 차트 보여주기
		$.ajax({
			url: '${pageContext.request.contextPath}/getDonationItemByPeriod',
			type: 'get',
			data: {startDate : startDate,
					endDate : endDate},
			success: function(jsonData){
				console.log('카테고리 json가져오기');
				
				//이전 데이터가 있을 경우 초기화한다.
				labels = [];
				datas = [];
				
				if(myChart != null){	//기존 차트가 있으면
					myChart.destroy();	//차트를 없애 버려라
				}
				
				$(jsonData).each(function(index, item){
					labels.push(item.itemCategoryName);
					datas.push(item.total);
				});
				
				//잘 담겼나 확인
				console.log('labels-> '+labels);
				console.log('datas-> '+datas);
				
				let data = {
							  labels: labels,
							  datasets: [{
									    data: datas,
									    backgroundColor: [
									      'rgba(255, 99, 132, 0.2)',
									      'rgba(255, 159, 64, 0.2)',
									      'rgba(255, 205, 86, 0.2)',
									      'rgba(75, 192, 192, 0.2)',
									      'rgba(54, 162, 235, 0.2)',
									      'rgba(153, 102, 255, 0.2)',
									      'rgba(201, 203, 207, 0.2)',
									      'rgba(255, 99, 132, 0.2)',
									      'rgba(255, 159, 64, 0.2)',
									      'rgba(255, 205, 86, 0.2)',
									      'rgba(75, 192, 192, 0.2)',
									      'rgba(54, 162, 235, 0.2)',
									      'rgba(153, 102, 255, 0.2)',
									      'rgba(201, 203, 207, 0.2)',
									      'rgba(255, 159, 64, 0.2)'
									    ],
									    borderColor: [
									      'rgb(255, 99, 132)',
									      'rgb(255, 159, 64)',
									      'rgb(255, 205, 86)',
									      'rgb(75, 192, 192)',
									      'rgb(54, 162, 235)',
									      'rgb(153, 102, 255)',
									      'rgb(201, 203, 207)',
									      'rgb(255, 99, 132)',
									      'rgb(255, 159, 64)',
									      'rgb(255, 205, 86)',
									      'rgb(75, 192, 192)',
									      'rgb(54, 162, 235)',
									      'rgb(153, 102, 255)',
									      'rgb(201, 203, 207)',
									      'rgb(255, 159, 64)'
									    ],
							  }]
				};
				
				const config = {
							  type: 'doughnut',
							  data: data,
							  options: {responsive: false,
								  		cutout : '40%',
									    plugins: {
									    	legend: { position: 'right',}}
							  }
				};
				
				
				myChart = new Chart(document.getElementById('myChart'), config);
			}
		});
		
		//select box 추가
		$.ajax({
			url: '${pageContext.request.contextPath}/getItemCategoryList',
			type: 'get',
			success: function(jsonData){
				console.log('물품 카테고리 가져오기 ajax');
				$('#select').empty();	// input 비운다.
				
				// select box 추가
				addSelect += '<select id="select" name="itemCategoryName" class="select_box" onchange="selChangeFun(this.value);">';
				addSelect +=	'<option value="non">전체 카테고리</option>';
				
				$(jsonData).each(function(index, item){
					addSelect += '<option value="'+item.itemCategoryName+'">'+item.itemCategoryName+'</option>';
				});
		
				addSelect += '</select>';
				
				$('#input').empty();
				$('#select').empty();
				$('#input').append(addSelect);
			}
		});
		
		// 테이블 추가
		$.ajax({
			url: '${pageContext.request.contextPath}/getDonationItemByPeriod',
			type: 'get',
			data:{startDate : startDate,
					endDate : endDate},
			success: function(jsonData){
				console.log('기간별 물품조회 ajax!');
				
				addThead +=	'<tr>';
				addThead += 	'<th width="35%">물품 카테고리</th>';
				addThead += 	'<th width="35%">수량</th>';
				addThead += 	'<th width="35%">최근 후원일</th>';
				addThead += '</tr>';
				
				$('#itemThead').empty();	// 비우기
				$('#itemThead').append(addThead);	//thead 추가
				
				$(jsonData).each(function(index, item){
					addTbody += '<tr>';
					addTbody += 	'<td>'+item.itemCategoryName+'</td>';
					addTbody += 	'<td>'+item.total+'</td>';
					addTbody += 	'<td>'+item.donationDate+'</td>';
					addTbody += '</tr>';
				});
				
				$('#itemTbody').empty();	// 비워놓기
				$('#itemTbody').append(addTbody);	// tbody 추가
			}
		});
		
		
	}
	
	function selChangeFun(category){
		console.log('select box 변경');
		itemCategoryName = category;
		console.log('itemCategoryName-> '+itemCategoryName);
		addTbody = "";
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getDonationItemByPeriod',
			type: 'get',
			data: {startDate : startDate,
					endDate : endDate,
					itemCategoryName : itemCategoryName},
			success: function(jsonData){
				console.log('select box 변경 후 ajax!');
				
				$(jsonData).each(function(index, item){
					addTbody += '<tr>';
					addTbody += 	'<td>'+item.itemCategoryName+'</td>';
					addTbody += 	'<td>'+item.total+'</td>';
					addTbody += 	'<td>'+item.donationDate+'</td>';
					addTbody += '</tr>';
				});
				
				$('#itemTbody').empty();	// 비워놓기
				$('#itemTbody').append(addTbody);	// tbody 추가
			}
		});
	}
	</script>
	
	<!-- chart js -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
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