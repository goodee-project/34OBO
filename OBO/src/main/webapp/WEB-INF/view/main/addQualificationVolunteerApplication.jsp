<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사자격신청</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- CSS here -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/owl.carousel.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/magnific-popup.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/themify-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/nice-select.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/flaticon.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/gijgo.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/animate.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/slicknav.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<header>
		<div class="header-area">		
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<jsp:include page="/WEB-INF/view/main/inc/myMenu.jsp"></jsp:include>			
			<!-- 흰색 바탕 : 메인 메뉴 -->
			<jsp:include page="/WEB-INF/view/main/inc/MainMenu.jsp"></jsp:include>
					
		</div>
	</header>
	
	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h3>자격신청</h3>
				</div>
			</div>
		</div>
	</div>
	
	<section class="blog_area single-post-area section-padding service_area">
		<div class="container">
			<div class="row">
				<!-- 내 페이지 메뉴 -->
				<jsp:include page="/WEB-INF/view/main/inc/myPageMenu.jsp"></jsp:include>
				
				
				
				
				<div class="col-lg-9 mb-5 mb-lg-0"  >
					<!-- staff_account 클래스 새로 추가 -> css height 고정 -->
					<div class="single_service staff_account" style="height: 90%;">
						<div class="service_content">
							
							
							
							<h3 class="text-center">봉사자격신청</h3>
							
							<hr>
							<div class="col-lg-2" style="float: right; height: 20%;">
								<!-- Button to Open the Modal -->
								<button type="button" class="btn" data-toggle="modal" data-target="#myModal">
								  자격별 봉사
								</button>
							</div>
							<br>
							<br>
							
							
							<form id="addQForm" action="${pageContext.request.contextPath}/membe/addQualificationVolunteerApplication" method="post" enctype="multipart/form-data" >
								<input type="hidden" name="qualificationVolunteerApplication.memberId" id="memberId" value="${memberId}">
								
								<div class="row">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div>								<!-- 자격증명리스트 -->
										<select name="qualificationVolunteerApplication.qualificationTypeId" id="qualificationType" class="form-control">
											<option disabled="disabled" selected="selected">선택</option>
											<c:forEach var="q" items="${qTList}">
												<option value="${q.qualificationTypeId}">${q.qualificationTypeName}</option>
											</c:forEach>
										</select>
									</div>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<div>
										<!-- 자격별 가능한 봉사 -->
										<select name="qualificationVolunteerApplication.volunteerCategoryId" id="vTarget" class="form-control">
										</select>
									</div>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="button" class="btn default-border radius"data-toggle="modal" data-target="#addImg">이미지 추가</button>
								
								</div>
								
								
								<input id="imgFileUpload" name="qualificationFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple" class="imgCheck"/>		   	
							
								
								<br>
								<br>
								<br>
								<br>
								<br>
								
								<div class="text-right">
									<button id="btn" type="button" class="genric-btn primary-border radius"">신청하기</button>
								</div>
								
							</form>							
							
						</div>
					</div>
				</div>
				
				
				
				<div class="col-lg-9 mb-5 mb-lg-0 offset-3">
					<div class="single-post">
						<div class="blog_details">
							<h3 class="text-center">봉사자격신청</h3>
							<!-- 자격승인목록 -->
							<table class="table">
								<tr>
									<th>신청날짜</th>
									<th>자격증</th>
									<th>봉사종류</th>
									<th>승인여부</th>		
								</tr>
								<c:forEach items="${list}" var="l">
									<tr>
										<td>${l.applicateDate}</td>
										<td>${l.qualificationTypeName}</td>
										<td>${l.volunteerCategoryName}</td>
										<td>${l.approvalCheck}</td>
									</tr>
								</c:forEach>
							</table>

						</div>
					</div>
				</div>
				
				
			</div>
		</div>
	</section>
	
	
	<!-- 자격별 신청가능 봉사 소개 -->
	<div class="modal" id="myModal">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title text-center">자격별 신청가능 봉사</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        
	        <table class="table  text-center">
	        	<thead class="thead-light">
		        	<tr>
		        		<th>자격종류</th>
		        		<th>가능한봉사</th>
		        	</tr>
	        	</thead>
	        	<c:forEach var="q" items="${qVList}">
	        		<tr>
	        			<td>${q.qualificationTypeName}</td>
	        			<td>${q.volunteerCategoryName}</td>
	        		</tr>
	        	</c:forEach>
	        </table>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn " data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- 자격별 신청가능 봉사 소개 -->
	<div class="modal" id="addImg">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">이미지 추가</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	 <div class="col-lg-9" style="display: inline;">
				                	
              	<label for="imgFileUpload">
			        <img src="${pageContext.request.contextPath}/static/img/imgUpload.png" id="imgTarget"/>
			    </label>
              	
			    
			    <div id="image_container" style="display: inline;"></div> <!-- 업로드 된 이미지 미리보기 생성 -->
            </div>
	      	
	      	
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn " data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>

<script>

	$('#btn').click(function(){
		//유효성검사 추가하기 -누르면 승인내역 있으면 submit() 불가
		if($('#qualificationType').val() == ''){
			alert('자격 종류를 선택해주세요');
			$('#qualificationType').focus();
		} else if($('#imgFileUpload').val() == ''){
			alert('이미지를 입력해주세요.');
		} else{
			$.ajax({
				type: 'get',
				url: '${pageContext.request.contextPath}/member/getQualificationChecked',
				data: {
						qualificationTypeId: $('#qualificationType').val(),
						volunteerCategoryId: $('#vTarget').val()
						}
			}).done(function(jsonData){
				console.log(jsonData)
				
				
				if(jsonData == '대기중'){
					alert('이미 신청 후 대기하고 있습니다.')
				} else if(jsonData == ''){			
					$('#addQForm').submit();
					//console.log('신청')
				} else {
					alert('이미 승인되었습니다.')
				}
				
				
				
			})
		
		}
		
		//$('#addQForm').submit();
	})

	$("#qualificationType").change(function(){
		$('#vTarget').empty();
		console.log('변하는거 확인중...');
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getVolunteerByQualificationTypeId',
			data: {'qualificationTypeId': $('#qualificationType').val()}
		}).done(function(jsonData){
			console.log(jsonData);
			
			$.each(jsonData, function(index, data) {
				console.log(data);
				$('#vTarget').append('<option value="'+data.volunteerCategoryId+'">'+data.volunterrCategoryName+'</option>');
			});
			
			
		})
	})
	
	function setThumbnail(event){ 
   		$('#image_container').empty();
   		for (var image of event.target.files) {
   			
   			var reader = new FileReader(); 
   			
   			reader.onload = function(event) {
   				var img = document.createElement("img"); 
   				img.setAttribute("src", event.target.result);
   				img.setAttribute("width", 203);
   				img.setAttribute("height", 203);
   				img.setAttribute("style", "margin-right: 4.5px; border: 1px solid rgb(220, 219, 228);");
   				document.querySelector("div#image_container").appendChild(img); 
   			};
   			
   			console.log(image); 
   			reader.readAsDataURL(image); 
   			
   		}
   		
   		//$('#target').prepend('<input id="imgFileUpload" name="boardFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple"/>');
   	
   	
   	} 
</script>
<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->


	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/isotope.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/ajax-form.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.counterup.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/imagesloaded.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/scrollIt.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.scrollUp.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/wow.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/nice-select.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.slicknav.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.magnific-popup.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/plugins.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/gijgo.min.js"></script>
	
	<!--contact js-->
	<script src="${pageContext.request.contextPath}/static/js/contact.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.ajaxchimp.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/mail-script.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/main.js"></script>


</body>
</html>