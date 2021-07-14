<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 다음 우편번호 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
				<td>
					<input type="text" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample6_address" placeholder="주소"><br>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">				
				</td>
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
	
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
</body>
</html>