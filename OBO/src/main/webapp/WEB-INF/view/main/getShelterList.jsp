<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getShelterList</title>
</head>
<body>
	<h1>getShelterList</h1>
	
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
			<c:forEach var="s" items="${mainShelterList}">
				<tr>
					<td>${s.shelterId}</td>
					<td>${s.shelterName}</td>
					<td>${s.createDate}</td>
					<td>${s.shelterPhone}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>