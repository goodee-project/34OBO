<!-- 작성자: 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입양</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
<style>
	textarea {
		height: 80px;
		width: 900px;
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
	
	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h3>입양 신청서</h3>
				</div>
			</div>
		</div>
	</div>
	
	<!--================Blog Area =================-->

	<div class="card align-items-center">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-12 col-md-12">
					<div class="single_service staff_account">
						<div class="service_content text-center">
								<hr>
								<ul class="text-left">
									<li><h4><strong>신청 전 주의사항</strong></h4></li>
									<li>1. 입양신청서를 작성하여 제출한다고 하여 확정 승인이 보장되지는 않습니다.</li>
									<li>2. 동일 견에 대해 여러 신청서가 들어올 경우 입양이 우선 진행, 가장 적합한 환경으로 진행됩니다.</li>
									<li>3. 12세 미만 아동이 있으실 경우 입양이 제한되실 수 있습니다.</li>
									<li>4. 다견다묘가정의 경우 합이 3마리 이상일때 입양이 반려될 수 있습니다.</li>
									<li>5. 27세미만은 주 신청자가 될수없습니다.</li>
									<li> 상기 사항들을 염두에 두시고 하기 입양 신청서를 작성해주세요.</li>
								</ul>
								<hr>
								<form action="${pageContext.request.contextPath}/addAdoptForm" method="post" id="adoptForm">
								<input type="text" name="animalId" value="${animalId}" hidden="hidden">
								<div>
									1. 반려동물의 안전한 입양 및 임시보호 절차 진행을 위해 개인정보 및 홈체킹, 주거지와 본인 및 가족 정보를 요청하고 있습니다. <br>해당 정보는 입양 이외의 용도로 사용되지 않습니다. 이에 동의 하십니까?
									<textarea class="question" name="q1" id="q1"></textarea><hr>
								</div>
								<div>
									2. 동물의 응급상황은 무엇일까요?
									<textarea class="question" name="q3" id="q2"></textarea><hr>
								</div>
								<div>
									3. 해당 동물의 입양을 결심하시게 된 이유는 무엇이며, 앞으로 함께 어떻게 살고 싶으신가요?
									<textarea class="question" name="q8" id="q3"></textarea><hr>
								</div>
								<div>
									4. 현재 하시는 일은 무엇입니까? (직장인, 주부, 대학생, 미성년자(용돈) 등등) <br>동물을 케어하는데는 항상 금전적인 비용이 발생 하기에 신청자분의 직업을 간략하게 파악하고자 합니다.)
									<textarea class="question" name="q14" id="q4"></textarea><hr>
								</div>
								<div>
									5. 본인 이외 가족의 이름/ 관계/ 휴대폰번호 작성해주세요. <br>(지인, 친구 연락처는 불가. 신혼부부의 경우 양가의 연락처를 다 적어주세요. 1인 가구여도 같이 살지 않는 가족 연락처로 적어주세요.)
									<textarea class="question" name="q16" id="q5"></textarea><hr>
								</div>
								<div>
									6. 가족 구성원을 알려주세요 (본인외에 함께 거주할 가족의 구성원과 인원을 알려주세요. <br>(ex; 남편(00세) 딸(00세) 아들(00세)
									<textarea class="question" name="q17" id="q6"></textarea><hr>
								</div>
								<div>
									7. 가족 구성원은 모두 입양에 찬성하였나요? 혹은 알러지가 있는 가족은 있지 않나요? <br>(가족 구성원 중 강력하게 반대하는 분이 있을 경우 더 이상의 진행이 어려울 수 있습니다.)
									<textarea class="question" name="q18" id="q7"></textarea><hr>
								</div>
								<div>
									8. 가족 구성원에 변화가 생길 수 있나요? <br>(결혼, 분가 등등/ 미혼이거나 신혼부부의 경우 추후 결혼 또는 자녀계획에 대해서 생각해보시고 적어주시기 바랍니다.)
									<textarea class="question" name="q19" id="q8"></textarea><hr>
								</div>
								<div>
									9. 현재 주거지는 어떠한 형태 입니까? <br>(빌라, 다세대, 원룸, 아파트, 전세 단독 주택 등등/ 혹시 집주인은 반려동물을 허용하는 곳인가요?)
									<textarea class="question" name="q20" id="q9"></textarea><hr>
								</div>
								<div>
									10. 반려동물의 거주지 (ex; 실내, 실외, 기타(베란다, 테라스 등)
									<textarea class="question" name="q21" id="q10"></textarea><hr>
								</div>
								<div>
									11. 반려동물이 혼자 집에 있는 일일 평균 시간과 평균 산책 횟수 <br>(ex; 하루 평균 8시간/ 1일 1회 또는 1주에 4회 등)
									<textarea class="question" name="q23" id="q11"></textarea><hr>
								</div>
								<div>
									12. 외출, 여행, 외근, 출장 등의 이유로 집을 비우는 동안 반려동물을 어떻게 하실 예정이십니까?
									<textarea class="question" name="q24" id="q12"></textarea><hr>
								</div>
								<div>
									13. 과거 혹은 현재 함께 하는 반려동물이 있으십니까? 과거 혹은 현재 함께하는 반려동물은 중성화 되어있나요? <br>(있었거나 있다면 동물의 종류와, 왜 현재는 같이 살지 않는지 또는 같이 사는지 알려주세요. 노환으로 자연사, 질병으로 사망, 사고로 사망, 분가로 본가에 있음, 짖음으로 파양, 안락사 등 함께 거주하지 않는 이유를 솔직하게 적어주세요. <br>만약 과거나 현재 함께 했던 반려동물이 없다면 이 질문을 보고 어떠한 생각이 드는지 작성해주세요.)
									<textarea class="question" name="q25" id="q13"></textarea><hr>
								</div>
								<div>
									14. 새로 입양하는 아이를 기존 반려동물에게 어떻게 소개 할지 또는 합사를 고민해보신적이 있나요? <br>기존 반려동물과 싸움이 생기면 분리 할 수 있나요? <br>합사까지 얼마의 시간적인 여유를 주실 수 있나요? <br>(합사가 안될경우에 어떻게 할지도 알려주세요.)
									<textarea class="question" name="q27" id="q14"></textarea><hr>
								</div>
								<div>
									15. 용납할 수 없는 반려동물의 행동이 있다면 구체적으로 작성해주세요. 반려동물이 용납할 수 없는 행동을 할 경우 어떠한 노력을 하시겠습니까? <br>(없을 경우 '없음'으로 작성해주세요. 용납하기 어려운 행동이 있을 경우 어떤 행동인지 ex; 지나친 사나움, 배변을 먹는 행위 등, <br>그러한 행동을 해결하기 위한 노력 방법을 구체적으로 적어주세요. 
									<textarea class="question" name="q29" id="q15"></textarea><hr>
								</div>
								<div>
									16. 반려동물 매년 검진 비용을 얼마정도 생각하시나요? (치아, 접종, 사상충, 예방약 등등)
									<textarea class="question" name="q34" id="q16"></textarea><hr>
								</div>
								<div>
									17. 입양 반려동물에게 예상되는 초기 비용은 얼마입니까? (개집, 하네스 목줄 리드줄, 장난감, 간식 등등)
									<textarea class="question" name="q35" id="q17"></textarea><hr>
								</div>
								<br>
								<button type="button" id="adoptFormBtn" class="genric-btn primary-border radius float-right">제출하기</button>
								<br>
								</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================Blog Area =================-->
	
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
$(document).ready(function(){
	$('#adoptFormBtn').click(function(){
		var ck = confirm('제출한 서류는 수정 되지 않습니다. 정말로 입양신청서를 제출하시겠습니까?');
		var count = 0;
		if(ck==true){
			for(var i=1; i<=17; i++){
				if($('#q'+i).val()==''){
					alert('내용을 입력해주세요.');
					$('#q'+i).focus();
					break;
				} else {
					count +=1;
				}
			}
			if(count == 17) {
				console.log('입양');
				$('#adoptForm').submit();
			}
		} else {
			return false;
		}
	});
});
</script>
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