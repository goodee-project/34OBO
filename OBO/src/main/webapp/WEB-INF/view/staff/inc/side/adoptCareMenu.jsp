<!-- 작성자 : 이윤정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adoptCareMenu</title>
</head>
<body>
	<h4 class="widget_title">입양</h4>
	<ul class="list cat-list">
		<li>
			<a href="${pageContext.request.contextPath}/staff/getAdoptApplyInStaff" class="d-flex"><p>신청목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getAdoptApprovalInStaff" class="d-flex"><p>승인목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getAdoptRejectInStaff" class="d-flex"><p>거절목록</p></a>
		</li>
	</ul>
	<br>
	<h4 class="widget_title">케어</h4>
	<ul class="list cat-list">
		<li>
			<a href="${pageContext.request.contextPath}/staff/getCareInfoInStaff" class="d-flex"><p>Info확인</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/addCarePlanInStaff" class="d-flex"><p>Plan작성</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff" class="d-flex"><p>Plan목록</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getCarePlanCalInStaff" class="d-flex"><p>Plan달력</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/addCareRecordInStaff" class="d-flex"><p>Record작성</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getCareRecordInStaff" class="d-flex"><p>Record목록</p></a>
		</li>
	</ul>
</body>
</html>