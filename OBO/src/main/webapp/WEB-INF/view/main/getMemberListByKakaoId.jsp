<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 로그인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>카카오 로그인</h1>
	<!-- 연동 아이디 있을때 -->
	<c:if test="${list != null}">
		<form id="kakaoLoginForm" action="${pageContext.request.contextPath}/loginByKakao" method="post">
			<input type="hidden" name="kakaoId" value="${kakaoId}">
			
			<c:forEach var="c" items="${list}">
				<input type="radio" name="memberId" value="${c.memberId}">${c.memberId}
			</c:forEach>
			
			<button type="button" onclick="kakaoLogin()">로그인</button>
		</form>
	</c:if>
	
	<!-- 연동 아이디 없을때  -->
	<c:if test="${list == null}">
		<p>회원가입이 되지 않았거나 카카오와 연동되지 않았습니다.</p>
		<div>
			<a href="${pageContext.request.contextPath}/addMember">회원가입 하러 가기</a>
		</div>
	</c:if>
<script>
	function kakaoLogin(){
		console.log('click!');
		
		if($('#memberId').val() == ''){
			alert('로그인할 아이디를 선택해주세요.');
		} else {
			$('#kakaoLoginForm').submit();
		}
		
	}
</script>
</body>
</html>