<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내정보</title>
</head>
<body>
	<h1>내정보 보기</h1>
	
	<table>
		<tr>
			<th>아이디</th>
			<td>${memberOne.memberId}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${memberOne.memberName}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${memberOne.memberNickname}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${memberOne.memberEmail}</td>
		</tr>
		<tr>
			<th>가입날짜</th>
			<td>${memberOne.createDate}</td>
		</tr>
		<tr>
			<th>휴대폰번호</th>
			<td>${memberOne.memberPhone}</td>
		</tr>
		<tr>
			<th>생일</th>
			<td>${memberOne.memberBirth}</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${memberOne.memberGender}</td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>${memberOne.postCode}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<div>
					${memberOne.doro}
				</div>
					${memberOne.detailAddress}
				
			</td>
		</tr>
	</table>
	
	<button id="modifyMemberOne" type="button" onclick="modifyMemberOne()">내 정보 수정</button>
<script>
	//정보수정 페이지로 이동하기 전에 비밀번호 검사
	function modifyMemberOne(){
		console.log('click!');
		
		let checkPw = prompt("비밀번호를 입력하시오");
		
		$.ajax({
			type: 'post',
			url: '/',
			data: {memberId: ${memberOne.memberId}},
			success: function(jsonData){
				console.log('성공')
			}
		})
		
		
	}
</script>	

</body>
</html>