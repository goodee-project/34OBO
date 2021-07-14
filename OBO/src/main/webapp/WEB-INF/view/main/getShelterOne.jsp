<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getShelterOne</title>
</head>
<body>
	<h1>getShelterOne</h1>
	<table border=1>
		<tr>
			<td>shelterID</td>
			<td>${shelterMap.shelterId}</td>
		</tr>
		<tr>
			<td>addressId</td>
			<td>${shelterMap.addressId}</td>
		</tr>
		<tr>
			<td>shelterName</td>
			<td>${shelterMap.shelterName}</td>
		</tr>
		<tr>
			<td>createDate</td>
			<td>${shelterMap.createDate}</td>
		</tr>
		<tr>
			<td>introduction</td>
			<td>${shelterMap.introduction}</td>
		</tr>
		<tr>
			<td>protectDuration</td>
			<td>${shelterMap.protectDuration}</td>
		</tr>
		<tr>
			<td>shelterPhone</td>
			<td>${shelterMap.shelterPhone}</td>
		</tr>
		<tr>
			<td>account</td>
			<td>${shelterMap.account}</td>
		</tr>
		<tr>
			<td>active</td>
			<td>${shelterMap.active}</td>
		</tr>
	</table>
</body>
</html>