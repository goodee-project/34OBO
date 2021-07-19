<!-- 작성자 : 이윤정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>volunteerMenu</title>
</head>
<body>
	<ul class="list cat-list">
		<li>
			<a href="${pageContext.request.contextPath}/staff/shelterIntro" class="d-flex"><p>보호소 소개</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/modifyShelter" class="d-flex"><p>정보 수정</p></a>
		</li>
	</ul>
</body>
</html>