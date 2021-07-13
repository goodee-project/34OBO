<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$('#addMemberFormBtn').click(function(){
		console.log('click');
		
		if($('#memberId').val() == ''){
			alert('아이디를 입력해주세요.');
			$('#memberId').focus();
			
		} else if($('#memberName').val() == ''){
			alert('이름을 입려해주세요.');
			$('#memberName').focus();
			
		} else if($('#memberPhone').val() ==''){
			alert('휴대폰 번호를 입력해주세요.')
			$('#memberPhone').focus();
			
		} else if($('#memberBirth').val() ==''){
			alert('생일를 입력해주세요.')
			$('#memberBirth').focus();
			
		} else if($('#memberEmail').val() ==''){
			alert('이메일을 입력해주세요.')
			$('#memberEmail').focus();
			
		} else if($('#memberPw').val() ==''){
			alert('비밀번호를 입력해주세요.')
			$('#memberPw').focus();
			
		} else if($('#memberNickname').val() ==''){
			alert('닉네임을 입력해주세요.')
			$('#memberNickname').focus();
			
		} else{
			$('#addMemberForm').submit();
		}
	});
});
</script>
</head>
<body>
	<h1>회원가입 폼</h1>
	<form id="addMemberForm" action="${pageContext.request.contextPath}/addMember" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td><input id="memberId" name="memberId" type="text"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><button type="button">주소찾기</button></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input id="memberName" name="memberName" type="text"></td>
			</tr>
			<tr>
				<th>휴대폰번호</th>
				<td><input id="memberPhone" name="memberPhone" type="text"></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input id="memberBirth" name="memberBirth" type="date"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input id="memberEmail" name="memberEmail" type="text"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input id="memberPw" name="memberPw" type="password"></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><input id="memberNickname" name="memberNickname" type="text"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input name="memberGender" type="radio" value="남">남
					<input name="memberGender" type="radio" value="여">여
				</td>
			</tr>		
		</table>
		<button id="addMemberFormBtn" type="button">회원가입</button>
		<button type="reset">리셋</button>
	</form>
	

</body>
</html>