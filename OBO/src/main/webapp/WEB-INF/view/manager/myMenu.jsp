<!-- 작성자 : 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="header-top_area">
	<div class="container">
		<div class="row">
		<!-- 로그인 전 -->
		<c:if test="${loginManager == null}">
			<div class="col-lg-8 col-md-8">
				<div class="short_contact_list">
					<form id="loginForm" action="${pageContext.request.contextPath}/m/login" method="post">
						<ul>
							<li><span style="color:white">ID</span>&nbsp;</li>
							<li><input class="form-control" type="text" id="managerId" name="managerId" style="width:150px; height:30px"></li>&emsp;
							<li><span style="color:white">PW</span>&nbsp;</li>
							<li><input class="form-control" type="password" id="managerPw" name="managerPw" style="width:150px; height:30px"></li>&emsp;
							<li><button type="button" id="loginBtn" class="genric-btn primary-border circle arrow medium">LOGIN</button></li>&emsp;
						</ul>
					</form>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-4">
				<div class="social_media_links">
					<a href="${pageContext.request.contextPath}/home">회원페이지</a>
					<a href="${pageContext.request.contextPath}/s/home">직원페이지</a>
				</div>
			</div>
		</c:if>
			
		<!-- 로그인 후 -->
		<c:if test="${loginManager != null}">
			<div class="col-lg-12 col-md-4 ">
				<div class="social_media_links">
					<form id="logout" action="${pageContext.request.contextPath}/m/logout">
						<span class="text-white font-weight-bolder">${loginManager.managerName} 님, 반갑습니다!</span>
						<a href="${pageContext.request.contextPath}/m/logout"><button type="button" class="genric-btn primary-border circle arrow medium">LOGOUT</button></a>
					</form>
				</div>
			</div>
		</c:if>
		</div>
	</div>
</div>
</body>
</html>