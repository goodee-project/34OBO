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
			<a href="${pageContext.request.contextPath}/staff/getDonationItemN" class="d-flex"><p>물품후원</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getDonationMoneyN" class="d-flex"><p>일반후원</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getDonationMoneyP" class="d-flex"><p>정기후원</p></a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/staff/getDonationStats" class="d-flex"><p>통계</p></a>
		</li>
	</ul>
</body>
</html>