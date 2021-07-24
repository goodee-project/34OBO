<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCareRecordInStaff</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- 검색어 자동완성 cdn  -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

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
	
	/*
	// carePlan 검색
	$('#searchPlan').autocomplete({
		source : function(request, response) {
			 $.ajax({
				type: 'get',
				url: '${pageContext.request.contextPath}/searchPlan',
				dataType: 'json',
				data: {keyWord : $('#searchPlan').val()}, 	// 검색 키워드
				success: function(jsonData){
					console.log('7일 이내 plan 가져오기 성공');
					response(
						$.map(jsonData, function(item) {
							return{
								label : item.carePlan,			// 자동완성에 표시되는 값
								value : item.carePlan,			// 자동완성 선택 시 화면에 보여줄 내용
								carePlanId : item.carePlanId	// 자동완성 선택 시 저장할 값
							}
						})
					)
				}
					
			});
		},
		select: function(event, ui){	// 선택한 값 설정
			carePlanId = ui.item.carePlanId; // 변수에 값 넣어주기 -> (1)에서 넣은 값들을 다시 세팅해준다.
			console.log('선택한 plan의 carePlanId-> '+carePlanId);
			$('#carePlanId').val(carePlanId);	// shelterId 값 설정
			console.log('val 설정 후 carePlanId 값-> '+$('#carePlanId').val());
		},
		focus: function(evnet, ui){ // 자동 초점
			return false;
		},
		minLength: 2,	// 최소 글자
		delay: 500		// 자동완성 뜨는 시간
	})*/
	
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
					<h3>입양&케어 > 케어 > Record작성</h3>
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
							<!-- form 형식 작성 -->
							<form id="addForm" action="${pageContext.request.contextPath}/staff/addCareRecordInStaff" method="post">
								<table class="table">
									<tr>
										<td width="30%">직원ID</td>
										<td width="70%">${loginStaff.staffId}</td>
									</tr>
									<tr>
										<td>Plan 항목</td>
										<td>
											<select id="carePlanId" name="carePlanId" class="select_box" onchange="cardPlanChFunc(this.value);">
												<option value="non">==선택==</option>
												<c:forEach var="c" items="${carePlanOne}">
													<option value="${c.carePlanId}">${c.carePlan}</option>
												</c:forEach>
											</select>
											&nbsp; * 7일 이내 plan만 확인 가능합니다.*
										</td>
									</tr>
								</table>
								<br>
								<table class="table">
									<tr>
										<td width="30%">이름</td>
										<td width="70%">
											<input id="animalName" class="form-control" name="animalName" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>케어Info</td>
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
										<td>회원정보</td> <!-- 회원이름(id) -->
										<td>
											<input id="member" class="form-control" name="member" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>특이사항</td>
										<td>
											<textarea rows="5" cols="80" id="features" class="form-control" name="features"></textarea>
										</td>
									</tr>
								</table>
								
								<button id="addBtn" type="button" class="genric-btn primary-border radius" onclick="addRecordFunc();">Record 작성</button>
							</form>
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
	function addRecordFunc(){
		console.log('작성 버튼 클릭!');
		console.log('carePlanId-> '+$('#carePlanId').val());
		console.log('features-> '+$('#features').val());
		console.log('features글자길이-> '+$('#features').val().length);
		
		if($('#carePlanId').val() == 'non'){
			alert('항목을 선택해주세요');
		} else if($('#features').val() == '' || $('#features').val().length < 5){
			alert('특이사항을 5자 이상 적어주세요');
		} else{
			$('#addForm').submit();
		}
	}
	
	// careplan 선택
	function cardPlanChFunc(id){
		console.log('케어플랜 선택!');
		console.log('id-> '+id);
		
		if($('#carePlanId').val() == 'non'){
			alert('항목을 선택해주세요');
			$('#animalName').val('');
			$('#member').val('');
			$('#careInfo').val('');
			$('#careDate').val('');
			
			return;
		}
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getCarePlanOne',
			type: 'get',
			data: {carePlanId : id},
			success: function(jsonData){
				console.log('care plan 정보 불러오기 성공');
				$('#animalName').val(jsonData.animalName);
				$('#member').val(jsonData.memberName+'('+jsonData.memberId+')');
				$('#careInfo').val(jsonData.careInfo);
				$('#careDate').val(jsonData.careDate);
			}
		});
	}
	</script>
	
	<!-- JS here -->
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