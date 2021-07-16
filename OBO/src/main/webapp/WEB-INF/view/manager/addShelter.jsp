<!-- 작성자 : 남궁혜영 -->
<!-- 유효성 검사 해야 됨! -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Animal</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="../static/image/x-icon" href="../static/img/favicon.png">
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
    
    <!-- 다음 우편번호 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
<script>
$(document).ready(function(){
	$('#loginBtn').click(function(){
		console.log('login!');
		$('#loginForm').submit();
	});
	$('#logoutBtn').click(function(){
		console.log('logout!');
		$('#logout').submit();
	});
	$('#addshelter').click(function(){
		console.log('보호소등록!');
		$('#addshelterForm').submit();
	});
});
</script>
</head>

<body>
    <header>
        <div class="header-area ">
        	
        	<!-- 검정 바탕 네비 바 -->
            <div class="header-top_area">
				<div class="container">
					<div class="row">
						<jsp:include page="/WEB-INF/view/manager/myMenu.jsp"></jsp:include>
                    </div>
                </div>
            </div>
            
            <!-- 흰 바탕 네비 바 -->
            <div id="sticky-header" class="main-header-area">
                <div class="container">
                    <div class="row align-items-center">
						<jsp:include page="/WEB-INF/view/manager/managerMenu.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- bradcam_area_start -->
    <div class="bradcam_area breadcam_bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="bradcam_text text-center">
                        <h3>보호소 등록</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- bradcam_area_end -->

     <!--================Blog Area =================-->
    <section class="blog_area section-padding">
        <div class="container">
       	 <form action="${pageContext.request.contextPath}/manager/addShelter" method="post" id="addShelterForm">
            <div class="row">
                <div class="col-lg-6">
                        <article class="blog_item">
                            <div class="blog_details">
                            	<h2>보호소</h2>
                            	<table class="table">
                            		<tr>
                            			<td><p>보호소 이름</p></td>
                            			<td><input class="text" name="shelterName"></td>
                            		</tr>
                            		<tr>
                            			<td><p>보호소 소개</p></td>
                            			<td><input class="text" name="introduction"></td>
                            		</tr>
                            		<tr>
                            			<td><p>보호소 주소</p></td>
                            			<td>
	                            			<input type="text" id="sample4_postcode" name="postCode" placeholder="우편번호">
											<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
											<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="doro">
											<span id="guide" style="color:#999;display:none"></span>
											<div>
												<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="detailAddress">		
											</div>
										</td>
                            		</tr>
                            		<tr>
                            			<td><p>전화번호</p></td>
                            			<td><input type="text" name="shelterPhone"></td>
                            		</tr>
                            		<tr>
                            			<td><p>보호기간(일)</p></td>
                            			<td><input type="text" name="protectDuration"></td>
                            		</tr>
                            		<tr>
                            			<td><p>계좌번호</p></td>
                            			<td><input type="text" name="account"></td>
                            		</tr>
                            	</table>
                            </div>
                        </article>
                    </div>
                    <div class="col-lg-6">
                        <article class="blog_item">
                        	<div class="blog_details">
                        	<!-- 마스터 직원 주소는 shelter와 동일. 성별은 무조건 비공개. birth는 NOW()-->
							<h2>마스터 직원</h2>
                            	<table class="table">
                            		<tr>
                            			<td><p>아이디</p></td>
                            			<td><input class="text" name="memberID"></td>
                            		</tr>
                            		<tr>
                            			<td><p>비밀번호</p></td>
                            			<td><input type="password" id="memberPw" name="memberPw"></td>
                            		</tr>
                            		<tr>
                            			<td><p>비밀번호 확인</p></td>
                            			<td>
                            				<input type="password" id="memberPwCheck">
                            				<span id="pwCheck"></span>
                            			</td>
                            		</tr>
                            		<tr>
                            			<td><p>이름</p></td>
                            			<td><input type="text" name="memberName"></td>
                            		</tr>
                            		<tr>
                            			<td><p>닉네임</p></td>
                            			<td><input type="text" name="memberNickName"></td>
                            		</tr>
                            		<tr>
                            			<td><p>전화번호</p></td>
                            			<td><input type="text" name="memberPhone"></td>
                            		</tr>
                            		<tr>
                            			<td><p>이메일</p></td>
                            			<td><input type="text" name="memberEmail"></td>
                            		</tr>
                            	</table>
                            </div>
                        </article>
                    </div>
                </div>
                <div style="text-align: right;">
                <a href="${pageContext.request.contextPath}/manager/getManagerShelterList" onclick="return confirm('보호소 등록을 취소 하시겠습니까?');" class="genric-btn danger-border circle arrow medium">취소</a>
               	<button class="genric-btn primary-border circle arrow medium" id="addShelter">등록</button>
                </div>
                </form>
        </div>
    </section>
    <!--================Blog Area =================-->
    
    <!-- footer_start  -->
		<jsp:include page="/WEB-INF/view/footer.jsp"></jsp:include>
    <!-- footer_end  -->

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
        $('#datepicker').datepicker({
            iconsLibrary: 'fontawesome',
            disableDaysOfWeek: [0, 0],
        //     icons: {
        //      rightIcon: '<span class="fa fa-caret-down"></span>'
        //  }
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