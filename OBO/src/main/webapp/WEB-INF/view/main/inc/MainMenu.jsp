<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="sticky-header" class="main-header-area">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-xl-3 col-lg-3">
				<div class="logo">
					<a href="${pageContext.request.contextPath}/">
						<img src="${pageContext.request.contextPath}/static/img/logo.png" alt="">
					</a>
				</div>
			</div>
			
			<div class="col-xl-9 col-lg-9">
				<div class="main-menu  d-none d-lg-block">
					<nav>
						<ul id="navigation">
							<!-- 홈, 보호소, 동물, 봉사, 후원, 자유게시판 -->
							<li><a href="${pageContext.request.contextPath}/home">홈</a></li>
								<li><a href="${pageContext.request.contextPath}/getAnimallList">동물</a>
								<li><a href="${pageContext.request.contextPath}/getShelterList">보호소</a></li>
								<li><a href="${pageContext.request.contextPath}/getVolunteer">봉사<i class="ti-angle-down"></i></a>
									<ul class="submenu">
										<li><a href="${pageContext.request.contextPath}/member/getVolunteerN">일반봉사</a></li>
										<li><a href="${pageContext.request.contextPath}/member/getVolunteerP">정기봉사</a></li>
									</ul>
								</li>
								<li><a href="${pageContext.request.contextPath}/getDonation">후원<i class="ti-angle-down"></i></a>
									<ul class="submenu">										
										<li><a href="${pageContext.request.contextPath}/member/addDonation">일반후원</a></li>
										<li><a href="${pageContext.request.contextPath}/member/addPeriodicallyDonation">정기후원</a></li>
										<li><a href="${pageContext.request.contextPath}/member/addDonationItem">물품후원</a></li>
									</ul>
								</li>
								<li><a href="${pageContext.request.contextPath}/getBoardList">자유게시판<i class="ti-angle-down"></i></a>
									<ul class="submenu">
										<li><a href="${pageContext.request.contextPath}/#">카테고리 넣을지 말지 고민중...</a></li>
									</ul>
								</li>
						</ul>
					</nav>
				</div>
			</div>
			
			<div class="col-12">
				<div class="mobile_menu d-block d-lg-none"></div>
			</div>
		</div>
	</div>
</div>

