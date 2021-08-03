<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyShelter</title>

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
<!-- Place favicon.ico in the root directory -->


<!-- CSS here -->
<link rel="stylesheet" href="../static/css/bootstrap.min.css">
<link rel="stylesheet" href="../static/css/owl.carousel.min.css">
<link rel="stylesheet" href="../static/css/magnific-popup.css">
<link rel="stylesheet" href="../static/css/font-awesome.min.css">
<link rel="stylesheet" href="../static/css/themify-icons.css">
<link rel="stylesheet" href="../static/css/nice-select.css">
<link rel="stylesheet" href="../static/css/flaticon.css">
<link rel="stylesheet" href="../static/css/gijgo.css">
<link rel="stylesheet" href="../static/css/animate.css">
<link rel="stylesheet" href="../static/css/slicknav.css">
<link rel="stylesheet" href="../static/css/style.css">
<!-- <link rel="stylesheet" href="css/responsive.css"> -->

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script>
$(document).ready(function(){	
	
	$('#modifyBtn').click(function(){
		console.log('addBtn 버튼 클릭!');
		$('#imgFileUpload').remove();
		if($('#introduction').val() == '') {
			alert('보호소 소개를 입력해주세요')
			$('#introduction').focus();
		}
		else if($('#protectDuration').val() == '') {
			alert('보호소 보호 기간을 입력해주세요')
			$('#protectDuration').focus();
		}
		else if($('#shelterPhone').val() == '') {
			alert('보호소 번호를 입력해주세요')
			$('#shelterPhone').focus();
		}
		else if($('#account').val() == '') {
			alert('보호소 계좌를 입력해주세요')
			$('#account').focus();
		}
		else{
			$('#modifyForm').submit();			
		}		
	});
});
</script>
</head>
<body>
	<header>
		<div class="header-area ">
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<jsp:include page="/WEB-INF/view/staff/inc/myMenu.jsp"></jsp:include>

			<!-- 흰색 바탕 : 메인 메뉴 -->
			<jsp:include page="/WEB-INF/view/staff/inc/staffMenu.jsp"></jsp:include>
		</div>
	</header>

	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h3>보호소 > 정보 수정</h3>
				</div>
			</div>
		</div>
	</div>

	       
	
	<section class="blog_area single-post-area section-padding">
	<div class="container">
		<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<jsp:include page="/WEB-INF/view/staff/inc/side/animalMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
                        <form class="form-contact contact_form" action="${pageContext.request.contextPath}/staff/modifyShelter" method="post" id="modifyForm" enctype="multipart/form-data" novalidate="novalidate">
                         	
                         	<table class="table">
	                         	
	                         	<input type="hidden" name="shelter.shelterId" value="${shelterId}">
	                         	<tr>	
	                				<td style="vertical-align:middle;">등록된 이미지</td>	
									<td>
										<div class="row">
											<c:forEach var="i" items="${imgList}">
												<div class="col-sm-6" id="${i.shelterFileName}">
													<a href="javascript:void(0);" onclick="modalImg('${i.shelterFileId}', '${i.shelterFileName}')">
														<img src="${pageContext.request.contextPath}/static/img/shelter/${i.shelterFileName}" width="300" height="300" alt=""> &nbsp;		
													</a>
												</div>
												
											</c:forEach>
										</div>
									</td>	
								</tr>
	                			<tr>	
	                				<td style="vertical-align:middle;">이미지 등록</td>	
									<td>
											<div class="row">
												<c:forEach var="af" items="${shelterFileList}">
													<img src="static/img/shelter/${af.shelterFileName}" width="300"
														height="300" alt=""> &nbsp;		
												</c:forEach>
											</div>
											<div style="display: inline;">
												<label for="imgFileUpload"> <img src="${pageContext.request.contextPath}/static/img/imgUpload.png" />
												</label> <span id="target"></span> <input id="imgFileUpload" name="shelterFile" type="file" style="display: none;"
													accept="image/*" onchange="setThumbnail(event);"
													multiple="multiple" class="imgCheck" />
												<div id="image_container" style="display: inline;"></div>
												<!-- 업로드 된 이미지 미리보기 생성 -->
											</div>
									</td>	
								</tr>
	                          	<tr>
									<td >보호소 이름</td> <!-- 보호소 이름 수정x -->
									<td >
										<input class="form-control" id="shelterName" type="text" name="shelter.shelterName" value="${shelterMap.shelterName}" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td>보호소 소개</td>
	         						<td>   	
	         							<div>
		                                   	<textarea class="form-control" name="shelter.introduction" id="introduction" rows="5" cols="50">${shelterMap.introduction}</textarea>
		                              	</div>
		                            </td>    
	                            </tr>    
	                            <tr>
									<td>보호 기간</td>
									<td>
										<div>
											<input class="form-control" id="protectDuration" type="text" name="shelter.protectDuration" value="${shelterMap.protectDuration}">
										</div>
										
									</td>
								</tr>
								<tr>
									<td>보호소 번호</td>
									<td>
										<div>
											<input class="form-control" id="shelterPhone" type="text" name="shelter.shelterPhone" value="${shelterMap.shelterPhone}">
										</div>
										
									</td>
								</tr>
	         					<tr>
									<td>계좌</td>
									<td>
										<div>
											<input class="form-control" id="account" type="text" name="shelter.account" value="${shelterMap.account}">
										</div>
										
									</td>
								</tr>
								
								<tr>
									<td width="30%">활동</td> <!-- 1로 해놓고 0을 선택하게 만들기 -->
									<td width="70%">
										<div>
											
											<select class="form-control" id="active" name="shelter.active" >
							                    <option value="0">0</option>
							                    <option value="1" selected="selected">1</option>           					                   
							            </select>
							            <p>0은 비활성화, 1은 활성화</p>
										</div>
										
									</td>
								</tr>	

	                                    
	                      	</table>
	                
	                      <div style="float:right;">				
								<a href="${pageContext.request.contextPath}/staff/shelterIntro"><button type="button" class="genric-btn primary-border radius">뒤로가기</button></a>
								<input id="modifyBtn" type="button" value="등록" class="genric-btn primary-border radius">
						  </div>
                        </form>
                    </div>	
				
						</div>
					</div>
				</div>
			</div>
		</div>	
	</section>
	
	
	<!-- 삭제 확인 모달 -->
	<div class="modal fade" id="login-modal" role="dialog" aria-labelledby="login-modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h5 class="modal-title">이미지를 삭제 하시겠습니까?</h5>
					<button id="ckBtn" type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	

<!-- JS here -->
<script src="../static/js/vendor/modernizr-3.5.0.min.js"></script>
<script src="../static/js/vendor/jquery-1.12.4.min.js"></script>
<script src="../static/js/popper.min.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/owl.carousel.min.js"></script>
<script src="../static/js/isotope.pkgd.min.js"></script>
<script src="../static/js/ajax-form.js"></script>
<script src="../static/js/waypoints.min.js"></script>
<script src="../static/js/jquery.counterup.min.js"></script>
<script src="../static/js/imagesloaded.pkgd.min.js"></script>
<script src="../static/js/scrollIt.js"></script>
<script src="../static/js/jquery.scrollUp.min.js"></script>
<script src="../static/js/wow.min.js"></script>
<script src="../static/js/nice-select.min.js"></script>
<script src="../static/js/jquery.slicknav.min.js"></script>
<script src="../static/js/jquery.magnific-popup.min.js"></script>
<script src="../static/js/plugins.js"></script>
<script src="../static/js/gijgo.min.js"></script>

<!--contact js-->
<script src="../static/js/contact.js"></script>
<script src="../static/js/jquery.ajaxchimp.min.js"></script>
<script src="../static/js/jquery.form.js"></script>
<script src="../static/js/jquery.validate.min.js"></script>
<script src="../static/js/mail-script.js"></script>
<script src="../static/js/main.js"></script>
	
	
<script> 

   	function setThumbnail(event){ 
   		  		
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
   		
   		$('#target').prepend('<input id="imgFileUpload" name="shelterFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple"/>');
   	
   	
   	} 
   	
   	function modalImg(imgId, imgName){
   		$('#ckBtn').attr('onclick', 'deleteImg("'+imgId+'","'+imgName+'")');
   		console.log(imgId);
   		console.log(imgName);
   		$('#login-modal').modal();
   	}
   	
   	//db 삭제는 구현했으나 물리파일 삭제는 구현하지 못함....
   	function deleteImg(imgId, imgName){
   		console.log(imgId);
   		$.ajax({
   			type: 'get',
   			url:  '${pageContext.request.contextPath}/removeShelterFileOne',
   			data: {shelterFileId: imgId, shelterFileName: imgName}
   		}).done(function(jsonData){
   			console.log('성공')
   			
   			console.log(jsonData);
   			if(jsonData>0){
   				$('#'+imgName+'').remove();
   			}
   			
   		})
   	}
</script>

	
</body>
</html>