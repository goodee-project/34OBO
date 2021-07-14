<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getShelterList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#btn').click(function(){
			 console.log("btn click!");
			 $('#shelterForm').submit();
		});
	});
</script>
</head>
<body>
	<h1>getShelterList</h1>
	<form id="shelterForm" action="${pageContext.request.contextPath}/getShelterList" method="get">
		검색어(shelter) : <input name="shelterName" type="text">
		<button id="btn" type="button">검색</button>
	</form>
	<table border=1>
		<thead>
			<tr>
				<th>shelterId</th>
				<th>shelterName</th>
				<th>createDate</th>
				<th>shelterPhone</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="s" items="${shelterList}">
				<tr>
					<td>${s.shelterId}</td>
					<td><a href="${pageContext.request.contextPath}/getShelterOne?shelterId=${s.shelterId}">${s.shelterName}</a></td>
					<td>${s.createDate}</td>
					<td>${s.shelterPhone}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${currentPage > 1}">
		<li class="previous"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage-1}&shelterName=${shelterName}">이전</a></li>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<li class="next"><a href="${pageContext.request.contextPath}/getShelterList?currentPage=${currentPage+1}&shelterName=${shelterName}">다음</a></li>
	</c:if>	
        
</body>
</html>