<!-- 작성자 : 남궁혜영 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Animal</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- <link rel="manifest" href="site.webmanifest"> -->
<link rel="shortcut icon" type="${pageContext.request.contextPath}/static/image/x-icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
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
	/// ${pageContext.request.contextPath}/addAnimalLike?animalId=${animalMap.animalId}&currentPage=${currentPage}&searchWord=${searchWord}&species=${species}&shelterId=${shelterId}"
	function addAnimalLike(animalId, currentPage, searchWord, species, shelterId, loginMember){
		if(loginMember==null || loginMember==''){
			alert('로그인 후 이용 가능합니다.');
		} else {
			$.ajax({
				type:'get',
				url: '${pageContext.request.contextPath}/getAnimalLikeByMember',
				data: {'animalId':animalId}
			}).done(function (jsonData){
				console.log(animalId);
				console.log(jsonData);
				if(jsonData==0){
					window.location.href='${pageContext.request.contextPath}/addAnimalLike?animalId='+animalId+'&currentPage='+currentPage+'&searchWord='+searchWord+'&species='+species+'&shelterId='+shelterId;
					alert('관심동물에 추가되었습니다!');
				} else {
					alert('이미 좋아요한 동물입니다.');
				}
			});
		}
	};
	
	function addAdopt(loginMember, animalId){
		if(loginMember==null || loginMember==''){
			alert('로그인 후 이용 가능합니다.');
		} else {
			var ck = confirm('동물을 입양 하시겠습니까?');
			if(ck == true){
				window.location.href='<c:url value="/addAdoptForm?animalId='+animalId+'"/>';
			} else {
				return;
			}
		}
	}
			
	$(document).ready(function(){
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

	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h3>No. ${animalMap.animalId} | ${animalMap.animalName}</h3>
				</div>
			</div>
		</div>
	</div>
	
	 <!-- animalList start  -->
    <div class="team_area">           
	<div class="container">
	    <table class="table">
	        <tbody>
	        	<tr>
					<td>보호 종료 날짜  </td>
					<td><strong>${expectedDay}</strong></td>
					<td></td>
	            </tr>
	        	<tr>
	               <td></td>
	               <td><a class="btn" onclick="$('#myModal').modal();"><i class="fa fa-search-plus"></i>
	               <img src="${pageContext.request.contextPath}/static/img/animal/${animalMap.animalFileName}" height="300px" width="300px" alt=""> 
	               </a></td>
	               <td><h2><strong>${animalMap.animalName} </strong></h2><br>
	               <h4>나이 : ${animalMap.animalAge} 개월 </h4><br>
	               <h4>무게 : ${animalMap.animalWeight} Kg </h4><br>
	               <h4>성별 : ${animalMap.animalSex} </h4><br>
	               <h4>동물 종 : ${animalMap.species} / ${animalMap.animalKind} </h4><br>
	               <c:if test="${animalMap.animalState ne '보호중'}">
	               </c:if>
	               <c:if test="${animalMap.animalState eq '보호중'}">
	               		<h4><a class="btn" data-parameter1="${animalMap.animalId}" data-parameter2="${currentPage}" data-parameter3="${searchWord}" data-parameter4="${species}" data-parameter5="${shelterId}" data-parameter6="${loginMember.memberId}"
		               		onclick="addAnimalLike(this.getAttribute('data-parameter1'), this.getAttribute('data-parameter2'), this.getAttribute('data-parameter3'), this.getAttribute('data-parameter4'), this.getAttribute('data-parameter5'), this.getAttribute('data-parameter6'))">
		               		<i class="fa fa-heart" style="size:9x"></i></a>&nbsp;&nbsp;
			               <a class="genric-btn primary-border circle arrow medium" data-parameter1="${loginMember.memberId}" data-parameter2="${animalMap.animalId}"
			               		onclick="addAdopt(this.getAttribute('data-parameter1'), this.getAttribute('data-parameter2'))"> &emsp; 입양 &emsp;</a></h4>
	               </c:if>
	               </td>
	           </tr>
	           <tr>
	               <td>보호소 </td>
	               <td><a href="${pageContext.request.contextPath}/getShelterOne?shelterId=${shelterId}">
						<i class="fa fa-home"></i> ${animalMap.shelterName}</a></td>
					<td></td>
	           </tr>
	           <tr>
	               <td>발견 장소 </td>
	               <td>${animalMap.animalFindPlace}</td>
	               <td></td>
	           </tr>
	           <tr>
	               <td>특이 사항 </td>
	               <td>${animalMap.animalNote}</td>
	               <td></td>
	              </tr>
	           <tr>
	               <td>동물 입소 날짜 </td>
	               <td>${fn:substring(animalMap.animalEnterDate, 0, 11)}</td>
	               <td></td>
	           </tr>
	           <tr>
	               <td>동물 상태 </td>
	               <td>${animalMap.animalState}</td>
	               <td></td>
	           </tr>
	           
			</tbody>   
		</table>
		
		<div>
			<a class="float-right"
			href="${pageContext.request.contextPath}/getAnimalList?currentPage=${currentPage}&searchWord=${searchWord}&species=${species}&shelterId=${shelterId}">
			<i class="fa fa-undo"></i> 뒤로가기</a>	
	    </div>
	</div>
	</div> 
	   	<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg" style="max-width: 70%; width: auto;">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">${animalMap.animalName}</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body text-center">
	       	<div><img src="${pageContext.request.contextPath}/static/img/animal/${animalMap.animalFileName}"></div>
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
	
	<!--contact js-->
	<script src="${pageContext.request.contextPath}/static/js/contact.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.ajaxchimp.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/mail-script.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>