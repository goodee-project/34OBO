<!-- 작성자 : 남민정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>addStaff</title>

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
					<h3>동물 > 동물 등록</h3>
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
						<form class="form-contact contact_form" id="addAnimal" action="${pageContext.request.contextPath}/staff/addAnimal" method="post" enctype="multipart/form-data" >
							<table class="table">
								<tr>
									<td style="vertical-align:middle;">이미지 등록</td>	
									<td>
										<div class="row">
											<c:forEach var="af" items="${animalFileList}"> <!-- <-- 이 fileList는 대체 뭔가요...? - 윤정 -->
												<img src="static/img/animal/${af.animalFileName}" width="300"
													height="300" alt=""> &nbsp;		
											</c:forEach>
										</div>
										<div style="display: inline;">
											<label for="imgFileUpload"> <img src="${pageContext.request.contextPath}/static/img/imgUpload.png" />
											</label> <span id="target"></span> <input id="imgFileUpload" name="animalFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);"
												multiple="multiple" class="imgCheck" />
											<div id="image_container" style="display: inline;"></div>
											<!-- 업로드 된 이미지 미리보기 생성 -->
										</div>
									</td>	
								</tr>
								<tr>
									<td width="40%">동물 종</td>
									<td width="60%">
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
									</td>
								</tr>
								<tr>
									<td>보호소 번호</td>
									<td>
										<input class="form-control" id="shelterId" type="text" name="animal.shelterId" hidden="hidden" value="${shelterId}">
									</td>
								</tr>
								<tr>
									<td>동물 이름</td>
									<td>
										<input class="form-control" id="animalName" type="text" name="animal.animalName">
									</td>
								</tr>
								<tr>
									<td>동물 나이(개월)</td>
									<td>
										<div>
											<input class="form-control" id="animalAge" type="text" name="animal.animalAge">
										</div>
										
									</td>
								</tr>
								<tr>
									<td>동물 성별</td>
									<td>
										<select class="form-control" id="animalSex" name="animal.animalSex">
											<option value="">==성별 선택==</option>
						                    <option value="수컷">수컷</option>
						                    <option value="암컷">암컷</option>
						                    <option value="수컷(중성화)">수컷(중성화)</option>
						                    <option value="암컷(중성화)">암컷(중성화)</option>
						                   
					                  	</select>
									</td>
								</tr>
								<tr>
									<td>동물 무게</td>
									<td>
										<div>
											<input class="form-control" id="animalWeight" type="text" name="animal.animalWeight">
										</div>
									</td>
								</tr>
								<tr>
									<td>동물 종류</td>
									<td>
										<input class="form-control" id="animalKind" type="text" name="animal.animalKind">
									</td>
								</tr>
								<tr>
									<td>발견한 장소</td>
									<td>
										<input class="form-control" id="animalFindPlace" type="text" name="animal.animalFindPlace">
									</td>
								</tr>
								<tr>
									<td>동물 상세정보<br>(회원 보여줄 노트)</td>
									<td>
										<div>
											<textarea class="form-control" name="animal.animalNote" id="animalNote" rows="5" cols="50"></textarea>
										</div>
									</td>
								</tr>
								<tr>
									<td>동물 상태</td>
									<td>
					                  	<input class="form-control" id="animalState" type="text" name="animal.animalState" value="보호중">
									</td>
								</tr>
								<tr>
									<td>동물 소개</td>
									<td>
										<div>
											<textarea class="form-control" name="animal.animalIntroduce" id="animalIntroduce" rows="5" cols="50"></textarea>
										</div>
									</td>
								</tr>
							</table>
						<br>
					<div style="float:right;">
						<a href="${pageContext.request.contextPath}/staff/getAnimalList"><button type="button" class="genric-btn primary-border radius">뒤로가기</button></a>
						<input id="addBtn" type="button" value="등록" class="genric-btn primary-border radius">
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	</div>
		
</section>	






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


       } 
    $(document).ready(function() {
            $('#addBtn').click(function() {
                console.log('btn click...');
               $('#addAnimal').submit();
            });
     });
</script>



</body>
</html>