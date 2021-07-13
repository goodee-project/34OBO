<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h3>검은색 네비바</h3>

<c:if test="${loginMember == null}">
	<form id="memberLoginForm" method="post">
		<input id="memberId" name="memberId" type="text" placeholder="아이디">
		<input id="memberPw" name="memberPw" type="password" placeholder="비밀번호">
		
		<button id="memberLoginBtn" type="button">로그인</button>
	</form>
	
	<a href="${pageContext.request.contextPath}/addMember">회원가입</a>
	
</c:if>
<c:if test="${loginMember != null}">
	<h4>${loginMember.memberNickname}님 로그인 축하</h4>
	<a href="${pageContext.request.contextPath}/memberLogout">로그아웃</a>
</c:if>

<script>
	$('#memberLoginBtn').click(function(){
		console.log('click');
		
		if($('#memberId').val() == ''){
			alert('아이디를 입력해 주세요.');
			 $('#memberId').focus();
		} else if($('#memberPw').val() == ''){
			alert('비밀번호를 입력해 주세요.');
			 $('#memberPw').focus();
		} else {
			
			$.ajax({
				type:'post',
				url: '${pageContext.request.contextPath}/getMemberByLogin',
				data: $('#memberLoginForm').serialize(), //form 의 정보 끌어옴
				success: function(jsonData){
					
					if(jsonData == true){ // 로그인 성공
						location.reload();//페이지 새로고침
					} else {//로그인 실패시
						alert('아이디 또는 비밀번호가 틀렸습니다.');
					}				
				}
			})
		}
						
	})

</script>