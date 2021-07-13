<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffMenu</title>
</head>
<body>
	<!--staffMenu(inc) 홈, 동물, 보호소, 후원, 봉사, 입양&케어-->
	<a href="${pageContext.request.contextPath}/staff/#"><span>홈</span></a>
	<a href="${pageContext.request.contextPath}/staff/#"><span>동물</span></a>
	<a href="${pageContext.request.contextPath}/staff/#"><span>보호소</span></a>
	<a href="${pageContext.request.contextPath}/staff/#"><span>후원</span></a>
	<a href="${pageContext.request.contextPath}/staff/#"><span>봉사</span></a>
	<a href="${pageContext.request.contextPath}/staff/#"><span>입양&케어</span></a>
	<a href="${pageContext.request.contextPath}/staff/logout"><span>임시 로그아웃</span></a>
</body>
</html>