<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원봉사내역</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>회원봉사</h1>
	
	<table>
		<tr>
			<th>보호소</th>
			<th>후원금</th>
			<th>신청날짜</th>
			<th>후원끝난 날짜</th>
		</tr>
		<c:forEach var="p" items="${list}">
			<input type="hidden" class="periodicallyDonationId" value="${p.periodicallyDonationId}">
			<tr>
				<td>${p.shelterName}</td>
				<td>${p.amount}</td>
				<td>${p.applyDate}</td>
				<td>
					<c:if test="${p.endDate != null}">
						${p.endDate}
					</c:if>
					<c:if test="${p.endDate == null}">
						<a href="${pageContext.request.contextPath}/member/endPeriodicallyDonation?periodicallyDonationId=${p.periodicallyDonationId}">
							<button class="removePDonationBtn">후원끊기</button>
						</a>
					</c:if>
				</td>		
			</tr>
		</c:forEach>
	</table>
	
	<script>
		$('.removePDonationBtn').click(function(){
			//periodicallyDonationId 구하기
			let index = $('.removePDonationBtn').index(this);
			console.log(index);
			
			let periodicallyDonationId = $('.periodicallyDonationId').val()
			console.log(periodicallyDonationId);
		});
	</script>
</body>
</html>