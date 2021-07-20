<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
	.btn_image{
		 -webkit-appearance: none;
		  -moz-appearance: none;
		  appearance: none;
	}
</style>
<div class="header-top_area">
	<div class="container">
		<div class="row">
			<c:if test="${loginMember == null}"><!-- 로그인 전 -->
				<div class="col-lg-10 col-md-8">
					<div class="short_contact_list">
						<form id="memberLoginForm" method="post">
							<ul>
								<li><span style="color:white">ID</span>&nbsp;</li>
								<li><input id="loginMemberId" name="memberId" type="text" placeholder="아이디"  class="form-control" style="width:150px; height:30px"></li>&emsp;
								<li><span style="color:white">PW</span>&nbsp;</li>
								<li><input id="loginMemberPw" name="memberPw" type="password" placeholder="비밀번호" class="form-control" style="width:150px; height:30px"></li>&emsp;
								<li><button type="button" id="memberLoginBtn" class="genric-btn primary-border circle arrow medium">LOGIN</button></li>&emsp;
								<li><a href="${pageContext.request.contextPath}/addMember">가입</a></li>
								<li>
									<a href="javascript:void(0);" onclick="kakao();">
										<img src="${pageContext.request.contextPath}/static/img/kakao_login.png" >						
									</a>
								</li>
							</ul>
							
						</form>
						
					</div>
				</div>
				
			</c:if>
			
			
			
			<c:if test="${loginMember != null}"><!-- 로그인 후 -->
				<div class="col-lg-12 col-md-4 ">
					<div class="social_media_links">
						<span class="text-white font-weight-bolder">${loginMember.memberNickname}님, 반갑습니다!</span>
						<a href="${pageContext.request.contextPath}/member/getMemberOne" class="text-white font-weight-bolder">내정보</a>
						<a href="${pageContext.request.contextPath}/memberLogout"><button type="button" class="genric-btn primary-border circle arrow medium">LOGOUT</button></a>
					</div>
				</div>
				
			</c:if>
		

			<script>
				//로그인 버튼 클릭
				$('#memberLoginBtn').click(function(){
					console.log('click');
					
					if($('#loginMemberId').val() == ''){
						alert('아이디를 입력해 주세요.');
						 $('#loginMemberId').focus();
					} else if($('#loginMemberPw').val() == ''){
						alert('비밀번호를 입력해 주세요.');
						 $('#loginMemberPw').focus();
					} else {
						
						$.ajax({
							type:'post',
							url: '${pageContext.request.contextPath}/getMemberByLogin',
							data: $('#memberLoginForm').serialize(), //form 의 정보 끌어옴
							success: function(jsonData){
								
								if(jsonData == true){ // 로그인 성공
									location.reload();//페이지 새로고침
								} else {//로그인 실패시
									alert('아이디 또는 비밀번호가 틀렸습니다.');
								}				
							}
						})
					}
									
				})
				
				
				// 카카오 로그인창 이동
				function kakao(){
					console.log('카카오');
					 $.ajax({
					        url: '${pageContext.request.contextPath}/kakaoLogin',
					        type: 'get',
					        data: {url: 'http://localhost/obo/loginByKakao'}
					    }).done(function (jsonData) {
					        
					        window.location.href = jsonData;
					    });
				}
			
			</script>
		</div>
	</div>
</div>