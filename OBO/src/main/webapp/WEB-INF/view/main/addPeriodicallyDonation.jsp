<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정기후원</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>정기후원</h1>
	
	<p>설정하신 후원액은 매 달 '1일'에 자동이체됩니다.</p>
	
	<form id="donationForm" action="${pageContext.request.contextPath}/member/addPeriodicallyDonation" method="post">
		<span id="target"></span>
		<table>
			<tr>
				<th>보호소</th>
				<th>
					<select id="shelter" name="shelterId">
						<c:forEach var="s" items="${shelterList}">
							<option value="${s.shelterId}">${s.shelterName}
						</c:forEach>
					</select>
				</th>
			</tr>
			<tr>
				<th>ID</th>
				<th><input id="memberId" type="text" name="memberId" readonly="readonly" value="${memberId}"></th>
			</tr>
			<tr>
				<th>예금주</th>
				<th><input id="" type="text" name=""></th>
			</tr>
			<tr>
				<th>금액</th>
				<th><input id="amount" type="text" name="amount"></th>
			</tr>
		
		</table>
		<button type="button" id="donationFormBtn" onclick="addDonationBtn()">후원하기</button>
	</form>
	

<script>
	//<input type="hidden" name="device" value="">
	let device = null;
	console.log(navigator.platform);
	//사용자가 pc인지 mobile 인지 확인하기 -> 윈도우와 맥이 아니면 mobile
 	let filter = "win16|win32|win64|mac|macintel";
	
    if(0 > filter.indexOf(navigator.platform.toLowerCase())){
        device = 'mobile';     
    }else{
        device = 'pc';
    }
    
    console.log(device);
    $('#target').append('<input type="hidden" name="device" value="'+device+'">');
	
	
	function addDonationBtn(){
		console.log('버튼 click');
		
		if($('#shelter').val() == ''){
			alert('보호소를 선택해주세요.');
			$('#shelter').focus();
		} else if($('#amount').val() == ''){
			alert('금액을 입력하시오.');
			$('#shelter').focus();
		} else {
			console.log('비밀번호 검사 시작합니다.');
			//비밀번호 검사
			let checkPw = prompt('비밀번호를 입력하시오.');
			
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
						$('#donationForm').submit();
					}
				}
			})
		}		
	}
</script>

</body>
</html>