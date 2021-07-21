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
    <link rel="shortcut icon" type="${pageContext.request.contextPath}/static/image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <!-- Place favicon.ico in the root directory -->
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
    
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
//rcId에다가 선택한 recruitId를 넣기 위해서 변수 선언.
var rcId = 0;

// 일반 봉사 신청하는 경우의 함수. done 은 success와 같은 역할을 하고, window.location.href는 어디로 보낼지 지정해준다.

function applyVolunteerP(num){
    $.ajax({
        type: 'get',
        url: '${pageContext.request.contextPath}/member/getMemberIdForCheckApplyingP',
        data: {'recruitId': num}
    }).done(function (jsonData) {
    	rcId = num;
    	console.log(num);
    	console.log(jsonData);
    	if(jsonData == ''){ //중복 없으면 모달창
			$('#myModal').modal();
		} else { //중복 있으면 경고창
			alert('동일 날짜에 봉사 신청 이력이 존재합니다.');
		}
    });
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
		$('#volunteerNList').submit();
	});
	$('#ck').click(function(){
		console.log('신청!');
		console.log(rcId);
		window.location.href = '${pageContext.request.contextPath}/member/addVolunteerPApply?recruitId='+rcId+'&determination='+ $('#determination').val();
	});
});
</script>
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

    <!-- bradcam_area_start -->
    <div class="bradcam_area breadcam_bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="bradcam_text text-center">
                        <h3>정기 봉사 모집</h3>
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
                			<th>제목</th>
                			<th>봉사종류</th>
                			<th>봉사요일</th>
                			<th>시작날짜</th>
                			<th>모집인원</th>
                			<th>신청인원</th>
                			<th>신청</th>
                		</tr>
                	</thead>
                	<tbody>
                	<c:forEach var="r" items="${recruitList}">
                		<tr>
                			<!-- 1. 신청 기간이고, 모집인원과 신청 인원이 동일하지 않은경우 신청 가능.
               				2. 신청 기간이고, 인원이 찬 경우 신청 불가 : 인원 마강 
               				3. 신청 기간이 아니면 모두 신청 불가 : 신청기간 마감 -->
                			<c:if test="${r.recruitCount != r.applyCount && r.startDate > currentDate}">
	               				<td>${r.recruitId}</td>
	               				<td>${r.shelterName}</td>
	               				<td>${r.title}</td>
	               				<td>${r.categoryName}</td>
	               				<td>${r.volunteerCycle}요일</td>
	               				<td>${fn:substring(r.startDate, 0, 11)}</td>
	               				<td>${r.recruitCount} 명</td>
	               				<td>${r.applyCount} 명</td>
	               				<td><a class="btn" onclick="applyVolunteerP(${r.recruitId})"><i class="fa fa-check-circle"></i></a></td>
               				</c:if> 
               				<c:if test="${r.recruitCount == r.applyCount || r.startDate <= currentDate}">
	               				<td style="color:grey">${r.recruitId}</td>
	               				<td style="color:grey">${r.shelterName}</td>
	               				<td style="color:grey">${r.title}</td>
	               				<td style="color:grey">${r.categoryName}</td>
	               				<td style="color:grey">${r.volunteerCycle}요일</td>
	               				<td style="color:grey">${fn:substring(r.startDate, 0, 11)}</td>
	               				<td style="color:grey">${r.recruitCount} 명</td>
	               				<td style="color:grey">${r.applyCount} 명</td>
               				</c:if>
               				<c:if test="${r.recruitCount == r.applyCount && r.startDate > currentDate}">
               					<td><a href=""><i class="fa fa-check-circle" onclick="alert('인원이 마감되었습니다.'); return false;"></i></a></td>
               				</c:if>
               				<c:if test="${r.startDate <= currentDate}">
               					<td><a href=""><i class="fa fa-check-circle" onclick="alert('신청 기간이 아닙니다.'); return false;"></i></a></td>
               				</c:if>
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
					<li class="page-item"><a href="${pageContext.request.contextPath}/member/getVolunteerP?currentPage=${currentPage-1}
						&searchWord=${searchWord}" class="page-link" aria-label="Previous"> <i class="ti-angle-left"></i>
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/member/getVolunteerP?currentPage=${currentPage-1}
						&searchWord=${searchWord}" class="page-link">${currentPage-1}
					</a></li>
				</c:if>
				<c:if test="${currentPage-1 <= 0}">
				</c:if>
				<!-- /이전 페이지 -->
				<!-- 현재 페이지 -->
					<li class="page-item active"><a href="${pageContext.request.contextPath}/member/getVolunteerP?currentPage=${currentPage}
						&searchWord=${searchWord}" class="page-link">${currentPage}
					</a></li>
				<!-- /현재 페이지 -->
				<!-- 다음 페이지 -->
				<c:if test="${currentPage+1 <= lastPage}">
					<li class="page-item"><a href="${pageContext.request.contextPath}/member/getVolunteerP?currentPage=${currentPage+1}
						&searchWord=${searchWord}" class="page-link" aria-label="Next"> ${currentPage+1}
					</a></li>
					<li class="page-item"><a href="${pageContext.request.contextPath}/member/getVolunteerP?currentPage=${currentPage+1}
						&searchWord=${searchWord}" class="page-link" aria-label="Next"> <i class="ti-angle-right"></i>
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
				<form action="${pageContext.request.contextPath}/member/getVolunteerP" id="volunteerNList">
				<div class="form-group">
					<div class="input-group mb-4">
					    <div class="list">
							<select name="categoryName">
								<option value="">봉사카테고리선택</option>
								<c:forEach var="c" items="${categoryNameList}">
								<option value="${c}">${c}</option>
								</c:forEach>
							</select>
            			</div>
						<input type="text" id="sName" class="form-control" placeholder='보호소 이름을 검색하세요.' onfocus="this.placeholder = ''" onblur="this.placeholder = '보호소 이름을 검색하세요.'" name="searchWord">
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
          <h4 class="modal-title">정기 봉사 신청</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body text-center">
        <div id="recruitIdTarget"></div>
	       	<div> 
	       	정기봉사는 <strong>매주</strong> 해당하는 요일에 필수적으로 참여하셔야 합니다.
	       	<br> 이에 동의 하지 않으신다면 '취소'를 눌러주시고, 동의 하신다면 아래에 '각오(*필수)'를 작성 해주세요. 
	       	<br> 작성해주신 내용에 따라 보호소에서 확인 후 봉사 신청이 <strong>거절</strong>될 수 있습니다.</div>
	       	<hr>
	        <div><input type="text" style="width:700px;height:200px" name="determination" id="determination"></div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        	<button type="button" class="btn btn-secondary" id="ck">확인</button>
			<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        </div>
        
      </div>
    </div>
  </div>
    
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