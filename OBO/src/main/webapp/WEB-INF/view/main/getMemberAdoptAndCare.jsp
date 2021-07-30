<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양 케어</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
  /* Make the image fully responsive */
  .carousel-inner img {
    width: 100%;
    height: 100%;
  }
  </style>
  

<script>
$(document).ready(function(){
  $(".nav-tabs a").click(function(){
    $(this).tab('show');
  });
});
</script>

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
					<h3>입양&케어</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>
				 <div  class="col-lg-9 mb-5 mb-lg-0">
					 <!-- Nav tabs -->
					  <ul class="nav nav-tabs"  style="height: 10%">
					    <li class="nav-item">
					      <a class="nav-link active" href="#home">입양</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" href="#menu1">케어</a>
					    </li>
					  </ul>
					
					  <!-- Tab panes -->
					 
					  <div class="tab-content">
					    <div id="home" class="container tab-pane active"><br>
					      <!-- <h3>입양</h3> -->
					      
						     <div id="myCarousel" class="carousel slide" data-ride="carousel">
		
							  <!-- Indicators -->
							  <ul class="carousel-indicators">
							    <c:if test="${!adoptList.isEmpty()}">
							    	<c:forEach var="i" begin="0" end="${adoptList.size()-1}" step="1">
								    	 <li data-target="#myCarousel" data-slide-to="${i}" class="${i==0? 'active' : '' }"></li>
								    </c:forEach>
							    </c:if>
							  </ul>
							  
							  <!-- The slideshow -->
							 <div class="carousel-inner">
							 	<div class="col-lg-12 mb-12 mb-lg-0" >
									<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
									<div class="single_service staff_account">
										<div class="service_content">
											<h3 class="text-center" style="margin-top: 2%; margin-bottom: 0%;">입양동물</h3>
										  	<c:if test="${!adoptList.isEmpty()}">
											  	<c:forEach var="i" begin="0" end="${adoptList.size()-1}" step="1">
											  			
											    	 <div class="carousel-item ${i==0? 'active' : '' }" style="margin-top: 0%; margin-bottom: 2%;">
											    		
												    	<div class="section-top-border">
															
															<div class="row">
																<div class="col-md-4">									
																	<img src="${pageContext.request.contextPath}/static/img/animal/${adoptList.get(i).animalFileName}" alt="" class="img-fluid img-thumbnail">
																</div>
																<div class="col-md-8 mt-sm-20">
																	<h3 class="mb-30" style="margin-top: 2%;">${adoptList.get(i).animalName}</h3>
																	<p>
																		동물종 : ${adoptList.get(i).species}
																		<br>
																		<br>
																		보호소 : ${adoptList.get(i).shelterName}
																		<br>
																		<br>
																		입양날짜 : ${adoptList.get(i).adoptDate}
																	</p>
																</div>
															</div>
														</div>
												    </div>
											    </c:forEach>
										  	 </c:if>
										  	 
										  	<!-- Left and right controls 화살표 색깔 바꾸기.... ㅎㅎ.... -->
											  <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
											    <span class="carousel-control-prev-icon"></span>
											  </a>
											  <a class="carousel-control-next" href="#myCarousel" data-slide="next">
											    <span class="carousel-control-next-icon"></span>
											  </a> 
										  	 
							  			 </div>
							  		 </div>
							  		 
							  		 
							  		 
							  	 </div>
							  </div>
		  
							  
							</div>
					     
					      
					    	  <!-- 입양 내역: 입양신청목록 -->
						   	 <div class="col-lg-12 mb-12 mb-lg-0"  >
								<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
								<div class="single_service staff_account" style="height: 90%;">
									<div class="service_content text-center">
										<h3 class="text-center" style="margin-top: 2%;">입양신청목록</h3>
										
										<table class="table">
											<thead>
												<tr>
													<th>신청날짜</th>
													<th>신청동물</th>
													<th>보호소</th>
													<th>승인여부</th>
												</tr>
											</thead>
											<tbody id="adoptTbody">
											</tbody>							
										</table>
										<!-- 페이징 -->
										<div class="blog_left_sidebar">
											<nav class="blog-pagination justify-content-center d-flex">
												<ul class="pagination" id="adoptPaging">
													
													
												</ul>
											</nav>
										</div>
										
									</div>
								</div>
							</div>
					      
					      
					      
					    </div>
				    	
				    	<!-- 케어 -->
					    <div id="menu1" class="container tab-pane fade"><br>
					      <!-- 달력 그리기 -->
					     	  <!-- 입양 내역: 입양신청목록 -->
						   	 <div class="col-lg-12 mb-12 mb-lg-0"  >
								<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
								<div class="single_service staff_account" style="height: 90%;">
									<div class="service_content">
										<!-- 고민.... -->
										<span style="text-align: right;">
											<a href="javascript:void(0);">오늘</a>
										</span>
										<h3 class="text-center" style="margin-top: 2%;">케어달력</h3>
											
											<!--  달력 설정 -->
											<h2 class="text-center">
												<span>
													<a href="javascript:void(0);" onclick="moveMonth(-1)"><i class="fa fa-arrow-circle-o-left"></i></a>
													<input id="date" class="form-control" type="month" style="display:inline-block; width:25%;"
															onchange="changeCal(Number(document.getElementById('date').value.slice(0,4)), Number(document.getElementById('date').value.slice(5,7)));">
													<!-- ${aboutToday.thisYear}년 / ${aboutToday.thisMonth}월 -->
													<a href="javascript:void(0);" onclick="moveMonth(+1)"><i class="fa fa-arrow-circle-o-right"></i></a>
												</span>	
											</h2>
											<br><br>
											<table class="table" style="table-layout:fixed;">
												<thead>
													<tr style="text-align:center;">
														<th>일</th>
														<th>월</th>
														<th>화</th>
														<th>수</th>
														<th>목</th>
														<th>금</th>
														<th>토</th>
													</tr>
												</thead>
												<tbody id="day">
													
												</tbody>
											</table>
									</div>
								</div>
							</div>
					    
					    
					    
					    
					    </div>
					  </div>
				  </div>
				
				
			</div>
		</div>
	</section>

<script>
	let adoptApplyPage = 1;
	
	myAdoptApplyTbody(adoptApplyPage);
	
	function moveAdoptApplyPage(no){
		adoptApplyPage = adoptApplyPage + no;
		myAdoptApplyTbody(adoptApplyPage);
	}
	
	//입양신청목록 tbody
	function myAdoptApplyTbody(page){
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getAdoptApplyListByMemberId',
			data: {'currentPage': page}
		}).done(function(jsonData){
			
			console.log(jsonData);
			
			prePage = page-1;
			nextPage = page+1;
			
			$('#adoptTbody').empty();
			$('#adoptPaging').empty();
			
			
			//tbody 그리기
			let tbody;
			
			$.each(jsonData.list, function(index,data){
				console.log(data);
				tbody += '<tr>';
				tbody += '<td>'+data.applyDate+'</td>';
				tbody += '<td>'+data.animalName+'</td>';
				tbody += '<td>'+data.shelterName+'</td>';
				tbody += '<td>'+data.checked+'</td>';
				tbody += '</tr>';
			})
			
			$('#adoptTbody').append(tbody);
			
			//페이징
			
			//이전
			if(prePage > 0){
				$('#adoptPaging').append('<li class="page-item"><button type="buttn" class="page-link" onclick="moveAdoptApplyPage(-1)"><i class="ti-angle-left"></i></button></li>');
				$('#adoptPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveAdoptApplyPage(-1)">'+prePage+'</button></li>');
			}
			
			//현재
			$('#adoptPaging').append('<li class="page-item active"><button type="button" class="page-link">'+page+'</button></li>');
			
			//다음
			if(nextPage <= jsonData.lastPage){						
				$('#adoptPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveAdoptApplyPage(1)">'+nextPage+'</button></li>');
				$('#adoptPaging').append('<li class="page-item"><button type="button" class="page-link" onclick="moveAdoptApplyPage(1)"><i class="ti-angle-right"></i></button></li>');
			}
			
		})
	}
</script>

<script>
	let now = new Date();	// 현재 날짜 및 시간
	let year = now.getFullYear();	// 연도
	console.log('연도 : ', year);
	
	let month = now.getMonth() + 1;	// 월
	console.log('월 : ', month);
	
	calendar(year,month);
	
	
	
	//년월 바꾸기
	function changeCal(y, m){
		year = y;
		month = m;
		calendar();
		
	}
	
	//월 받아서 바꾸기
	function moveMonth(m){
		month = month + m
		calendar();
	}
	
	//달의 첫재날 무슨 주일?
	//new Date('2020-01-01').getDay();
	// 0이 일요일... 6이 토요일 = 앞의 블랭크의 수와 같음
	function firstDate(){
		let m;
		if(month<10){	
			m = '0'+month;
		} else{
			m = month;
		}
		
		let day = year + '-' + m + '-01';
		
		console.log('확인!!!!!!!!! day 첫째날 블랭크 구하기'+ day);
		return new Date(day).getDay();
	}
	
	//var lastDate = new Date(2019, 2, 0).getDate();
	//console.log(lastDate);
	function endDate(){
		return new Date(year, month, 0).getDate();
	}
	
	// endBlank는 firstBlank + endDate를 7로 나눈 나머지 값을 7에서 빼준다. 만약 나머지 0이라면 추가하는 블랭크 없음.
	function endBlank(first, end){
		let endB = 0;
		if((first+end)%7 != 0) {
			endB = 7-((first+end)%7);
		}
		
		return endB;
	}

	//달력 다른 달로 바꾸기 y: 년도 , m: 월
	function calendar(){
		
		//1월 -> 12월
		if(month<1){
			year -= 1;
			month = 12;
		}
		//12월 -> 1월
		if(month>12){
			year += 1;
			month = 1;
		}
		
		//date에 값 넣어주기 위한 설정
		if(month<10){	
			$('#date').val(year+'-0'+month);
		} else{
			$('#date').val(year+'-'+month);
		}
		
		//console.log('바뀐 년/월?'+$('#date').val());
		
		
		
		//바뀐 년월 불러오기...
		//구해야될거 달의 첫날 요일, 첫번째 블랭크 , 마지막날, 마지막 블랭크
		
		$.ajax({
			url: '${pageContext.request.contextPath}/member/getCarePlanListByMemberId',
			type: 'get',
			data: {year: year, month: month}
		}).done(function(jsonData){
			console.log(jsonData);
			
			
			//10월 11월 12월은 나오지 않는 이슈?
			
			//달력 셋팅
			//첫번째 블랭크 수, 요일
			let firstDay = firstDate();
			console.log(firstDay);
			//마지막 일
			let end = endDate();
			console.log(end);
			//마지막 블랭크 수
			let endB = endBlank(firstDay, end);
			console.log(endB);
			
			let totalCell = firstDay+end+endB;
			
			let addTable = "";
			
			addTable += '<tr style="height:130px;">';
			
			
			for(let i = 1; i <= totalCell; i++){
				day = i-firstDay;	//blank+1이 1부터 시작하도록!
				addTable += '<td>'
			
				// if-> 1~n일		else-> 앞뒤 블랭크
				if(i>firstDay && i<=(firstDay+end)){
					//n일
					addTable += '<div>'+day+'</div>';
					
					//n일에 해당하는 일정 등록, 그 외에는 일만 뜨도록 함.
					$(jsonData).each(function(index, item){
						if(day == item.day){
							addTable += '<div><a href="javascript:void(0);" data-parameter="'+item.carePlanId+'" data-toggle="modal" data-target="#plan-modal" onclick="planOneFunc(this.getAttribute(\'data-parameter\'));">'
										+item.animalName+'-'+item.careSorting+'</a></div>';
						}
					});
				} else{	//1~n일 제외한 블랭크
					addTable += '<div>&nbsp;<div>';
				}
				
				addTable += '</td>';
				
				//줄 바꾸기
				if(i%7 == 0 && day<end){
					addTable += '</tr><tr style="height:130px;">';
				}
			}
			
			addTable += '</tr>';
			
			$('#day').empty();
			$('#day').append(addTable);
			
			
		})
	}
	
</script>
</body>
</html>