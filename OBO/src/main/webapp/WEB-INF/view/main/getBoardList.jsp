<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getBoardList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$('#btn').click(function(){
			 console.log("btn click!");
			 $('#boardForm').submit();
		});
	});
</script>
</head>
<body>
	<h1>getBoardList</h1>
	<form id="boardForm" action="${pageContext.request.contextPath}/getBoardList" method="get">
		<label for="species">종(species) : </label>
		<select name="species">
		<option value="">종 선택</option>
			<c:forEach var="a" items="${animalCategoryList}">
    			<c:if test="${a.species == species}"> 
    				<option value="${a.species}" selected="selected">${a.species}</option>
    			</c:if>
    			<c:if test="${a.species != species}"> 
    				<option value="${a.species}">${a.species}</option>
    			</c:if>
    		</c:forEach>
		</select>
		검색어(board) : <input name="boardTitle" type="text">
		<button id="btn" type="button">검색</button>
	</form>
	<table border=1>
		<thead>
			<tr>
				<th>boardId</th>
				<th>boardTitle</th>
				<th>species</th>
				<th>memberId</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="b" items="${boardList}">
				<tr>
					<td>${b.boardId}</td>
					<td><a href="${pageContext.request.contextPath}/getBoardOne?boardId=${b.boardId}">${b.boardTitle}</a></td>
					<td>${b.species}</td>
					<td>${b.memberId}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${currentPage > 1}">
		<li class="previous"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage-1}&BoardTitle=${BoardTitle}">이전</a></li>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<li class="next"><a href="${pageContext.request.contextPath}/getBoardList?currentPage=${currentPage+1}&BoardTitle=${BoardTitle}">다음</a></li>
	</c:if>	
        
</body>
</html>