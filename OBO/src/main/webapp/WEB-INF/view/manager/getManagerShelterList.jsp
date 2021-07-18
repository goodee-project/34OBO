<!-- 작성자 : 남궁혜영 -->
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
	
	// 검색어 선택 옵션에 따라 비동기 방식으로 인풋창이 다르게 나오도록함. 숨겨진 인풋창의 값은 비우기.
	$('#sName').show();
	$('#sAddress').hide().val('');
	$('#searchBtn').click(function(){
		console.log('보호소 이름 검색');
		$('#shelterList').submit();
	});
	$('#searchSelect').change(function(){
		var optionVal = $('#searchSelect option:selected').val();
		if (optionVal == 'shelterName'){
			$('#sName').show();
			$('#sAddress').hide().val('');
			$('#searchBtn').click(function(){
				console.log('보호소 이름 검색');
				$('#shelterList').submit();
			});
		} else {
			$('#sName').hide().val('');
			$('#sAddress').show();
			$('#searchBtn').click(function(){
				console.log('보호소 주소 검색');
				$('#shelterList').submit();
			});
		}
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
                        <h3>보호소 목록</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- bradcam_area_end -->

    <!-- pet_care_area_start  -->
    <div class="pet_care_area">
        <div class="container">
            <div class="row">
               <table class="table table-hover text-center">
                	<thead>
                		<tr>
                			<th>No.</th>
                			<th>보호소</th>
                			<th>주소</th>
                			<th>보호 기간(일)</th>
                			<th>전화번호</th>
                			<th>계좌번호</th>
                			<th>등록 날짜</th>
                		</tr>
                	</thead>
                	<tbody>
                	    <c:forEach var="s" items="${shelterList}">
                		<tr>
               				<td>${s.shelterId}</td>
               				<td>${s.shelterName}</td>
               				<td>[${s.postCode}] ${s.doro} ${s.detailAddress}</td>
               				<td>${s.protectDuration}</td>
               				<td>${s.shelterPhone}</td>
               				<td>${s.account}</td>
               				<td>${fn:substring(s.createDate, 0, 11)}</td>
                		</tr>
                		</c:forEach>
                	</tbody>
                </table>
            </div>
            <div style="text-align: right;">
        		<a href="${pageContext.request.contextPath}/manager/addShelter" type="button" class="genric-btn primary-border circle arrow medium">등록</a>
        	</div>
        	
        	<!-- 페이징 -->
        	<div class="blog_left_sidebar">
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination">
				<!-- 이전 페이지 -->
				<c:if test="${currentPage-1 >0}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage-1}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage-1}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link">${currentPage-1}
					</a></li>
				</c:if>
				<c:if test="${currentPage-1 <= 0}">
				</c:if>
				<!-- /이전 페이지 -->
				<!-- 현재 페이지 -->
					<li class="page-item active"><a href="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link">${currentPage}
					</a></li>
				<!-- /현재 페이지 -->
				<!-- 다음 페이지 -->
				<c:if test="${currentPage+1 <= lastPage}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage+1}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Next"> ${currentPage+1}
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage+1}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
					</a></li>
				</c:if>
				<!-- /다음 페이지 -->
				</ul>
			</nav>
			<hr>
			<!-- /페이징 -->
			
			<!-- 검색 -->
				<div class="default-select" id="default-select">
				</div>
				<form action="${pageContext.request.contextPath}/manager/getManagerShelterList?currentPage=${currentPage}&lastPage=${lastPage}
						&shelterName=${shelterName}&searchAddress=${searchAddress}" id="shelterList">
				<div class="form-group">
					<div class="input-group mb-4">
						<select id="searchSelect">
							<option value="shelterName">이름</option>
							<option value="searchAddress">주소</option>
						</select>
						<input type="text" id="sName" class="form-control" placeholder='Search Name' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Name'" name="shelterName">
						<input type="text" id="sAddress" class="form-control" placeholder='Search Address' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Address'" name="searchAddress">
						<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</form>
			<!-- /검색 -->
        </div>
    </div>
    </div>
    <!-- pet_care_area_end  -->
    
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