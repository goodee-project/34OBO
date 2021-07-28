<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getCarePlanCalInStaff</title>

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
					<h3>입양&케어 > 케어 > Plan달력</h3>
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
							<jsp:include page="/WEB-INF/view/staff/inc/side/adoptCareMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<!--  달력 설정 -->
							<h2 style="text-align:center;">
								<span style="float:center;">
									<a href="javascript:void(0);" onclick="lastMonthFunc();"><i class="fa fa-arrow-circle-o-left"></i></a>
									<input id="date" class="form-control" type="month" value="${aboutToday.date}" onchange="chDateFunc();" style="display:inline-block; width:20%">
									<!-- ${aboutToday.thisYear}년 / ${aboutToday.thisMonth}월 -->
									<a href="javascript:void(0);" onclick="nextMonthFunc();"><i class="fa fa-arrow-circle-o-right"></i></a>
								</span>
								
								<span style="float:right;">
									<a href="${pageContext.request.contextPath}/staff/getCarePlanCalInStaff">오늘</a>
								</span>
							</h2>
							<br><br>
							<table class="table">
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
								<tbody id="day" height="500">
									<tr>
									<c:forEach var="i" begin="1" end="${aboutToday.fBlankThisMonth}" step="1">
										<td>&nbsp;</td>
									</c:forEach>
									<c:forEach var="i" begin="1" end="${aboutToday.endDateThisMonth}" step="1">
										<td>
											<div>${i}</div>
											<div>일정1</div>
											<div>일정2</div>
											<div>일정3</div>
										</td>
										<c:if test="${(aboutToday.fBlankThisMonth+i)%7 == 0}">
											</tr><tr>
										</c:if>
									</c:forEach>
									<c:forEach var="i" begin="1" end="${aboutToday.eBlankThisMonth}" step="1">
										<td>&nbsp;</td>
									</c:forEach>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================Blog Area =================-->	


	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->	
	
	<script>
	// 이전 달
	function lastMonthFunc(){
		console.log('이전 월 클릭');
		console.log('기존 년/월?'+$('#date').val());
		let year = $('#date').val().slice(0,4);
		let month = $('#date').val().slice(5,7);
		
		//string to int
		if(month == 1){
			year = Number(year)-1;
			month = 12;
		} else{
			year = Number(year);
			month = Number(month)-1;
		}
		
		let addTable = "";
		let setYear, setMonth, firstDate, firstBlank, endDate, endBlank;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendar',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('달력불러오기 ajax');
				console.log('직접 선택 -> 달력불러오기 ajax');
				setYear = jsonData.setYear;
				setMonth = jsonData.setMonth;
				firstDate = jsonData.firstDate;
				firstBlank = jsonData.firstBlank;
				endDate = jsonData.endDate;
				endBlank = jsonData.endBlank;
				
				if(setMonth<10){	//#date에 값 넣기 위한 설정
					$('#date').val(setYear+'-0'+setMonth);
				} else{
					$('#date').val(setYear+'-'+setMonth);
				}
				
				addTable += '<tr>';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					addTable += '<div>일정1</div>';
					addTable += '<div>일정2</div>';
					addTable += '<div>일정3</div>';
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr>';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
				
			}
		});
	}

	// 다음 달
	function nextMonthFunc() {
		console.log('다음 월 클릭');
		let year = $('#date').val().slice(0,4);
		let month = $('#date').val().slice(5,7);

		//string to int & 12월-1월 변경
		if(month == 12){
			year = Number(year)+1;
			month = 1;
		} else{
			year = Number(year);
			month = Number(month)+1;
		}
		
		let addTable = "";
		let setYear, setMonth, firstDate, firstBlank, endDate, endBlank;

		$.ajax({
			url : '${pageContext.request.contextPath}/getCalendar',
			type : 'get',
			data : {
				year : year,
				month : month
			},
			success : function(jsonData) {
				console.log('달력불러오기 ajax');
				console.log('직접 선택 -> 달력불러오기 ajax');
				
				setYear = jsonData.setYear;
				setMonth = jsonData.setMonth;
				firstDate = jsonData.firstDate;
				firstBlank = jsonData.firstBlank;
				endDate = jsonData.endDate;
				endBlank = jsonData.endBlank;
				
				if(setMonth<10){	
					$('#date').val(setYear+'-0'+setMonth);
				} else{
					$('#date').val(setYear+'-'+setMonth);
				}
				
				addTable += '<tr>';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					addTable += '<div>일정1</div>';
					addTable += '<div>일정2</div>';
					addTable += '<div>일정3</div>';
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr>';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
			}
		});
	}
	
	// 년/월 직접 선택
	function chDateFunc(){
		console.log('날짜클릭');
		console.log('클릭한 년/월?'+$('#date').val());
		let year = $('#date').val().slice(0,4);
		let month = $('#date').val().slice(5,7);
		
		//string to int
		year = Number(year);
		month = Number(month);
		console.log('year->'+year);
		console.log('month->'+month);
		
		let addTable = "";
		let setYear, setMonth, firstDate, firstBlank, endDate, endBlank;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendar',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('직접 선택 -> 달력불러오기 ajax');
				setYear = jsonData.setYear;
				setMonth = jsonData.setMonth;
				firstDate = jsonData.firstDate;
				firstBlank = jsonData.firstBlank;
				endDate = jsonData.endDate;
				endBlank = jsonData.endBlank;
				
				addTable += '<tr>';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					addTable += '<div>일정1</div>';
					addTable += '<div>일정2</div>';
					addTable += '<div>일정3</div>';
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr>';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
			}
		});
	}

	</script>
	
	
	
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