<!-- 작성자 : 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
   <div class="col-xl-3 col-lg-3">
      <div class="logo">
          <a href="${pageContext.request.contextPath}/manager/home">
              <img src="../static/img/logo.png" alt="">
          </a>
      </div>
  </div>
  <div class="col-xl-9 col-lg-9">
      <div class="main-menu  d-none d-lg-block">
          <nav>
              <ul id="navigation">
                  <li><a href="${pageContext.request.contextPath}/manager/home">홈</a></li>
                  <c:if test="${loginManager != null}">
                  <li><a href="#">봉사자격 <i class="ti-angle-down"></i></a>
                      <ul class="submenu">
                          <li><a href="">신청목록</a></li>
                          <li><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList">승인목록</a></li>
                      </ul>
                  </li>
                  <li><a href="">보호소등록</a></li>
                  </c:if>
              </ul>
          </nav>
      </div>
  </div>
  <div class="col-12">
      <div class="mobile_menu d-block d-lg-none"></div>
  </div>
</body>
</html>