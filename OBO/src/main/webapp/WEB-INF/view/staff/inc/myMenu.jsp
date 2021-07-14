<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<!-- 로그인 전 -->
	<c:if test="${loginStaff == null}">
		<div class="col-lg-10 col-md-8">
			<div class="short_contact_list">
				<form id="loginForm" action="${pageContext.request.contextPath}/staff/login" method="post">
					<ul>
						<li><span style="color:white">ID</span>&nbsp;</li>
						<li><input class="form-control" type="text" id="staffId" name="staffId" style="width:150px; height:30px"></li>&emsp;
						<li><span style="color:white">PW</span>&nbsp;</li>
						<li><input class="form-control" type="password" id="staffPw" name="staffPw" style="width:150px; height:30px"></li>&emsp;
						<li><button type="button" id="loginBtn" class="genric-btn primary-border circle arrow medium">LOGIN</button></li>&emsp;
						<li><a href="${pageContext.request.contextPath}/staff/addStaff">가입</a></li>
					</ul>
				</form>
			</div>
		</div>
		
		<div class="col-lg-2 col-md-4">
			<div class="social_media_links">
				<a href="${pageContext.request.contextPath}/home">회원페이지</a>
			</div>
		</div>
	</c:if>
		
	<!-- 로그인 후 -->
	<c:if test="${loginStaff != null}">
		<div class="col-lg-12 col-md-4 ">
			<div class="social_media_links">
				<form id="logout" action="${pageContext.request.contextPath}/staff/logout">
					<span class="text-white font-weight-bolder">${loginStaff.staffName}님, 반갑습니다!</span>
					<a href="${pageContext.request.contextPath}/staff/getStaffAccount" class="text-white font-weight-bolder">계정</a>
					<a href="${pageContext.request.contextPath}/staff/logout"><button type="button" class="genric-btn primary-border circle arrow medium">LOGOUT</button></a>
				</form>
			</div>
		</div>
	</c:if>
</body>
</html>