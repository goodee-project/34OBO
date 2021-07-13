<!-- 작성자 : 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
    <div class="short_contact_list">
     <c:if test="${loginManager == null}">
     <form id="loginForm" action="${pageContext.request.contextPath}/manager/login" method="post">
         <ul>
             <span class="text-white font-weight-bolder">ID &emsp;</span> <li><input style="height:30px" class="form-control" type="text" id="managerId" name="managerId"></li>
             <span class="text-white font-weight-bolder">&emsp;&emsp; PW &emsp;</span> <li>&emsp;<input style="height:30px" class="form-control" type="password" id="managerPw" name="managerPw"></li>
             <li>&emsp;<button type="button" id="loginBtn" class="genric-btn primary-border circle arrow medium">LOGIN</button></li>
         </ul>
     </form>
     </c:if>
     <c:if test="${loginManager != null}">
     <form id="logout" action="${pageContext.request.contextPath}/manager/logout">
         <ul>
             <li><span class="text-white font-weight-bolder">${loginManager.managerName} 님, 반갑습니다!</span></li>
             <li>&emsp;<button type="button" id="logoutBtn" class="genric-btn primary-border circle arrow medium">LOGOUT</button></li>
         </ul>
     </form>
     </c:if>
    </div>
</body>
</html>