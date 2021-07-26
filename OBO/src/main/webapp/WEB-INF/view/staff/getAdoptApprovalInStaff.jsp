<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getAdoptApprovalInStaff</title>

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
	$('#searchBtn').click(function(){
		console.log('검색버튼 클릭!');
		
		// 유효성 검사
		if($('#searchWord').val() == ''){
			alert('검색어를 입력해주세요');
		} else{
			$('#searchForm').submit();
		}
		
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
					<h3>입양&케어 > 입양 > 승인목록</h3>
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
							<!-- 검색결과 -->
							<div>
								<c:if test="${selectOption == 'animal'}">
									[${selectOption}]
								</c:if>
								<c:if test="${selectOption == 'member'}">
									[${selectOption}]
								</c:if>
								<c:if test="${searchWord != null}">
									"${searchWord}" 검색결과 &nbsp;<a href="${pageContext.request.contextPath}/staff/getAdoptApprovalInStaff"><button class="btn" type="reset"><i class="fa fa-refresh"></i></button></a>
								</c:if>
							</div>
							
							<br>
							<table class="table">
								<tr>
									<td>동물</td>
									<td>회원정보</td> <!-- 이름(아이디) -->
									<td>신청서류</td> <!-- 클릭 시 다운로드 -->
									<td>신청일</td>
									<td>입양일</td>
									<td>확인직원</td>
									<td style="text-align:center;">케어Plan</td>
								</tr>
								<c:forEach var="a" items="${adoptApprovalList}">
									<tr>
										<td>${a.animalName}</td>
										<td>${a.memberName}(${a.memberId})</td>
										<td>${a.adoptApplyDocumentId}</td>
										<td>${a.applyDate}</td>
										<td>${a.adoptDate}</td>
										<td>${a.staffId}</td>
										<td style="text-align:center;">
											<a id="carePlanBtn" data-toggle="modal" data-target="#carePlan-modal" onclick="carePlanFunc('${a.animalName}','${a.animalId}', '${a.memberId}', '${a.adoptDate}');">
												<i class="fa fa-external-link"></i>
											</a>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					
					<!-- 페이징 & 검색 -->
					<div class="search_form">
					<div class="blog_left_sidebar">
					
						<!-- 페이징 -->
						<nav class="blog-pagination justify-content-center d-flex">
							<ul class="pagination">
								<!-- 이전 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/" class="page-link" aria-label="Previous"><i class="ti-angle-left"></i></a>
								</li>
								<li class="page-item"><a href="${pageContext.request.contextPath}/staff/" class="page-link">1</a></li>
								<li class="page-item active"><a href="${pageContext.request.contextPath}/staff/" class="page-link">2</a></li>
								
								<!-- 다음 페이지 setting -->
								<li class="page-item">
									<a href="${pageContext.request.contextPath}/staff/" class="page-link" aria-label="Next"><i class="ti-angle-right"></i></a>
								</li>
							</ul>
						</nav>
						<hr>
						
						<!-- 검색 -->
						<form id="searchForm" action="${pageContext.request.contextPath}/staff/getAdoptApprovalInStaff">
							<div class="form-group">
								<div class="input-group mb-4">
									<select id="selectOption" class="select_box" name="selectOption">
										<c:if test="${selectOption == 'animal'}">
											<option value="animal" selected>동물 이름</option>
										</c:if>
										<c:if test="${selectOption != 'animal'}">
											<option value="animal">동물 이름</option>
										</c:if>
										<c:if test="${selectOption == 'member'}">
											<option value="member" selected>회원정보</option>
										</c:if>
										<c:if test="${selectOption != 'member'}">
											<option value="member">회원정보</option>
										</c:if>
									</select>
									<input type="text" id="searchWord" class="form-control" name="searchWord" placeholder="검색어를 입력해주세요"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '검색어를 입력해주세요'" >
									<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
								</div>
							</div>
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
	
	<!-- 케어플랜 모달 -->
	<div class="modal fade" id="carePlan-modal" role="dialog" aria-labelledby="carePlan-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title"> <span id="inputName"></span></h4>
					<br>
					<div>
						<div id="inputText"></div>
						<table id="inputTable" class="table" style="text-align:center;">
						</table>
						
						<div id="inputTextNon"></div>
						<form id="addForm" action="${pageContext.request.contextPath}/staff/addCarePlanInStaff" method="post">
							<div id="hiddenValue"></div>
							<table id="inputTableNon" class="table">
							</table>
						</form>
					</div>
					<span id="whichBtn"></span>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	function carePlanFunc(name, aniId, memId, date){
		console.log('modal클릭');
		let animalId = aniId;
		let memberId = memId;
		console.log('넘어온값 name?-> '+name);
		console.log('넘어온값 animal id?-> '+aniId);
		console.log('넘어온값 member id?-> '+memId);
		console.log('넘어온값 date?-> '+date);
		
		$('#inputName').text(name+'의 carePlan * 입양일 '+date);
		
		//작성된 care plan
		$.ajax({
			url: '${pageContext.request.contextPath}/getCarePlanAnimalOne',
			type: 'get',
			data: {animalId : animalId},
			dataType: 'json',
			success: function(jsonData){
				console.log('care plan 작성목록 ajax');
				if(jsonData == 0){	//작성된 care plan이 없음
					console.log('작성목록 없습니다. jsonData 0');
					
					// 기존 값들 비우기
					$('#inputTable').empty();
					$('#inputTableNon').empty();
					$('#inputTextNon').empty();
					$('#hiddenValue').empty();
					
					// 제목 다시 적어주고, 다른 버튼 보여주기
					$('#inputText').text('작성된 carePlan 없음');
					$('#whichBtn').html(
							'<button class="genric-btn primary-border radius" onclick="addNewCPFunc();">새로 작성</button>'
							+' <button class="genric-btn primary-border radius" data-dismiss="modal">취소</button>'
					);
					return;
				}
				
				console.log('작성목록 있음 json 1이상');
				$('#inputText').text('작성된 carePlan');
				
				let addTable = "";
				
				$(jsonData).each(function(index, item){
					addTable += '<tr>';
					addTable += 	'<td><input class="form-control" type="text" value="'+item.careInfo+'" readonly></td>';
					addTable +=		'<td><input class="form-control" type="date" value="'+item.careDate+'" readonly></td>';
					addTable += '</tr>';
				});

				$('#inputTable').empty();
				$('#inputTable').append(addTable);
				
				//미작성 care plan
				$.ajax({
					url: '${pageContext.request.contextPath}/getCarePlanAnimalOneNon',
					type: 'get',
					data: {animalId : animalId},
					success: function(json){
						console.log('care plan 미작성 불러오기');
						if(json == 0){
							console.log('care plan 미작성 없음~');
							$('#inputTextNon').text('미작성 carePlan 없음');
							$('#whichBtn').html(
									'<button class="genric-btn primary-border radius" data-dismiss="modal">확인</button>'
							);
							return;
						}
						console.log('care plan 미작성 있음');
						$('#inputTextNon').text('미작성 carePlan * 추가할 항목을 선택하세요');
						let addTableNon = "";
						
						$(json).each(function(index, item){
							addTableNon += '<tr>';
							//addTableNon += 	'<td><div class="row">';
							addTableNon += 	'<td style="padding-right:10 0em;">';
							addTableNon += 		'<input type="checkbox" name="aboutCare" value="'+item.careDate+','+item.careInfoId+'" style="vertical-align:middle;">';
							addTableNon +=	'</td>';
							addTableNon += 	'<td><input class="form-control" type="text" value="'+item.careInfo+'" readonly style="float:right;"></td>';
							//addTableNon += 	'</div></td>';
							addTableNon +=	'<td><input class="form-control" type="date" value="'+item.careDate+'" readonly></td>';
							addTableNon += '</tr>';
						});

						$('#inputTableNon').empty();
						$('#inputTableNon').append(addTableNon);
						$('#hiddenValue').html(
								'<input id="animalId" name="animalId" value="'+animalId+'" type="hidden">'
								+'<input id="memberId" name="memberId" value="'+memberId+'" type="hidden">'
								+'<input id="careInfoId" name="careInfoId" type="hidden">'
								+'<input id="careDate" name="careDate" type="hidden">'
						);
						$('#whichBtn').html(
								'<button class="genric-btn primary-border radius" onclick="addOtherCPFunc();">추가</button>'
								+' <button class="genric-btn primary-border radius" data-dismiss="modal">취소</button>'
						);
					}
				}); //-미작성 care plan ajax
			} //-ajax 성공 후
		}); //-작성된 care plan ajax
		
		//ajax -> 케어 기록이 없으면 등록하러 이동 ->
		//ajax -> 케어 기록이 있으면 간략하게 보여주고 추가할 내용 아래에 바로 추가할 수 있도록
	}
	
	//care plan 새로작성
	function addNewCPFunc(){
		console.log('새로 작성');
		alert('carePlan 작성 페이지로 이동합니다.');
		//plan 작성 페이지로 이동
		location.href='${pageContext.request.contextPath}/staff/addCarePlanInStaff';
	}
	
	//care plan 기존 외 추가
	function addOtherCPFunc(){
		console.log('다른 내용 추가');
		//console.log('aboutCare 값-> '+$('#aboutCare').val());
		console.log('체크박스 선택개수?->'+$("input:checkbox[name=aboutCare]:checked").length);
		if($("input:checkbox[name=aboutCare]:checked").length == 0){
			alert('추가할 항목을 선택해주세요');
			return;
		}
		
		let careInfoId = [];
		let careDate = [];
		
		$('input:checkbox[name=aboutCare]:checked').each(function(){
			//console.log('값확인'+$(this).val()); //-> xxxx-xx-xx,num
			//console.log('값확인'+$(this).val().slice(0,10)); //->xxxx-xx-xx
			//console.log('값확인'+$(this).val().slice(11));	//->num
			careInfoId.push($(this).val().slice(11));
			careDate.push($(this).val().slice(0,10));
		});
		
		console.log('careInfoId'+careInfoId);
		console.log('careDate'+careDate);
		
		//값 설정
		$('#careInfoId').val(careInfoId);
		$('#careDate').val(careDate);
		
		
		$('#addForm').submit();
	}
	
	</script>
	
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