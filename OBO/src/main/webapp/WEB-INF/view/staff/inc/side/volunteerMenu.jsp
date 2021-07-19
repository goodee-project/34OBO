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
	<h4 class="widget_title">일반봉사</h4>
	<ul class="list cat-list">
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerRecruitN" class="d-flex"><p>모집공고</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerApplyN" class="d-flex"><p>신청목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN" class="d-flex"><p>확인목록</p></a>
		</li>
	</ul>
	<br>
	<h4 class="widget_title">정기봉사</h4>
	<ul class="list cat-list">
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerRecruitP" class="d-flex"><p>모집공고</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerApplyP" class="d-flex"><p>신청목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getVolunteerCheckP" class="d-flex"><p>확인목록</p></a>
		</li>
	</ul>
</body>
</html>