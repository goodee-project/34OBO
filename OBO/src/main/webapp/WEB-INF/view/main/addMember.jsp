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
			
		} else if($('#target').text() == '' || $('#target').text() == '아이디를 입력해주세요.'){
			alert('아이디 중복검사를 해주세요');
			
		} else if($('#target').text() == '이미 사용중인 아이디입니다.'){			
			alert('아이디가 중복되지 않게 해주세요.');
			
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
			
		} else if(mailChecked != true){
			alert('이메일을 인증해주세요.')
			$('#memberEmail').focus();
			
		} else if($('#memberPw').val() ==''){
			alert('비밀번호를 입력해주세요.')
			$('#memberPw').focus();
			
		} else if($('#pwCheck').text() != '패스워드가 일치합니다.' || $('#pwCheck').text() == ''|| $('#memberPw').val() != $('#memberPwCheck').val()){
			alert('비밀번호가 일치하지 않습니다.')
			$('#memberPwCheck').focus();
			
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
				<td>
					<input id="memberId" name="member.memberId" type="text">
					<input type="button" onclick="memberIdCheck()" value="중복검사"><br>
					<span id="target"></span>
				</td>
			</tr>
			<tr>
				<!-- 비밀번호 확인 넣기 -->
				<th>비밀번호</th>
				<td><input id="memberPw" name="member.memberPw" type="password"></td>
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
			<tr>
				<th>주소</th>
				<td>
					<input type="text" id="sample4_postcode" name="address.postCode" placeholder="우편번호">
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="address.doro">
					<span id="guide" style="color:#999;display:none"></span>
					<div>
						<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="address.detailAddress">		
					</div>
					
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input id="memberName" name="member.memberName" type="text"></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input id="memberPhone" name="member.memberPhone" type="text"></td>
			</tr>
			<tr>
				<th>생일</th>
				<td><input id="memberBirth" name="member.memberBirth" type="date"></td>
			</tr>
			<tr>
				<!-- 이메일 인증 넣기 -->
				<th>이메일</th>
				<td>
					<input id="memberEmail" name="member.memberEmail" type="text">
					<button id="sendMail" type="button">인증메일 발송</button>
					
					<div>
						<input id="emailCheck" type="text" placeholder="인증코드">
					</div>
					<div>
						<span id="mailTarget"></span>
					</div>
				</td>
			</tr>
			
			<tr>
				<th>닉네임</th>
				<td><input id="memberNickname" name="member.memberNickname" type="text"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input name="member.memberGender" type="radio" value="남">남
					<input name="member.memberGender" type="radio" value="여">여
				</td>
			</tr>
				<!-- 로봇이 아닙니다. google 보안기능 넣기 -->	
		</table>
		<button id="addMemberFormBtn" type="button">회원가입</button>
		<button type="reset">리셋</button>
	</form>
	
	
<script>
	//메일 인증코드
	let mailKey;
	let mailChecked;
	
	$("#emailCheck").on("propertychange change keyup paste input", function() {
		if ($("#emailCheck").val() == mailKey) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
			$("#mailTarget").text("인증 성공").css("color", "black");
			mailChecked = true;  //인증 성공여부 check
		} else {
			$("#mailTarget").text("불일치").css("color", "red");
			mailChecked = false; //인증 실패
		}
	});
	
	//email 확인하기!
	$("#sendMail").click(function() {// 메일 입력 유효성 검사
		let mail = $("#memberEmail").val(); //사용자의 이메일 입력값.
		
		if (mail == "") {
			alert("메일 주소가 입력되지 않았습니다.");
		} else {
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/checkMail',
				data : {mail:mail},
				success: function(jsonData){
					alert("인증번호가 전송되었습니다.");
					mailKey = jsonData;
					console.log(mailKey);
									
				}
			});
			
			//isCertification=true; //추후 인증 여부를 알기위한 값
		}
	});
	
	//pw 확인
	$('#memberPwCheck').keyup(function(){
		console.log('pw 확인');
		
		let pwLength = $('#memberPwCheck').val().length;
		//pw 3자 이상
		if(pwLength > 3){
			if($('#memberPw').val() != $('#memberPwCheck').val()){
				$('#pwCheck').text('패스워드가 일치하지 않습니다.');
			} else{
				$('#pwCheck').text('패스워드가 일치합니다.');
			}
		}
		
	});

	//아이디 중복검사
	function memberIdCheck(){
		console.log('click!');
		
		if($('#memberId').val() == ''){
			$('#target').empty();
			$('#target').append('아이디를 입력해주세요.');
			$('#memberId').focus();
		} else {
			
			$.ajax({
				type:'get',
				url: '${pageContext.request.contextPath}/getMemeberIdByAddMember',
				data: {memberId: $('#memberId').val()},
				success: function(jsonData){
					
					console.log(jsonData);
					if(jsonData == ''){//아이디 중복 안됨
						console.log('성공');
						$('#target').empty();
						$('#target').append('사용가능한 아이디입니다.');
					} else {//아이디 중복
						console.log('아이디 중복');
						$('#target').empty();
						$('#target').append('이미 사용중인 아이디입니다.');
					}
				}
			})
		}
	}

    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                /*
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                */
            }
        }).open();
    }
</script>
</body>
</html>