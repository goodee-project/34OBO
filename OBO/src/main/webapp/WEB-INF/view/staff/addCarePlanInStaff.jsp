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
											<input id="staffId" class="form-control" name="staffId" type="hidden" value="${loginStaff.staffId}">
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
								<br>
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
								<button id="addBtn" type="button" class="genric-btn primary-border radius" onclick="submitFun();">Plan 작성</button>
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
	let animalCategoryId, animalId; //animalChFunction() & addFunction()에서 사용
	let cnt = 0;	//careInfoId & careDate 수를 알기 위한 값
	let careInfoIdArr,careDateArr;
	
	// care plan 작성할 동물 선택
	function animalChFunction(){
		console.log('동물선택~');
		animalId = $('#animalId').val();
		console.log('선택한 animalId-> '+animalId);
		let addTr = "";
		
		careInfoIdArr = [];
		careDateArr = [];
		
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
					addTr += 	'<input id="regularCk" class="form-control" name="careDate" type="date" readonly>';
					addTr += '</td>';
					
					$('#planTable').append(addTr);
					
					$('#memberId').val(item.memberId);
					$('#memberName').val(item.memberName);
					$('#applyDate').val(item.applyDate);
					$('#adoptDate').val(item.adoptDate);
					$('#regularCk').val(item.regularCk);
					$('#careInfoId').val(item.careInfoId);
					cnt = 1;
					
					// 배열에 값 설정
					careInfoIdArr.push(item.careInfoId);
					careDateArr.push(item.regularCk);
					
					animalCategoryId = item.animalCategoryId;	// [+]버튼 클릭 시 필요한 값
					
					//console.log('cnt-> '+cnt);
					//console.log('careInfoIdArr 배열 !-> '+careInfoIdArr);
					//console.log('careDateArr 배열 !-> '+careDateArr);
					//console.log('animalCategoryId-> '+item.animalCategoryId);
				});
			}
		});
	};

	// [+] 클릭
	function addFunction(){
		console.log('[+] 클릭직후의 케어인포-> '+$('#careInfoId').val());
		if($('#animalId').val() == 0){
			alert('동물을 먼저 선택해주세요');
			return;
		}
		
		if($('#careSorting'+cnt+'').val() == 0){
			alert('Plan 선택 후 다시 추가해주세요');
			return;
		}
		
		// 기존에 하나 추가하고 다시 [+] 눌렀을 때 기존 선택내역은 수정못하게 막아버리자
		$('#careSorting'+cnt+'').attr('disabled', 'true');
		
		let addTr = "";
		let trCnt = $('#planTable tr').length;
		//console.log('추가 전 tr 개수->'+trCnt);
		
		// 추가 버튼 클릭과 동시에 sorting list를 불러온다. -> animalCategoryId 값을 같이 준다
		$.ajax({
			url: '${pageContext.request.contextPath}/careSortingList',
			type: 'get',
			data: {animalCategoryId : animalCategoryId},
			success: function(jsonData){
				console.log('sorting 리스트 불러오기 성공');
				
				// 최대 5개까지만!
				if(trCnt < 5){
					cnt += 1; // [+] 클릭 후 table 추가 시 cnt 추가된다!!
					
					addTr += '<tr>';
					addTr += '<td>';
					addTr += '<select id="careSorting'+cnt+'" style="width:100%;" class="select_box" onchange="calCarePlanFunction(this.value);">';
					addTr += '<option value="0">==선택==</option>';
					$(jsonData).each(function(index, item){
						addTr += '<option value="'+item.careInfoId+'">'+item.careSorting+'</option>';
					});
					addTr += '</select>';
					addTr += '<td>';
					addTr += '<input id="careDate'+cnt+'" class="form-control" name="careDate" type="date" readonly>';
					addTr += '</td>';
					addTr += '</tr>';
					
					$('#planTable').append(addTr);
					
					trCnt = $('#planTable tr').length;
					
					//console.log('ajax 성공 tr 개수->'+trCnt);
					//console.log('+ -> ajax 후 cnt-> '+cnt);
				} else{
					alert('최대 5개까지 추가 가능합니다.');
					return;
				}
			}//-success
		});	//-ajax
	};//-addFunction();
	
	
	// care plan 계산 함수! - select option 선택 후
	function calCarePlanFunction(id){
		console.log('careplan 선택!!');
		careInfoId = id;	// String
		console.log('받은 인자값-> '+careInfoId);
		console.log('careInfoIdArr 배열 !-> '+careInfoIdArr);
		//console.log('careDateArr 배열 !-> '+careDateArr);
		
		console.log('배열길이-> '+careInfoIdArr.length);
		console.log('cnt-> '+cnt);
		
		// 기존 셀렉트를 변경할 경우 arr 값 수정 -> 끝에서 두번째 값이 지워져야 한다.
		if(careInfoIdArr.length == cnt){
			careInfoIdArr.splice(careInfoIdArr.length-1,1);
			careDateArr.splice(careDateArr.length-1,1);
			console.log('careInfoIdArr 배열 !-> '+careInfoIdArr);
			console.log('careDateArr 배열 !-> '+careDateArr);
		}
		
		// 이미 선택한 값 골랐을 경우 -> id는 String, careInfoIdArr는 number이므로 형변환 해야한다.
		//console.log('type number-> '+careInfoIdArr.includes(parseInt(careInfoId)));
		//console.log('type String-> '+typeof(id));
		if(careInfoIdArr.includes(parseInt(careInfoId))){
			alert('이미 선택된 항목입니다.');
			$('#careSorting'+cnt+'').val(0);	// 선택된 값 -> ==선택==으로 변경
			$('#careDate'+cnt+'').val('');	// 선택된 값 -> 초기화
			console.log('careInfoIdArr 배열 !-> '+careInfoIdArr);
			console.log('careDateArr 배열 !-> '+careDateArr);
			
			return;
		}
		
		$.ajax({
			url: '${pageContext.request.contextPath}/calCarePlanDay',
			type: 'get',
			data: {animalId : animalId,
					careInfoId : careInfoId},
			success: function(jsonData){
				console.log('sorting-content 선택 성공!!!!!!!');
				$(jsonData).each(function(index, item){
					careInfoIdArr.push(item.careInfoId);
					careDateArr.push(item.careDate);
					//$('.careDate').val(item.careDate); //class 사용할 경우 위에만 바뀌는게 아니라 전부 다 같이 바뀜
					//$('.careInfoId').val(item.careInfoId);
					
					$('#careDate'+cnt+'').val(item.careDate);
					console.log('최종 careInfoIdArr 배열 !-> '+careInfoIdArr);
					console.log('최종 careDateArr 배열 !-> '+careDateArr);
					//console.log('select변경 후 cnt-> '+cnt);
					//console.log('careInfoId-> '+item.careInfoId);
					//console.log('careDate-> '+item.careDate);
					return;
				});
			}
		});
	};
	
	// [-] 버튼 클릭 - 필요없는 내용 삭제할 때
	function minusFunction(){
		let trCnt = $('#planTable tr').length;
		//console.log('삭제 전 tr 개수->'+trCnt);
		
		if(trCnt > 0){
			$('#planTable tr:last').remove();
			cnt -= 1;	// [-] 클릭하면 숫자 빼기
			careInfoIdArr.pop();
			careDateArr.pop();
			console.log('-클릭 후 cnt-> '+cnt);
			console.log('careInfoIdArr 배열 !-> '+careInfoIdArr);
			console.log('careDateArr 배열 !-> '+careDateArr);
		} else{
			alert('정기검진은 삭제 할 수 없습니다.');
			return;
		}
		
		trCnt = $('#planTable tr').length;
		console.log('삭제 후 tr 개수->'+trCnt);
	};
	
	//form 제출 함수
	function submitFun(){
		console.log('등록버튼 클릭');
		if($('#animalId').val() == 0){
			alert('동물을 먼저 선택해주세요');
			return;
		}
		
		$('#careInfoId').val(careInfoIdArr);
		$('#careDate').val(careDateArr);
		
		$('#addForm').submit();
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