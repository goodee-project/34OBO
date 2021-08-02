<!-- 작성자 : 남민정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>modifyAnimal</title>

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

<script>
$(document).ready(function(){	
	
	$('#modifyBtn').click(function(){
		console.log('addBtn 버튼 클릭!');
		$('#imgFileUpload').remove();
	   $('#modifyForm').submit();
		if($('#animalName').val() == '') {
			alert('동물 이름을 입력해주세요')
			$('#animalName').focus();
		}
		else if($('#animalAge').val() == '') {
			alert('동물 나이(개월수)를 입력해주세요')
			$('#animalAge').focus();
		}
		else if($('#animalSex').val() == '') {
			alert('동물 성별을 입력해주세요')
			$('#animalSex').focus();
		}
		else if($('#animalWeight').val() == '') {
			alert('동물 무게를 입력해주세요')
			$('#animalWeight').focus();
		}
		else if($('#animalKind').val() == '') {
			alert('동물의 종류(ex:발바리, 말티즈)를 입력해주세요')
			$('#animalKind').focus();
		}
		else if($('#animalFindPlace').val() == '') {
			alert('동물 발견 장소를 입력해주세요')
			$('#animalFindPlace').focus();
		}
		else if($('#animalNote').val() == '') {
			alert('동물 상세정보(회원에게 보여줄 내용)를 입력해주세요')
			$('#animalNote').focus();
		}
		else if($('#animalState').val() == '') {
			alert('동물 상태를 입력해주세요')
			$('#animalState').focus();
		}
		else if($('#animalIntroduce').val() == '') {
			alert('동물 소개를 입력해주세요')
			$('#animalIntroduce').focus();
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
					<h3>동물 수정</h3>
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
						<div class="col-lg-8">
                        <form class="form-contact contact_form" action="${pageContext.request.contextPath}/staff/modifyAnimal" method="post" id="modifyForm" enctype="multipart/form-data" novalidate="novalidate">

                         	<input type="hidden" name="animal.animalId" value="${animalId}">
                            	<div class="col-12">
                            	<div class="testmonial_area">
										<div class="row">
											<c:forEach var="af" items="${animalFileList}">
											<input hidden="" id="animalFileId" value="${af.animalFileId}">
												<img src="static/img/animal/${af.animalFileName}" width="300"
													height="300" alt=""> &nbsp;		
											</c:forEach>
										</div>
									</div>
								<div class="col-lg-3">
									<h4>사진 추가<span style="color: #7fad39;">*</span></h4>
								</div>
								<div class="col-lg-9" style="display: inline;">

									<label for="imgFileUpload"> <img
										src="${pageContext.request.contextPath}/static/img/imgUpload.png" />
									</label> <span id="target"></span> <input id="imgFileUpload"
										name="animalFile" type="file" style="display: none;"
										accept="image/*" onchange="setThumbnail(event);"
										multiple="multiple" class="imgCheck" />
									<div id="image_container" style="display: inline;"></div>
									<!-- 업로드 된 이미지 미리보기 생성 -->
								</div>
								
								<div class="default-select col-12" id="default-select">
									<select name="animal.animalCategoryId" class="form-control">
											<option value="">==종 선택==</option>
												<c:forEach var="a" items="${animalCategoryList}">
									    			<c:if test="${a.species == species}"> 
									    				<option value="${a.animalCategoryId}" id="animalCategoryId" selected="selected">${a.species}</option>
									    			</c:if>
									    			<c:if test="${a.species != species}"> 
									    				<option value="${a.animalCategoryId}">${a.species}</option>
									    			</c:if>
									    		</c:forEach>
											</select>
								</div>
								
                                
                                
         						<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalName" id="animalName" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 이름'" placeholder="${animalName}">
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalAge" id="animalAge" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 나이(개월수)'" placeholder="${animalAge}">
                                    </div>
                                </div>
                             	
                             	<div class="default-select col-12" id="default-select">
									<select class="form-control" id="animalSex" name="animal.animalSex">
										<option value="">==성별 선택==</option>
					                    <option value="수컷">수컷</option>
					                    <option value="암컷">암컷</option>
					                    <option value="수컷(중성화)">수컷(중성화)</option>
					                    <option value="암컷(중성화)">암컷(중성화)</option>
				                  	</select>
								</div>
								
								<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalWeight" id="animalWeight" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 무게'" placeholder="${animalWeight}">
                                    </div>
                                </div>
                             	
                             	<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalKind" id="animalKind" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 종'" placeholder="${animalKind}">
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalFindPlace" id="animalFindPlace" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '발견 장소'" placeholder="${animalFindPlace}">
                                    </div>
                                </div>
                             	
         						<div class="col-12">
                                    <div class="form-group">
                                        <textarea class="form-control w-100" name="animal.animalNote" id="animalNote" cols="30" rows="9" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 상세정보(회원 보여줄 노트)'" placeholder="${animalNote}"></textarea>
                                    </div>
                                </div>
                                
                                <div class="default-select col-12" id="default-select">
									<select class="form-control" id="animalState" name="animal.animalState">
										<option value="">==상태 선택==</option> 
					                    <option value="입양">입양</option>
					                    <option value="보호중">보호중</option>
					                    <option value="안락사">안락사</option>
					                    <option value="자연사">자연사</option>
				                  	</select>
								</div>
                             	
     
         						<div class="col-12">
                                    <div class="form-group">
                                        <textarea class="form-control w-100" name="animal.animalIntroduce" id="animalIntroduce" cols="30" rows="9" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 소개'" placeholder="${animalIntroduce}"></textarea>
                                    </div>
                                </div>
                                
                             	<!--  animalExitDate를 널값으로 넣을 수도 있고 시간을 now로도 변경할 수 있게 만들어야함.
                             	<div class="col-12">
                                    <div class="form-group">
                                        <input class="form-control" name="animal.animalExitDate" id="animalExitDate" type="text" onfocus="this.placeholder = ''" onblur="this.placeholder = '동물 나간 시간'" placeholder="${shelterMap.account}">
                                    </div>
                                </div>
                             	-->

                            </div>
                            <div class="form-group mt-3">
								<button type="button" id="modifyBtn" class="button button-contactForm boxed-btn">등록</button>
								<a href="${pageContext.request.contextPath}/staff/getAnimalList"><button type="button">뒤로가기</button></a>
							</div>
                        </form>
                    </div>	
				
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	
	
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
   		
   		$('#target').prepend('<input id="imgFileUpload" name="animalFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple"/>');
   	
   	
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
</body>
</html>