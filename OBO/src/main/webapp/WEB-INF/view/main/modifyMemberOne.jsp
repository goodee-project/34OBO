<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 다음 우편번호 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	th{
		width: 30%;
	}
	
	td{
		width: 70%;
	}
</style>
<script>

$(document).ready(function(){
	$('#modifyMemberFormBtn').click(function(){
		console.log('click');
		
		if($('#memberName').val() == ''){
		
			alert('이름을 입려해주세요.');
			$('#memberName').focus();
			
		} else if($('#memberPhone').val() ==''){
			alert('휴대폰 번호를 입력해주세요.')
			$('#memberPhone').focus();
			
		} else if($('#memberBirth').val() ==''){
			alert('생일를 입력해주세요.')
			$('#memberBirth').focus();
			
		} else if($('#memberEmail').val() ==''){
			alert('이메일을 입력해주세요.')
			$('#memberEmail').focus();
			
		} else if(mailChecked == false){
			alert('이메일을 인증해주세요.')
			$('#memberEmail').focus();
			
		} else if($('#memberNickname').val() ==''){
			alert('닉네임을 입력해주세요.')
			$('#memberNickname').focus();
			
		} else{
			$('#modifyMemberForm').submit();
		}
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
					<h3>내정보 수정</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>			
				
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
							<form id="modifyMemberForm" action="${pageContext.request.contextPath}/member/modifyMemberOne" method="post">
								<input type="hidden" name="address.addressId" value="${memberOne.addressId}">
								<table class="table">
									<tr>
										<th>아이디</th>
										<td>
											<input id="memberId" name="member.memberId" type="text" readonly="readonly" value="${memberOne.memberId}">
										</td>
									</tr>
									<tr>
										<th>이름</th>
										<td><input id="memberName" name="member.memberName" type="text" value="${memberOne.memberName}"></td>
									</tr>
									<tr>
										<th>닉네임</th>
										<td><input id="memberNickname" name="member.memberNickname" type="text" value="${memberOne.memberNickname}"></td>
									</tr>
									<tr>
										<th>주소</th>
										<td>
											<input type="text" id="sample4_postcode" name="address.postCode" placeholder="우편번호" value="${memberOne.postCode}">
											<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="genric-btn default-border radius"><br>
											<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="address.doro" value="${memberOne.doro}">
											<span id="guide" style="color:#999;display:none"></span>
											<div>
												<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="address.detailAddress" value="${memberOne.detailAddress}">		
											</div>
											
										</td>
									</tr>
									
									<tr>
										<th>연락처</th>
										<td><input id="memberPhone" name="member.memberPhone" type="text" value="${memberOne.memberPhone}"></td>
									</tr>
									<tr>
										<th>생일</th>
										<td><input id="memberBirth" name="member.memberBirth" type="date" value="${memberOne.memberBirth}"></td>
									</tr>
									<tr>
										<!-- 이메일 인증 넣기 -->
										<th>이메일</th>
										<td>
											<input id="memberEmail" name="member.memberEmail" type="text" value="${memberOne.memberEmail}">
											<button id="sendMail" type="button" class="genric-btn default-border radius">인증메일 발송</button>
											
											<div>
												<input id="emailCheck" type="text" placeholder="인증코드">
											</div>
											<div>
												<span id="mailTarget"></span>
											</div>
										</td>
									</tr>
									
									
									<tr>
										<th>성별</th>
										<td>
											<input name="member.memberGender" type="radio" class="primary-radio" value="남" ${memberOne.memberGender == '남'? 'checked="checked"': '' }>
												<label for="primary-radio">남</label>
											<input name="member.memberGender" type="radio" class="primary-radio" value="여" ${memberOne.memberGender == '여'? 'checked="checked"': '' }>
												<label for="primary-radio">여</label>
										</td>
									</tr>
										<!-- 로봇이 아닙니다. google 보안기능 넣기 -->	
								</table>
								<button id="modifyMemberFormBtn" type="button" class="genric-btn primary-border radius">수정</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
<script>
	//메일 인증코드
	let mailKey;
	let mailChecked;
	
	//이메일 내용을 변경하는 순간 이메일 인증이 필요하게된다.
	$('#memberEmail').on("propertychange change keyup paste input", function() {
		mailChecked = false;
	});
	
	
	$("#emailCheck").on("propertychange change keyup paste input", function() {
		if ($("#emailCheck").val() == mailKey) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
			$("#mailTarget").text("인증 성공").css("color", "black");
			$('#memberEmail').attr( 'readonly', 'readonly');
			mailChecked = true;  //인증 성공여부 check
		} else {
			$("#mailTarget").text("불일치").css("color", "red");
			mailChecked = false; //인증 실패
		}
	});
	
	//email 확인하기!
	$("#sendMail").click(function() {// 메일 입력 유효성 검사
		let mail = $("#memberEmail").val(); //사용자의 이메일 입력값.
		
		if (mail == "") {
			alert("메일 주소가 입력되지 않았습니다.");
		} else {
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/checkMail',
				data : {mail:mail},
				success: function(jsonData){
					alert("인증번호가 전송되었습니다.");
					mailKey = jsonData;
					console.log(mailKey);
									
				}
			});
			
		}
	});
	

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                
            }
        }).open();
    }
</script>
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