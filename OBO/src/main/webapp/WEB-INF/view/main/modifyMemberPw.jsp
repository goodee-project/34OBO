<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>비밀번호 수정</h1>
	
	<form id="modifyMemberPwForm" method="post">
		<table>
			<tr>
				<th>기존 비밀번호</th>
				<td><input id="originalPw" name="originalPw" type="password"></td>
			</tr>
			<tr>
				<!-- 비밀번호 확인 넣기 -->
				<th>새 비밀번호</th>
				<td><input id="changedPw" name="changedPw" type="password"></td>
			</tr>
			<tr>
				<!-- 비밀번호 확인 넣기 -->
				<th>비밀번호 확인</th>
				<td>
					<input id="memberPwCheck" type="password">
					<div>
						<span id="pwCheck"></span>
					</div>
				</td>
			</tr>
		
		
		</table>
		<button id="modifyMemberPwFormBtn" type="button">비밀번호 수정</button>
	</form>

<script>
	let pwChecked;
	//pw 검사코드
	$("#memberPwCheck").on("propertychange change keyup paste input", function() {
		if($('#changedPw').val().length >3){
			
			if ($("#changedPw").val() == $("#memberPwCheck").val()) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
					$("#pwCheck").text("인증 성공").css("color", "black");
					$('#changedPw').attr( 'readonly', 'readonly' );
					$('#memberPwCheck').attr( 'readonly', 'readonly' );
					pwChecked = true;  //인증 성공여부 check
				} else {
					$("#pwCheck").text("불일치").css("color", "red");
					pwChecked = false; //인증 실패
				}
						
		}
		
	});
	
	$('#modifyMemberPwFormBtn').click(function(){
		console.log('click');
		
		if($('#originalPw').val() == ''){
			alert('비밀번호를 입력해주세요.')
			$('#originalPw').focus();
		} else if($('#changedPw').val() == ''){
			alert('변경할 비밀번호를 입력해 주세요.')
			$('#changedPw').focus();
		} else if(pwChecked != true){
			alert('비밀번호 검사를 해주세요.')
		} else{
			//비밀번호 변경
			
			$.ajax({
				type:'post',
				url: '${pageContext.request.contextPath}/member/modifyMemberPw',
				data: $('#modifyMemberPwForm').serialize(), //form 의 정보 끌어옴
				success: function(jsonData){
					
					if(jsonData == true){ //변경 성공
						//로그아웃으로 이동
						window.location.href = '${pageContext.request.contextPath}/memberLogout';
					} else {//변경 실패시
						alert('비밀번호가 틀렸습니다.');
					}				
				}
			})
			
		}
	});
	
</script>
</body>
</html>