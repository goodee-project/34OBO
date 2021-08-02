<!-- 작성자 : 이윤정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffMenu</title>
</head>
<body>
	<div id="sticky-header" class="main-header-area">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-xl-3 col-lg-3">
					<div class="logo">
						<a href="${pageContext.request.contextPath}/s/">
							<img src="../static/img/obo/oboex.png" alt="">
						</a>
					</div>
				</div>
				
				<div class="col-xl-9 col-lg-9">
					<div class="main-menu  d-none d-lg-block">
						<nav>
							<ul id="navigation">

								<!-- 로그인 전 -->
								<c:if test="${loginStaff == null}">
									<li><a href="${pageContext.request.contextPath}/s/">홈</a></li>
									<li><span>로그인이 필요한 기능입니다.</span></li>
								</c:if>
							
								<!-- 로그인 후 -->
								<c:if test="${loginStaff != null}">
									<!--staffMenu(inc) 홈, 동물, 보호소, 후원, 봉사, 입양&케어-->
									<li><a href="${pageContext.request.contextPath}/s/">홈</a></li>
									<li><a href="${pageContext.request.contextPath}/staff/getAnimalInStaff">동물<i class="ti-angle-down"></i></a>
										<ul class="submenu">
											<li><a href="${pageContext.request.contextPath}/staff/getAnimalList">동물 목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/addAnimal">동물 등록</a></li>
										</ul>
									</li>
									<li><a href="${pageContext.request.contextPath}/staff/getShelterInStaff">보호소<i class="ti-angle-down"></i></a>
										<ul class="submenu">
											<li><a href="${pageContext.request.contextPath}/staff/shelterIntro">보호소 소개</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/modifyShelter">내용 수정</a></li>
										</ul>
									</li>
									<li><a href="${pageContext.request.contextPath}/staff/getDonationInStaff">후원<i class="ti-angle-down"></i></a>
										<ul class="submenu">
											<li><a href="${pageContext.request.contextPath}/staff/getDonationItemN">물품후원</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getDonationMoneyN">일반후원</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getDonationMoneyP">정기후원</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getDonationStats">통계</a></li>
										</ul>
									</li>
									<li><a href="${pageContext.request.contextPath}/staff/getVolunteerInStaff">봉사<i class="ti-angle-down"></i></a>
										<ul class="submenu">
											<li><span>일반봉사</span></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerRecruitN">모집공고</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerApplyN">신청목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckN">확인목록</a></li>
											<li><span>정기봉사</span></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerRecruitP">모집공고</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerApplyP">신청목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getVolunteerCheckP">확인목록</a></li>
										</ul>
									</li>
									<li><a href="${pageContext.request.contextPath}/staff/getAdoptAndCareInStaff">입양&케어<i class="ti-angle-down"></i></a>
										<ul class="submenu">
											<li><span>입양</span></li>
											<li><a href="${pageContext.request.contextPath}/staff/getAdoptApplyInStaff">신청목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getAdoptApprovalInStaff">승인목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getAdoptRejectInStaff">거절목록</a></li>
											<li><span>케어</span></li>
											<li><a href="${pageContext.request.contextPath}/staff/getCareInfoInStaff">Info확인</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/addCarePlanInStaff">Plan작성</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getCarePlanInStaff">Plan목록</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getCarePlanCalInStaff">Plan달력</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/addCareRecordInStaff">Record작성</a></li>
											<li><a href="${pageContext.request.contextPath}/staff/getCareRecordInStaff">Record목록</a></li>
										</ul>
									</li>
								</c:if>
								
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
</body>
</html>