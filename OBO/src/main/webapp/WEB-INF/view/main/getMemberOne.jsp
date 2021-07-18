<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
		<tr>
			<th>카카오연동</th>
			<td>
				<c:if test="${memberOne.kakaoId == null}"><!-- 연동x -->
					<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=535757159a398fe468b3ed3f2d2032e4&redirect_uri=http://localhost/obo/member/getKakaoLink">
						<img src="${pageContext.request.contextPath}/static/img/kakaolink_btn_medium.png">
					</a>
				</c:if>
				<c:if test="${memberOne.kakaoId != null}"><!-- 연동o -->
					연동되었습니다.
				</c:if>
			</td>
		</tr>
	</table>
	
	<button id="modifyMemberOne" type="button" onclick="modifyMemberOne()">내 정보 수정</button>
	<a href="${pageContext.request.contextPath}/member/modifyMemberPw"><button type="button">비밀번호 수정</button></a>
<script>
	//정보수정 페이지로 이동하기 전에 비밀번호 검사
	function modifyMemberOne(){
		console.log('click!');
		
		let checkPw = prompt("비밀번호를 입력하시오");
		
		$.ajax({
			type: 'post',
			url: '${pageContext.request.contextPath}/getMemberByPwCheck',
			data: {memberPw: checkPw},
			success: function(jsonData){
				console.log('성공');
				console.log(jsonData);
				
				//true면 성공, false면 실패
				if(jsonData == false){
					alert('비밀번호가 틀렸습니다.');
				} else {//회원 정보 수정 페이지로 이동하기 
					window.location.href = '${pageContext.request.contextPath}/member/modifyMemberOne';
				}
			}
		})
				
	}
	
	/*
	
	//카카오 연동 - 카카오 로그인창 불러오기!
	function kakao(){
		console.log('카카오');
		 $.ajax({
		        url: '/member/getKakaoAuthUrl',
		        type: 'get',
		    }).done(function (jsonData) {
		        console.log('로그인창 가져왔니?');
		    });
	}
	*/
	
	
</script>
</body>
</html>