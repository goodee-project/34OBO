<!-- 작성자 : 남궁혜영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<div id="sticky-header" class="main-header-area">
    <div class="container">
        <div class="row align-items-center">
		   <div class="col-xl-3 col-lg-3">
		      <div class="logo">
		          <a href="${pageContext.request.contextPath}/manager/">
		              <img src="../static/img/logo.png" alt="">
		          </a>
		      </div>
		  </div>
		  <div class="col-xl-9 col-lg-9">
		      <div class="main-menu  d-none d-lg-block">
		          <nav>
		              <ul id="navigation">
		                  <li><span><a href="${pageContext.request.contextPath}/manager/">홈</a></span></li>
		                  <c:if test="${loginManager == null}">
		                  	<li><span>로그인이 필요한 기능입니다.</span></li>
		                  </c:if>
		                  <c:if test="${loginManager != null}">
			                <li><a href="#">봉사자격 <i class="ti-angle-down"></i></a>
			                    <ul class="submenu">
			                        <li><span><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList">신청목록</a></span></li>
			                        <li><span><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList">승인목록</a></span></li>
			                    </ul>
			                </li>
			                <li><span><a href="${pageContext.request.contextPath}/manager/getManagerShelterList">보호소</a></span></li>
		                  </c:if>
		              </ul>
		          </nav>
		      </div>
		  </div>
 		</div>
	</div>
</div>
  <div class="col-12">
      <div class="mobile_menu d-block d-lg-none"></div>
  </div>
</body>
</html>