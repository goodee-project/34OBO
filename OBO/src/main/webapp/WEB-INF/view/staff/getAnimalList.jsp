<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getAnimalList</title>
</head>
<body>
	<h2>동물 리스트</h2>
	<div>
		동물 이름 :
		<input type="text" name="searchWord" value="${searchWord}">
	</div>
	
	 <table>
        <thead>
            <tr>
                <th>animalId</th>
                <th>shelterId</th> <!-- 동물 종 -->
                <th>animalFileName</th>
                <th>species</th>
                <th>animalName</th>
                <th>animalAge</th>
                <th>animalSex</th>
                <th>animalWeight</th>
                <th>animalKind</th>
                <th>animalFindPlace</th>
                <th>animalEnterDate</th>
                <th>animalState</th>
                
            </tr>
        </thead>
        <tbody>
            <c:forEach var="a" items="${animalList}">
                <tr>
                	<td>${a.animalId}</td>
                	<td>${a.shelterId}</td>
                	<td>${a.animalFileName}</td>
                	<td>${a.species}</td>
                	<td><a href="${pageContext.request.contextPath}/staff/getAnimalOne?shelterId=${a.shelterId}">${a.animalName}</a></td>
                	<td>${a.animalAge}</td>
                	<td>${a.animalSex}</td>
                	<td>${a.animalWeight}</td>
                	<td>${a.animalKind}</td>
                	<td>${a.animalFindPlace}</td>
                	<td>${a.animalEnterDate}</td>
                	<td>${a.animalState}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
 
     <div>
    	<a class="btn btn-default" href="${pageContext.request.contextPath}/staff/addAnimal">addAnimal</a>	
    </div>

	<!-- 페이징 -->
    <ul class="pager">
		<c:if test="${currentPage > 1}">
		   	<a href="${pageContext.request.contextPath}/staff/getAnimalList?currentPage=${currentPage-1}&searchWord=${searchWord}">이전</a>
		</c:if>
		<c:if test="${currentPage < lastPage}">
		    <a href="${pageContext.request.contextPath}/staff/getAnimalList?currentPage=${currentPage+1}&searchWord=${searchWord}">다음</a>
		</c:if>
   </ul>
</body>
</html>