<!-- 작성자: 손영현 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>봉사자격신청</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- CSS here -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- Button to Open the Modal -->
	<button type="button" class="btn" data-toggle="modal" data-target="#myModal">
	  자격별 봉사
	</button>

	<h3>봉사자격신청</h3>
	
	<form id="addQForm" action="${pageContext.request.contextPath}/membe/addQualificationVolunteerApplication" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="qualificationVolunteerApplication.memberId" id="memberId" value="${memberId}">
		<!-- 자격증명리스트 -->
		<select name="qualificationVolunteerApplication.qualificationTypeId" id="qualificationType">
			<option disabled="disabled" selected="selected">선택</option>
			<c:forEach var="q" items="${qTList}">
				<option value="${q.qualificationTypeId}">${q.qualificationTypeName}</option>
			</c:forEach>
		</select>
		
		<!-- 자격별 가능한 봉사 -->
		<select name="qualificationVolunteerApplication.volunteerCategoryId" id="vTarget">
		</select>
		
		<input id="imgFileUpload" name="qualificationFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple" class="imgCheck"/>		   	
	
		<button type="button" class="btn" data-toggle="modal" data-target="#addImg">이미지 추가</button>
		
		<button id="btn" type="button">신청하기</button>
		
		
	</form>
	



	
	<!-- 자격별 신청가능 봉사 소개 -->
	<div class="modal" id="myModal">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">자격별 신청가능 봉사</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        
	        <table class="table">
	        	<tr>
	        		<th>자격종류</th>
	        		<th>가능한봉사</th>
	        	</tr>
	        	<c:forEach var="q" items="${qVList}">
	        		<tr>
	        			<td>${q.qualificationTypeName}</td>
	        			<td>${q.volunteerCategoryName}</td>
	        		</tr>
	        	</c:forEach>
	        </table>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn " data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- 자격별 신청가능 봉사 소개 -->
	<div class="modal" id="addImg">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">이미지 추가</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	      	 <div class="col-lg-9" style="display: inline;">
				                	
              	<label for="imgFileUpload">
			        <img src="${pageContext.request.contextPath}/static/img/imgUpload.png" id="imgTarget"/>
			    </label>
              	
			    
			    <div id="image_container" style="display: inline;"></div> <!-- 업로드 된 이미지 미리보기 생성 -->
            </div>
	      	
	      	
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn " data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>

<script>

	$('#btn').click(function(){
		//유효성검사 추가하기
		
		$('#addQForm').submit();
	})

	$("#qualificationType").change(function(){
		$('#vTarget').empty();
		console.log('변하는거 확인중...');
		$.ajax({
			type: 'get',
			url: '${pageContext.request.contextPath}/member/getVolunteerByQualificationTypeId',
			data: {'qualificationTypeId': $('#qualificationType').val()}
		}).done(function(jsonData){
			console.log(jsonData);
			
			$.each(jsonData, function(index, data) {
				console.log(data);
				$('#vTarget').append('<option value="'+data.volunteerCategoryId+'">'+data.volunterrCategoryName+'</option>');
			});
			
			
		})
	})
	
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
   		
   		//$('#target').prepend('<input id="imgFileUpload" name="boardFile" type="file" style="display: none;" accept="image/*" onchange="setThumbnail(event);" multiple="multiple"/>');
   	
   	
   	} 
</script>

</body>
</html>