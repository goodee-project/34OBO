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
	$('#searchBtn').click(function(){
		console.log('검색!');
		$('#qaList').submit();
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
                        <h3>자격 승인 목록</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- bradcam_area_end -->

    <!-- pet_care_area_start  -->
    <div class="pet_care_area">
        <div class="container">
            <div class="row align-items-center">
               <table class="table table-hover text-center">
                	<thead>
                		<tr>
                			<th>No.</th>
                			<th>회원 아이디</th>
                			<th>봉사 종류</th>
                			<th>자격증 종류</th>
                			<th>파일</th>
                			<th>매니저 아이디</th>
                			<th>승인여부</th>
                			<th>승인날짜</th>
                		</tr>
                	</thead>
                	<tbody>
                	<c:forEach var="q" items="${qcaList}">
                	<input type="text" hidden="hidden" name="fileId" value="${q.fileId}">
                		<tr>
               				<td>${q.qvaId}</td>
               				<td>${q.memberId}</td>
               				<td>${q.volunteerCategory}</td>
               				<td>${q.qualificationType}</td>
               				<td>${q.qualificationFile}</td>
               				<td>${q.managerId}</td>
               				<td>${q.ck}</td>
               				<td>${fn:substring(q.approvalDate, 0, 11)}</td>
                		</tr>
                	</c:forEach>
                	</tbody>
                </table>
            </div>
            <!-- 페이징 -->
        	<div class="blog_left_sidebar">
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination">
				<!-- 이전 페이지 -->
				<c:if test="${currentPage-1 >0}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage-1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage-1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link">${currentPage-1}
					</a></li>
				</c:if>
				<c:if test="${currentPage-1 <= 0}">
				</c:if>
				<!-- /이전 페이지 -->
				<!-- 현재 페이지 -->
					<li class="page-item active"><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link">${currentPage}
					</a></li>
				<!-- /현재 페이지 -->
				<!-- 다음 페이지 -->
				<c:if test="${currentPage+1 <= lastPage}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage+1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						class="page-link" aria-label="Next"> ${currentPage+1}
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage+1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
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
				<form action="${pageContext.request.contextPath}/manager/getQualificationApprovalList?currentPage=${currentPage}&lastPage=${lastPage}&searchWord=${searchWord}" id="qaList">
				<div class="form-group">
					<div class="input-group mb-4">
						<input type="text" id="sName" class="form-control" placeholder='Search Name' onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Member'" name="searchWord">
						<button id="searchBtn" class="btn" type="button"><i class="fa fa-search"></i></button>
					</div>
				</div>
			</form>
			<!-- /검색 -->
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