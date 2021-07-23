<!-- 작성자 : 남궁혜영 -->
<!-- 파일 넣는 폴더 만들고 파일 불러오기 기능 구현 해야함. 회원쪽에서 자격 신청 등록 구현 후에 가능.-->
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
    <!-- 부트스트랩 cdn -->
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	
	<!-- CSS here -->
	
	<!-- 위의 cdn과 충돌로 인해 모달창 오류 발생. 주석처리함
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
	 -->
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
    
    <!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
let fileName = "";
function viewFile(str){
	console.log(str);
	fileName = str;
	$('#myModal').modal('');
}

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
			<jsp:include page="/WEB-INF/view/manager/myMenu.jsp"></jsp:include>
            <!-- 흰 바탕 네비 바 -->
			<jsp:include page="/WEB-INF/view/manager/managerMenu.jsp"></jsp:include>
        </div>
    </header>

    <!-- bradcam_area_start -->
    <div class="bradcam_area breadcam_bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="bradcam_text text-center">
                        <h3>자격 신청 목록</h3>
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
                			<th>신청날짜</th>
                			<th>승인</th>
                		</tr>
                	</thead>
                	<tbody>
                		<c:forEach var="q" items="${qvaList}">
                		<tr>
               				<td>${q.applicationId}</td>
               				<td>${q.memberId}</td>
               				<td>${q.category}</td>
               				<td>${q.qualificationType}</td>
               				<td>
               				<a href="${pageContext.request.contextPath}/static/img/qualification/${q.qualificationFile}" target="_blank">
               				<strong>${q.qualificationFile}</strong></a></td>
               				<td>${fn:substring(q.date, 0, 11)}</td>
               				<td>
               					<a href="${pageContext.request.contextPath}/manager/approveApplication?applicationId=${q.applicationId}&managerId=${loginManager.managerId}" onclick="return confirm('승인 하시겠습니까?');"><i class="fa fa-check-circle"></i></a>
               					<a href="${pageContext.request.contextPath}/manager/rejectApplication?applicationId=${q.applicationId}&managerId=${loginManager.managerId}" onclick="return confirm('거절 하시겠습니까?');"><i class="fa fa-ban"></i></a>
               				</td>
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
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage-1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage-1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link">${currentPage-1}
					</a></li>
				</c:if>
				<c:if test="${currentPage-1 <= 0}">
				</c:if>
				<!-- /이전 페이지 -->
				<!-- 현재 페이지 -->
					<li class="page-item active"><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage}&lastPage=${lastPage}&searchWord=${searchWord}" 
						 class="page-link">${currentPage}
					</a></li>
				<!-- /현재 페이지 -->
				<!-- 다음 페이지 -->
				<c:if test="${currentPage+1 <= lastPage}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage+1}&lastPage=${lastPage}&searchWord=${searchWord}" 
						class="page-link" aria-label="Next"> ${currentPage+1}
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage+1}&lastPage=${lastPage}&searchWord=${searchWord}" 
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
				<form action="${pageContext.request.contextPath}/manager/getQualificationApplicationList?currentPage=${currentPage}&lastPage=${lastPage}&searchWord=${searchWord}" id="qaList">
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
 </div>
    <!-- pet_care_area_end  -->
       	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">자격 신청 파일</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body text-center">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">	
			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
  
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