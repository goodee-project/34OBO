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
									<tr style="height:130px;">
									<c:forEach var="i" begin="1" end="${aboutToday.thisFirstBlank}" step="1">
										<td>&nbsp;</td>
									</c:forEach>
									<c:forEach var="i" begin="1" end="${aboutToday.thisEndDate}" step="1">
										<td>
											<div>${i}</div>
											<c:forEach var="c" items="${carePlanList}">
												<c:if test="${i == c.day}">
													<div>
														<a href="javascript:void(0);" data-parameter="${c.carePlanId}" data-toggle="modal" data-target="#plan-modal" 
															onclick="planOneFunc(this.getAttribute('data-parameter'));">${c.animalName}</a>
													</div>
												</c:if>
											</c:forEach>
										</td>
										<c:if test="${(aboutToday.thisFirstBlank+i)%7 == 0}">
											</tr><tr style="height:130px;">
										</c:if>
									</c:forEach>
									<c:forEach var="i" begin="1" end="${aboutToday.thisEndBlank}" step="1">
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
	
	<!-- care 모달 -->
	<div class="modal fade" id="plan-modal" role="dialog" aria-labelledby="plan-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title" style="text-align:center;"><span id="animalName"></span>의 Care Plan</h4>
					<br>
					<table class="table" style="text-align:center;">
						<tr>
							<td width="30%">케어Info</td>
							<td>
								<input id="careInfo" class="form-control" name="careInfo" type="text" readonly>
							</td>
						</tr>
						<tr>
							<td>케어일</td>
							<td>
								<input id="careDate" class="form-control" name="careDate" type="date" readonly>
							</td>
						</tr>
						<tr>
							<td>회원정보</td>
							<td>
								<input id="member" class="form-control" name="member" type="text" readonly>
							</td>
						</tr>
						<tr>
							<td>특이사항</td>
							<td>
								<textarea rows="5" cols="80" id="features" class="form-control" name="features" readonly></textarea>
							</td>
						</tr>
					</table>
					
					<br>
					<div style="float:right;">
						<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
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
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendarAndList',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('달력&케어 같이 불러오기 ajax');
				
				//map안에 -> theDay(단일값), carePlanList(리스트 값) 존재
				
				//달력 세팅
				let cal = jsonData.theDay;
				//console.log('cal.setYear->'+cal.setYear);
				let setYear = cal.setYear;
				let setMonth = cal.setMonth;
				let firstDate = cal.firstDate;
				let firstBlank = cal.firstBlank;
				let endDate = cal.endDate;
				let endBlank = cal.endBlank;
				
				//플랜 세팅
				let plan = jsonData.carePlanList;
				//console.log('plan->'+plan);
				
				//#date에 값 넣기 위한 설정 ex.2021-9 -> 2021-09
				if(setMonth<10){	
					$('#date').val(setYear+'-0'+setMonth);
				} else{
					$('#date').val(setYear+'-'+setMonth);
				}
				
				//달력 만들기
				addTable += '<tr style="height:130px;">';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					$(plan).each(function(index, item){
						if(i == item.day){
							addTable += '<div><a href="javascript:void(0);" data-parameter="'+item.carePlanId+'" data-toggle="modal" data-target="#plan-modal" onclick="planOneFunc(this.getAttribute(\'data-parameter\'));">'
										+item.animalName+'</a></div>';
						}
					});
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr style="height:130px;">';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
			}
		});//-end;ajax
		
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

		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendarAndList',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('달력&케어 같이 불러오기 ajax');
				
				//map안에 -> theDay(단일값), carePlanList(리스트 값) 존재
				
				//달력 세팅
				let cal = jsonData.theDay;
				//console.log('cal.setYear->'+cal.setYear);
				let setYear = cal.setYear;
				let setMonth = cal.setMonth;
				let firstDate = cal.firstDate;
				let firstBlank = cal.firstBlank;
				let endDate = cal.endDate;
				let endBlank = cal.endBlank;
				
				//플랜 세팅
				let plan = jsonData.carePlanList;
				//console.log('plan->'+plan);
				
				//#date에 값 넣기 위한 설정 ex.2021-9 -> 2021-09
				if(setMonth<10){	
					$('#date').val(setYear+'-0'+setMonth);
				} else{
					$('#date').val(setYear+'-'+setMonth);
				}
				
				//달력 만들기
				addTable += '<tr style="height:130px;">';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					$(plan).each(function(index, item){
						if(i == item.day){
							addTable += '<div><a href="javascript:void(0);" data-parameter="'+item.carePlanId+'" data-toggle="modal" data-target="#plan-modal" onclick="planOneFunc(this.getAttribute(\'data-parameter\'));">'
										+item.animalName+'</a></div>';
						}
					});
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr style="height:130px;">';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
			}
		});//-end;ajax
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
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendarAndList',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('달력&케어 같이 불러오기 ajax');
				
				//map안에 -> theDay(단일값), carePlanList(리스트 값) 존재
				
				//달력 세팅
				let cal = jsonData.theDay;
				//console.log('cal.setYear->'+cal.setYear);
				let setYear = cal.setYear;
				let setMonth = cal.setMonth;
				let firstDate = cal.firstDate;
				let firstBlank = cal.firstBlank;
				let endDate = cal.endDate;
				let endBlank = cal.endBlank;
				
				//플랜 세팅
				let plan = jsonData.carePlanList;
				//console.log('plan->'+plan);
				
				//#date에 값 넣기 위한 설정 ex.2021-9 -> 2021-09
				if(setMonth<10){	
					$('#date').val(setYear+'-0'+setMonth);
				} else{
					$('#date').val(setYear+'-'+setMonth);
				}
				
				//달력 만들기
				addTable += '<tr style="height:130px;">';
				for(let i = 1; i <= firstBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				for(let i = 1; i <= endDate; i++){
					addTable += '<td>';
					addTable += '<div>'+i+'</div>';
					$(plan).each(function(index, item){
						if(i == item.day){
							addTable += '<div><a href="javascript:void(0);" data-parameter="'+item.carePlanId+'" data-toggle="modal" data-target="#plan-modal" onclick="planOneFunc(this.getAttribute(\'data-parameter\'));">'
										+item.animalName+'</a></div>';
						}
					});
					addTable += '</td>';
					if((firstBlank+i)%7 == 0){
						addTable += '</tr><tr style="height:130px;">';
					}
				}
				for(let i = 1; i <= endBlank; i++){
					addTable += '<td>&nbsp;</td>';
				}
				addTable += '</tr>';
			
				$('#day').empty();
				$('#day').append(addTable);
			}
		});//-end;ajax
	}

	function planOneFunc(id){
		console.log('동물 이름 클릭! -> care plan 정보 자세히보기 모달');
		console.log('넘어온 값->'+id);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCarePlanOneWithRecord',
			type: 'get',
			data: {carePlanId : id},
			success : function(jsonData){
				console.log('케어 플랜 상세정보 ajax');
				let animalName = jsonData.animalName
				let memberId = jsonData.memberId
				let memberName = jsonData.memberName
				let careInfo = jsonData.careInfo
				let careDate = jsonData.careDate
				let features = jsonData.features
				
				$('#animalName').text(animalName);
				$('#member').val(memberName+"("+memberId+")");
				$('#careInfo').val(careInfo);
				$('#careDate').val(careDate);
				
				$('#features').val('');
				if(features == null){
					$('#features').val('care record가 작성되지 않았습니다.');
				} else{
					$('#features').val(features);
				}
				
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