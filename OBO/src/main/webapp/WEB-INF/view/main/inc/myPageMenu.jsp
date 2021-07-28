<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="col-lg-3 mb-5">
	<div class="blog_right_sidebar">
		<aside class="single_sidebar_widget post_category_widget category_setting">
			<ul class="list cat-list">
				<li>
					<a href="${pageContext.request.contextPath}/member/getMemberOne" class="d-flex"><p>내정보</p></a>
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/member/getMemberDonation" class="d-flex"><p>후원내역</p></a>									
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/member/getMemberVolunteer" class="d-flex"><p>봉사내역</p></a>									
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/" class="d-flex"><p>입양&케어</p></a>									
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/member/getMemberAnimalLike" class="d-flex"><p>관심동물</p></a>									
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/member/addQualificationVolunteerApplication" class="d-flex"><p>봉사자격신청</p></a>									
				</li>
				<li>								
					<a href="${pageContext.request.contextPath}/member/getBoardHistory" class="d-flex"><p>작성글</p></a>									
				</li>
			</ul>
		</aside>
	</div>
</div>