<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyStaffLevel</title>
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
	let idBtn = false;
	let pwCheck = false;
	
	// 대기중 클릭 시 level 변경하는 모달 창
	$(document).on('click', '#levelClick', function(e){
		console.log('대기중 클릭');
		console.log('클릭 value!!!!!!!!!!!'+e.target.value);
		
		let staffId = e.target.value;
		
		$(document).on('click', '#levelCkBtn', function(){
			console.log('승인확인 클릭!');
			$.ajax({
				url: '${pageContext.request.contextPath}/changeStaffState',
				type: 'post',
				dataType: 'json',
				data: {staffId : staffId,
						staffLevel : 1},
				success: function(jsonData){
					if(jsonData != 1){
						alert('수정 실패.');
						return;
					}
					console.log('level 수정 완료!');
					location.href='${pageContext.request.contextPath}/staff/modifyStaffState';	//일치하면 페이지 이동
				}
			});
		});
	});
	
	// 수정 클릭 시 active 변경하는 모달 창
	$(document).on('click', '#activeClick', function(e){
		console.log('수정&비활성 클릭');
		console.log('클릭 value!!!!!!!!!!!'+e.target.value);
		
		let staffId = e.target.value;
		//let staffActive = e.target.
		
		$(document).on('click', '#activeCkBtn', function(a){
			console.log('level 선택 후 확인버튼 클릭!');
			
			let staffActive = a.target.value;
			let staffActive2 = $('#staffActive').val();
			console.log('staffActive?!'+staffActive2);
			
			$.ajax({
				url: '${pageContext.request.contextPath}/changeStaffState',
				type: 'post',
				dataType: 'json',
				data: {staffId : staffId,
						staffActive : $('#staffActive').val()},
				success: function(jsonData){
					if(jsonData != 1){
						alert('수정 실패');
						return;
					}
					console.log('active 수정 완료!');
					location.href='${pageContext.request.contextPath}/staff/modifyStaffState';	//일치하면 페이지 이동
				}
			});
		});
	});
	
	// 가입 버튼 클릭 시 -> 유효성 검사 필요
	$('#modifyBtn').click(function(){
		console.log('modifyBtn 버튼 클릭!');
		$('#modifyForm').submit();
		
		//보호소 -> 이름 -> 아이디 -> 패스워드 -> 연락처 -> 이메일
		/*
		if($('#staffName').val() == null){
			alert('이름을 입력하세요.');
		} else if(idBtn == false){
			alert('ID 중복확인은 필수입니다.');
		} else if(pwCheck == false){
			alert('PW를 정확하게 입력하세요.');
		} else if($('#staffPhone').val().length != 11){
			alert('연락처는 13자리입니다.');
		} else if($('#staffEmail').val() == null){
			alert('email을 입력하세요.');
		} else{
			$('#addForm').submit();
		}*/
	});
	
	// 정보 수정 클릭 시 pw 입력하는 모달 창
	$('#myAccountClick').click(function() {
		console.log('정보 수정 클릭');
		
		$('#ckBtn').click(function(){
			console.log('pw 입력 후 확인버튼 클릭!');
			$.ajax({
				url: '${pageContext.request.contextPath}/checkStaffPw',
				type: 'post',
				data: {staffPw : $('#staffPw').val()},
				success: function(jsonData){
					// console.log('계정클릭 ajax 성공!');
					if(jsonData != 1){
						alert('PW가 일치하지 않습니다.');
						return;
					}
					console.log('pw일치!');
					location.href='${pageContext.request.contextPath}/staff/modifyStaff';	//일치하면 페이지 이동
				}
			});	// ajax; pw 일치
		});	// ckBtn; 모달창 pw 입력 후 확인버튼 클릭
	});	// myAccountClick; 내 정보 클릭
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
					<h3>상태 관리</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<ul class="list cat-list">
								<li>
									<a href="${pageContext.request.contextPath}/staff/modifyStaff" class="d-flex"
										id="myAccountClick" data-toggle="modal" data-target="#login-modal"><p>정보 수정</p></a>
								</li>
								<li>
									<c:if test="${loginStaff.staffLevel == 2}">
										<a href="${pageContext.request.contextPath}/staff/modifyStaffState" class="d-flex"><p>상태 관리</p></a>
									</c:if>
								</li>
							</ul>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div id="but" class="blog_details">
							<div>* 마스터 계정의 레벨은 변경할 수 없습니다.</div>
							<br>
							<table class="table" style="text-align:center;">
								<tr>
									<td>ID</td>
									<td>이름</td>
									<td>레벨</td>
									<td>상태</td>
								</tr>
								<c:forEach var="s" items="${staffList}">
									<tr>
										<td>${s.staffId}</td>
										<td>${s.staffName}</td>
										<td>${s.staffLevel}</td>
										<td>
											<c:if test="${s.staffLevel == 0}">
												<button type="button" class="genric-btn default-border radius" value="${s.staffId}"
														id="levelClick" data-toggle="modal" data-target="#level-modal">${s.state}</button>
											</c:if>
											<c:if test="${s.staffLevel == 1}">
												<button type="button" class="genric-btn default-border radius" value="${s.staffId}"
														id="activeClick" data-toggle="modal" data-target="#active-modal">${s.state}</button>
											</c:if>
											<c:if test="${s.state == '마스터'}">
												<button id="stateBtn" type="button" class="genric-btn default-border radius" disabled>${s.state}</button>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- pw 모달 -->
	<div class="modal fade" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">비밀번호를 입력하세요</h5>
					<br>
					<input id="staffPw" class="form-control" type="password"  name="password" placeholder="PW 입력" required="required"> <br />
					<div style="float:right;">
						<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
						<button id="ckBtn" type="button" class="genric-btn primary-border radius">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- level 변경 모달 -->
	<div class="modal fade" id="level-modal" role="dialog" aria-labelledby="level-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">계정 승인 하시겠습니까?</h4>
					<br>
					<br>
					<button id="levelCkBtn" type="button" class="genric-btn primary-border radius">확인</button>
					<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- active 변경 모달 -->
	<div class="modal fade" id="active-modal" role="dialog" aria-labelledby="active-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h4 class="modal-title">active을 선택해주세요</h4>
					<br>
					<div class="form-control">
						staffActive 
						<select id="staffActive" name="staffActive">
								<option value="1">활성</option>
								<option value="0">비활성</option>
						</select>
					</div>
					<br>
					<button id="activeCkBtn" type="button" class="genric-btn primary-border radius">확인</button>
					<button type="button" class="genric-btn primary-border radius" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

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