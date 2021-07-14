<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffMenu</title>
</head>
<body>
	<!-- 로그인 전 -->
	<c:if test="${loginStaff == null}">
		<li><a href="#">홈</a></li>
		<li><span>로그인이 필요한 기능입니다.</span></li>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${loginStaff != null}">
		<!--staffMenu(inc) 홈, 동물, 보호소, 후원, 봉사, 입양&케어-->
		<li><a href="${pageContext.request.contextPath}/staff/home">홈</a></li>
		<li><a href="${pageContext.request.contextPath}/staff/getAnimalList">동물</a></li>
		<li><a href="${pageContext.request.contextPath}/staff/getShelter">보호소<i class="ti-angle-down"></i></a>
			<ul class="submenu">
				<li><a href="${pageContext.request.contextPath}/staff/shelterIntro">보호소 소개</a></li>
				<li><a href="${pageContext.request.contextPath}/staff/modifyShelter">내용 수정</a></li>
			</ul>
		</li>
		<li><a href="${pageContext.request.contextPath}/staff/getDonation">후원<i class="ti-angle-down"></i></a>
			<ul class="submenu">
				<li><a href="${pageContext.request.contextPath}/staff/getDonationMoneyN">일반후원</a></li>
				<li><a href="${pageContext.request.contextPath}/staff/getDonationMoneyP">정기후원</a></li>
				<li><a href="${pageContext.request.contextPath}/staff/getDonationItemN">물품후원</a></li>
			</ul>
		</li>
		<li><a href="${pageContext.request.contextPath}/staff/getVolunteer">봉사<i class="ti-angle-down"></i></a>
			<ul class="submenu">
				<li><a href="${pageContext.request.contextPath}/staff/getVolunteerN">일반봉사</a></li>
				<li><a href="${pageContext.request.contextPath}/staff/getVolunteerP">정기봉사</a></li>
			</ul>
		</li>
		<li><a href="${pageContext.request.contextPath}/staff/#">입양&케어<i class="ti-angle-down"></i></a>
			<ul class="submenu">
				<li><a href="${pageContext.request.contextPath}/staff/#">입양</a></li>
				<li><a href="${pageContext.request.contextPath}/staff/#">케어</a></li>
			</ul>
		</li>
	</c:if>

</body>
</html>