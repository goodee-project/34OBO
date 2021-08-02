<!-- 작성자 : 이윤정 -->
<!-- 수정 : 남궁혜영(21.07.14) -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
$(document).ready(function(){
	// 로그인 버튼 클릭 시
	$('#loginBtn').click(function(){
		console.log('loginBtn 버튼 클릭!');
		
		// 유효성 검사
		if($('#loginStaffId').val() == ''){
			alert('ID를 입력해주세요.');
			$('#loginStaffId').focus();
		} else if($('#loginStaffPw').val() == ''){
			alert('PW를 입력해주세요.');
			$('#loginStaffPw').focus();
		} else{	// 일치&불일치 확인
			$.ajax({
				url: '/obo/checkStaffLogin',
				type: 'get',
				data: { loginStaffId : $('#loginStaffId').val(),
						loginStaffPw : $('#loginStaffPw').val()},
				success: function(jsonData){
					console.log('로그인 유효성 검사 ajax 성공');
					if(jsonData != 1){
						alert('존재하지 않는 ID이거나 혹은 PW가 일치하지 않습니다.');
						return;
					}
				}
			});
			
			// submit
			$('#loginForm').submit();
		}
	});
});
</script>
</head>
<body>
	<div class="header-top_area">
		<div class="container">
			<div class="row">
			
				<!-- 로그인 전 -->
				<c:if test="${loginStaff == null}">
					<div class="col-lg-8 col-md-8">
						<div class="short_contact_list">
							<form id="loginForm" action="${pageContext.request.contextPath}/s/login" method="post">
								<ul>
									<li><span style="color:white">ID</span>&nbsp;</li>
									<li><input class="form-control" type="text" id="loginStaffId" name="loginStaffId" style="width:150px; height:30px"></li>&emsp;
									<li><span style="color:white">PW</span>&nbsp;</li>
									<li><input class="form-control" type="password" id="loginStaffPw" name="loginStaffPw" style="width:150px; height:30px"></li>&emsp;
									<li><button type="button" id="loginBtn" class="genric-btn primary-border circle arrow medium">LOGIN</button></li>&emsp;
									<li><a href="${pageContext.request.contextPath}/staff/addStaff">가입</a></li>
								</ul>
							</form>
						</div>
					</div>
					
					<div class="col-lg-4 col-md-4">
						<div class="social_media_links">
							<a href="${pageContext.request.contextPath}/home">회원페이지</a>
							<a href="${pageContext.request.contextPath}/m/">관리자페이지</a>
						</div>
					</div>
				</c:if>
					
				<!-- 로그인 후 -->
				<c:if test="${loginStaff != null}">
					<div class="col-lg-12 col-md-4 ">
						<div class="social_media_links">
							<form id="logout" action="${pageContext.request.contextPath}/s/logout">
								<span class="text-white font-weight-bolder">${loginStaff.staffName}님, 반갑습니다!</span>
								<a href="${pageContext.request.contextPath}/s/getStaffAccount" class="text-white font-weight-bolder">계정</a>
								<a href="${pageContext.request.contextPath}/s/logout"><button type="button" class="genric-btn primary-border circle arrow medium">LOGOUT</button></a>
							</form>
						</div>
					</div>
				</c:if>
				
			</div>
		</div>
	</div>
</body>
</html>