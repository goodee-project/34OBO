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

<!-- 부트스트랩 cdn -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

<!-- CSS here -->
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

	<!--================Blog Area =================-->
	<!-- 카드형식 필요할 때 : <section class="blog_area section-padding"> -->
	<section class="blog_area single-post-area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget post_category_widget category_setting">
							<jsp:include page="/WEB-INF/view/staff/inc/side/shelterMenu.jsp"></jsp:include>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="single-post">
						<div class="blog_details">
                        <form class="form-contact contact_form" action="${pageContext.request.contextPath}/staff/modifyShelter" method="post" id="modifyForm" enctype="multipart/form-data" novalidate="novalidate">
                         	<input type="hidden" name="shelter.shelterId" value="${shelterId}">
                            	<div class="col-12">
                            	
								<div class="col-lg-3">
									<h4>사진 추가<span style="color: #7fad39;">*</span></h4>
								</div>
								<div class="col-lg-9" style="display: inline;">

									<label for="imgFileUpload"> <img
										src="${pageContext.request.contextPath}/static/img/imgUpload.png" />
									</label> <span id="target"></span> <input id="imgFileUpload"
										name="shelterFile" type="file" style="display: none;"
										accept="image/*" onchange="setThumbnail(event);"
										multiple="multiple" class="imgCheck" />
									<div id="image_container" style="display: inline;"></div>
									<!-- 업로드 된 이미지 미리보기 생성 -->
								</div>

         						<div class="col-12">
                                    <div class="form-group"> <!-- 보호소 이름 수정x -->
                                        <input class="form-control" name="shelter.shelterName" id="shelterName" type="text" value="${shelterMap.shelterName}" readonly="readonly"> 
                                    </div>
                                </div>
                             	
         						<div class="col-12">
                                    <div class="form-group">
                                        <textarea class="form-control w-100" name="shelter.introduction" id="introduction" cols="30" rows="9" onfocus="this.placeholder = ''" onblur="this.placeholder = '소개'">${shelterMap.introduction}</textarea>
                                    </div>
                                </div>
                                
         						<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="shelter.protectDuration" id="protectDuration" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '보호기간'" value="${shelterMap.protectDuration}">
                                    </div>
                                </div>
                             	
                             	<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="shelter.shelterPhone" id="shelterPhone" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '번호'" value="${shelterMap.shelterPhone}">
                                    </div>
                                </div>
                             	
                             	<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="shelter.account" id="account" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '계좌'" value="${shelterMap.account}">
                                    </div>
                                </div>
                             	
                              	<!-- 1로 해놓고 0을 선택하게 만들기 -->
								<div>
									<select class="form-control" id="active" name="shelter.active" >
						                    <option value="0">0</option>
						                    <option value="1" selected="selected">1</option>           					                   
						            </select>
								</div>
                                
                            </div>
                            <div class="form-group mt-3">
                                <button type="button" id="modifyBtn" class="button button-contactForm boxed-btn">등록</button>
                            </div>
                        </form>
                    </div>	
				
						</div>
					</div>
				</div>
			</div>
	</section>
	<!--================Blog Area =================-->


	<!-- footer_start  -->
	<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
	<!-- footer_end  -->	
	
	<!-- JS here -->
	<script src="${pageContext.request.contextPath}/static/js/vendor/jquery-1.12.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/vendor/modernizr-3.5.0.min.js"></script>
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
</script>

	<script>
	$('#datepicker').datepicker({
		iconsLibrary: 'fontawesome',
		disableDaysOfWeek: [0, 0],
		//icons: {
		//rightIcon: '<span class="fa fa-caret-down"></span>'
		//}
	});
	
	$('#datepicker2').datepicker({
		iconsLibrary: 'fontawesome',
		icons: {
			rightIcon: '<span class="fa fa-caret-down"></span>'
		}
	});
	
	var timepicker = $('#timepicker').timepicker({
		format: 'HH.MM'
	});
</script>	
	
</body>
</html>