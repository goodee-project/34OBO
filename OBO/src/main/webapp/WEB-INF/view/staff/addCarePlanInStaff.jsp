<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCarePlanInStaff</title>

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
	/*
	//plan 작성할 동물 선택
	$('#animalId').change(function(){
		
		
		/*
		if($('#animalId').val()==0){
			alert('Care Plan을 작성할 동물을 선택해주세요');
			return;
		}
		
		$.ajax({
			url: '${pageContext.request.contextPath}/calCarePlanDay',
			type: 'get',
			data: {animalId : $('#animalId').val()},
			success: function(jsonData2){
				console.log('plan 정보 불러오기 ajax 성공');
				$(jsonData2).each(function(index, item) {
				
				});
			}
		});
	});*/
	
	$('#addBtn').click(function(){
		console.log('등록버튼 클릭');
		alert('아 value왜안더'+$('#careInfoId').val());
		$('#addForm').submit();
	});
	
	$('#checkBtn').click(function(){
		console.log('아이콘클릭 ㅠ');
		
	});
	
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
					<h3>입양&케어 > 케어 > Plan작성</h3>
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
							<form id="addForm" action="" method="post">
								<table class="table">
									<tr>
										<td width="40%">직원ID</td>
										<td width="60%">
											${loginStaff.staffId}
											<input id="staffId" class="form-control" name="staffId" type="hidden">
										</td>
									</tr>
									<tr>
										<td>동물 선택</td>
										<td>
											<div class="add_form">
												<select id="animalId" name="animalId" class="select_box" onchange="animalChFunction();">
													<option value="0">==선택==</option>
													<c:forEach var="a" items="${adoptApprovalList}">
														<option value="${a.animalId}">${a.animalName}</option>
													</c:forEach>
												</select>
											</div>
										</td>
									</tr>
								</table>
								
								<div>* 회원정보 *</div>
								<table class="table">
									<tr>
										<td width="40%">회원ID</td>
										<td width="60%">
											<input id="memberId" class="form-control" name="memberId" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>회원이름</td>
										<td>
											<input id="memberName" class="form-control" name="memberName" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>신청일</td>
										<td>
											<input id="applyDate" class="form-control" name="applyDate" type="text" readonly>
										</td>
									</tr>
									<tr>
										<td>입양일</td>
										<td>
											<input id="adoptDate" class="form-control" name="adoptDate" type="text" readonly>
										</td>
									</tr>
								</table>
								
								<br>
								
								<table id="planTable" class="table">
									
								</table>
								<div> <!-- onclick="addFunction();" -->
									<a id="planAddBtn" href="javascript:void(0);" onclick="addFunction();"><i class="fa fa-plus-square-o fa-2x"></i></a>
									<a id="planRemoveBtn" href="javascript:void(0);" onclick="minusFunction();"><i class="fa fa-minus-square-o fa-2x"></i></a>
								</div>
								<br><br>
								<button id="addBtn" type="button" class="genric-btn primary-border radius">Plan 작성</button>
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
	let animalCategoryId, animalId;
	
	// care plan 작성할 동물 선택
	function animalChFunction(){
		console.log('동물선택~');
		animalId = $('#animalId').val();
		console.log('선택한 animalId-> '+animalId);
		let addTr = "";
		
		$.ajax({
			url: '${pageContext.request.contextPath}/getAdoptApprovalList',
			type: 'get',
			data: {animalId : animalId},
			success: function(jsonData){
				console.log('회원&동물 정보 불러오기 ajax 성공');
				
				$('#planTable').empty();	//테이블 비우기
				
				$(jsonData).each(function(index, item) {
					addTr += '<td width="40%">';
					addTr += 	'<input class="form-control" type="text" value="정기검진" readonly>';
					addTr += 	'<input id="careInfoId" name="careInfoId" type="hidden" value="'+item.careInfoId+'">';
					addTr += '</td>';
					addTr += '<td width="60%">';
					addTr += 	'<input id="regularCk" class="form-control" name="careDate" type="date">';
					addTr += '</td>';
					
					$('#planTable').append(addTr);
					
					$('#memberId').val(item.memberId);
					$('#memberName').val(item.memberName);
					$('#applyDate').val(item.applyDate);
					$('#adoptDate').val(item.adoptDate);
					$('#regularCk').val(item.regularCk);
					$('#careInfoId').val(item.careInfoId);
					
					careInfoId = item.careInfoId;
					animalCategoryId = item.animalCategoryId;
					console.log('케어인포아이디 ㅠㅠ-> '+item.careInfoId);
					console.log('animalCategoryId ㅠㅠ-> '+item.animalCategoryId);
					
				});
			}
		});
	};

	
	
	// jquery on binding
	$(document).on('click', '#planAddBtn', function(){
		console.log('+클릭');
		
		if($('#animalId').val() == 0){
			alert('동물을 먼저 선택해주세요');
			return;
		}
		
		let addTr = "";
		let addTr2 = "";
		let trCnt = $('#planTable tr').length;
		console.log('추가 전 tr 개수->'+trCnt);
		
		
		// 추가 버튼 클릭과 동시에 sorting list를 불러온다. -> animalCategoryId 값을 같이 준다
		$.ajax({
			url: '${pageContext.request.contextPath}/careSortingList',
			type: 'get',
			data: {animalCategoryId : animalCategoryId},
			success: function(jsonData){
				console.log('sorting 리스트 불러오기 성공');
				
				// 최대 5개까지만!
				if(trCnt < 6){
					
					addTr += '<tr>';
					addTr += '<td>';
					addTr += '<select id="careSorting" style="width:100%;" class="select_box" onchange="calCarePlanFunction();">';
					addTr += '<option value="0">==선택==</option>';
					$(jsonData).each(function(index, item){
						addTr += '<option value="'+item.careInfoId+'">'+item.careSorting+'</option>';
					});
					addTr += '</select>';
					addTr += '</td>';
					addTr += '<td>';
					addTr += '<div id="del">';
					addTr += '<input class="form-control" type="date">';
					addTr += '</div>';
					addTr += '</td>';
					addTr += '</tr>';
					
					$('#planTable').append(addTr);	// 왼쪽 td 선 추가,,
					
					$(document).on('change', '#careSorting', function(e){
						let careInfoId = e.target.value;
						
						console.log('셀렉트박스 클릭');
						console.log('careInfoId-> '+careInfoId);
						
						$('#del').removeAttr();	// 삭제해도 안 먹힘,,,
						
						$.ajax({
							url: '${pageContext.request.contextPath}/calCarePlanDay',
							type: 'get',
							data: {animalId : animalId,
									careInfoId : careInfoId},
							success: function(jsonData){
								console.log('sorting-content 선택 성공!!!!!!!');
								$('#del').html('<input id="careDate" class="form-control" name="careDate" type="date">')
								
								$(jsonData).each(function(index, item){
									$('#careDate').val(item.careDate);
									careDate = item.careDate;
									console.log('최종 careInfoId-> '+careInfoId);
									console.log('찐 랏 최종 careDate-> '+careDate);
									return;
								});
							}
						});
					});
					
					trCnt = $('#planTable tr').length;
					console.log('ajax 성공 tr 개수->'+trCnt);
				} else{
					alert('최대 5개까지 추가 가능합니다.');
					return;
				}
				
			}
		});
		
		
	});
	
	
	
	/* onclick 함수 사용 할 때
	
	// [+] 클릭
	function addFunction(){
		let careInfoId;
		
		console.log('[+] 클릭직후의 케어인포-> '+$('#careInfoId').val());
		
		if($('#animalId').val() == 0){
			alert('동물을 먼저 선택해주세요');
			return;
		}
		
		let addTr = "";
		let trCnt = $('#planTable tr').length;
		console.log('추가 전 tr 개수->'+trCnt);
		
		// 이슈 발견 -> 버튼 추가하면 ajax로 인해 값이 선택된 값만 보여진다,,! -> 즉 새로운 행은 값을 변경할 수 없음
		
		
		// 추가 버튼 클릭과 동시에 sorting list를 불러온다. -> animalCategoryId 값을 같이 준다
		$.ajax({
			url: '${pageContext.request.contextPath}/careSortingList',
			type: 'get',
			data: {animalCategoryId : animalCategoryId},
			success: function(jsonData){
				console.log('sorting 리스트 불러오기 성공');
				
				// 최대 5개까지만!
				if(trCnt < 6){
					addTr += '<tr>';
					addTr += '<td>';
					addTr += '<select id="careSorting" style="width:100%;" class="select_box" onchange="calCarePlanFunction();">';
					addTr += '<option value="0">==선택==</option>';
					$(jsonData).each(function(index, item){
						addTr += '<option value="'+item.careInfoId+'">'+item.careSorting+'</option>';
					});
					addTr += '</select>';
					addTr += '<td>';
					addTr += '<input id="careDate" class="form-control" name="careDate" type="date">';
					addTr += '<input id="careInfoId" type="hidden" name="careInfoId" value="">';
					addTr += '</td>';
					addTr += '</tr>';
					
					$('#planTable').append(addTr);
					
					
					
					trCnt = $('#planTable tr').length;
					console.log('ajax 성공 tr 개수->'+trCnt);
				} else{
					alert('최대 5개까지 추가 가능합니다.');
					return;
				}
				
			}
		});
		
	};
	
	
	// care plan 계산 함수! - select option 선택 후
	function calCarePlanFunction(){
		console.log('careplan 선택!!');
		careInfoId = $('#careSorting').val();
		//$('#careSorting').val(careInfoId);
		console.log('선택한 careInfoId-> '+careInfoId);
		console.log('선택한 val()-> '+$('#careSorting').val());
		$('#careInfoId').val('');
		$('#careDate').val('');
		
		$.ajax({
			url: '${pageContext.request.contextPath}/calCarePlanDay',
			type: 'get',
			data: {animalId : animalId,
					careInfoId : careInfoId},
			success: function(jsonData){
				console.log('sorting-content 선택 성공!!!!!!!');
				$(jsonData).each(function(index, item){
					$('#careDate').val(item.careDate);
					$('#careInfoId').val(item.careInfoId);
					//careInfoId = item.careInfoId;
					careDate = item.careDate;
					console.log('최종 careInfoId-> '+item.careInfoId);
					console.log('최종 careDate-> '+item.careDate);
					console.log('찐 랏 최종 careDate-> '+careDate);
					return;
				});
			}
		});
	};
	
	// 필요없는 내용 삭제할 때
	function minusFunction(){
		let trCnt = $('#planTable tr').length;
		console.log('삭제 전 tr 개수->'+trCnt);
		
		if(trCnt > 1){
			$('#planTable tr:last').remove();
		} else{
			alert('정기검진은 삭제 할 수 없습니다.');
			return;
		}
		
		trCnt = $('#planTable tr').length;
		console.log('삭제 후 tr 개수->'+trCnt);
	};
	*/
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