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
			<a href="${pageContext.request.contextPath}/staff/getAnimalList" class="d-flex"><p>동물 목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/addAnimal" class="d-flex"><p>동물 등록</p></a>
		</li>
	</ul>
</body>
</html>