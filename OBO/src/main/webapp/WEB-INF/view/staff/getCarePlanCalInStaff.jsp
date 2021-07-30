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
									<a href="javascript:void(0);" onclick="changeFunc(Number(document.getElementById('date').value.slice(0,4)), Number(document.getElementById('date').value.slice(5,7))-1);"><i class="fa fa-arrow-circle-o-left"></i></a>
									<input id="date" class="form-control" type="month" value="${aboutToday.date}" style="display:inline-block; width:20%"
											onchange="changeFunc(Number(document.getElementById('date').value.slice(0,4)), Number(document.getElementById('date').value.slice(5,7)));">
									<!-- ${aboutToday.thisYear}년 / ${aboutToday.thisMonth}월 -->
									<a href="javascript:void(0);" onclick="changeFunc(Number(document.getElementById('date').value.slice(0,4)), Number(document.getElementById('date').value.slice(5,7))+1);"><i class="fa fa-arrow-circle-o-right"></i></a>
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
										<c:forEach var="i" begin="1" end="${aboutToday.totalTd}" step="1">
										<c:set var="day" value="${i-aboutToday.thisFirstBlank}" />
											<td>
												<!-- 1~n일의 달력 -->
												<c:if test="${i>aboutToday.thisFirstBlank && i<=(aboutToday.thisFirstBlank+aboutToday.thisEndDate)}">
													<!-- n일 -->
													<div>${day}</div>
													<!-- n일에 해당하는 일정 -->
													<c:forEach var="c" items="${carePlanList}">
														<c:if test="${day == c.day}">
															<div>
																<a href="javascript:void(0);" data-parameter="${c.carePlanId}" data-toggle="modal" data-target="#plan-modal" 
																	onclick="planOneFunc(this.getAttribute('data-parameter'));">${c.animalName}</a>
															</div>
														</c:if>
													</c:forEach>
												</c:if>
												
												<!-- 1~n일 제외한 블랭크 -->
												<c:if test="${i<=aboutToday.thisFirstBlank || i>(aboutToday.thisFirstBlank+aboutToday.thisEndDate)}">
													<div>&nbsp;</div>
												</c:if>
											</td>
										
											<!-- 줄바꾸기 -->
											<c:if test="${i%7 == 0 && day<aboutToday.thisEndDate}">
												</tr><tr style="height:130px;">
											</c:if>
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
	
	// 이전 월, 다음 월, 원하는 년&월 달력 만드는 함수
	function changeFunc(y, m){
		console.log('changeFunction!');
		console.log('기존 년/월?'+$('#date').val());
		console.log('y->'+y	);
		console.log('m->'+m);
		let year = y;
		let month = m;
		
		// 1월->12월 변경
		if(month<1){
			year -= 1;
			month = 12;
		}
		
		// 12월->1월 변경
		if(month>12){
			year += 1;
			month = 1;
		}
		
		// date에 값 넣어주기 위한 설정
		if(month<10){	
			$('#date').val(year+'-0'+month);
		} else{
			$('#date').val(year+'-'+month);
		}
		
		console.log('바뀐 년/월?'+$('#date').val());
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCalendarAndList',
			type: 'get',
			data: {year : year,
					month : month},
			success: function(jsonData){
				console.log('달력&케어 같이 불러오기 ajax');
				
				let addTable = "";
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
				let totalCell = cal.firstBlank+cal.endDate+cal.endBlank;
				let day = 0;
				
				//플랜 세팅
				let plan = jsonData.carePlanList;
				//console.log('plan->'+plan);
				
				//달력 만들기
				addTable += '<tr style="height:130px;">';
				
				for(let i = 1; i <= totalCell; i++){
					day = i-firstBlank;	//blank+1이 1부터 시작하도록!
					addTable += '<td>'
				
					// if-> 1~n일		else-> 앞뒤 블랭크
					if(i>firstBlank && i<=(firstBlank+endDate)){
						//n일
						addTable += '<div>'+day+'</div>';
						
						//n일에 해당하는 일정 등록, 그 외에는 일만 뜨도록 함.
						$(plan).each(function(index, item){
							if(day == item.day){
								addTable += '<div><a href="javascript:void(0);" data-parameter="'+item.carePlanId+'" data-toggle="modal" data-target="#plan-modal" onclick="planOneFunc(this.getAttribute(\'data-parameter\'));">'
											+item.animalName+'</a></div>';
							}
						});
					} else{	//1~n일 제외한 블랭크
						addTable += '<div>&nbsp;<div>';
					}
					
					addTable += '</td>';
					
					//줄 바꾸기
					if(i%7 == 0 && day<endDate){
						addTable += '</tr><tr style="height:130px;">';
					}
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
					$('#features').val('care record 미작성');
				} else{
					$('#features').val(features);
				}
			}
		});//-end; ajax
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