<!-- 작성자 : 이윤정 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>staffAccount</title>
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
	
	
});
</script>
</head>
<body>
	<header>
		<div class="header-area ">
		
			<!-- 검정 바탕 : 로그인 & 회원 정보 페이지 -->
			<div class="header-top_area">
				<div class="container">
					<div class="row">
						<jsp:include page="/WEB-INF/view/staff/inc/myMenu.jsp"></jsp:include>
					</div>
				</div>
			</div>
			
			<!-- 흰색 바탕 : 메인 메뉴 -->
			<div id="sticky-header" class="main-header-area">
				<div class="container">
					<div class="row align-items-center">
						<div class="col-xl-3 col-lg-3">
							<div class="logo">
								<a href="${pageContext.request.contextPath}/staff/">
									<img src="../static/img/logo.png" alt="">
								</a>
							</div>
						</div>
						
						<div class="col-xl-9 col-lg-9">
							<div class="main-menu  d-none d-lg-block">
								<nav>
									<ul id="navigation">
										<jsp:include page="/WEB-INF/view/staff/inc/staffMenu.jsp"></jsp:include>
									</ul>
								</nav>
							</div>
						</div>
						
						<div class="col-12">
							<div class="mobile_menu d-block d-lg-none"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- header_start  -->
	<div class="bradcam_area breadcam_bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h3>계정</h3>
				</div>
			</div>
		</div>
	</div>

	<!--================Blog Area =================-->
	<section class="blog_area section-padding">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget search_widget">
							<form action="#">
								<div class="form-group">
									<div class="input-group mb-3">
										<input type="text" class="form-control"
											placeholder='Search Keyword' onfocus="this.placeholder = ''"
											onblur="this.placeholder = 'Search Keyword'">
										<div class="input-group-append">
											<button class="btn" type="button">
												<i class="ti-search"></i>
											</button>
										</div>
									</div>
								</div>
								<button
									class="button rounded-0 primary-bg text-white w-100 btn_1 boxed-btn"
									type="submit">Search</button>
							</form>
						</aside>

						<aside class="single_sidebar_widget post_category_widget">
							<h4 class="widget_title">Category</h4>
							<ul class="list cat-list">
								<li><a href="#" class="d-flex">
										<p>Resaurant food</p>
										<p>(37)</p>
								</a></li>
								<li><a href="#" class="d-flex">
										<p>Travel news</p>
										<p>(10)</p>
								</a></li>
								<li><a href="#" class="d-flex">
										<p>Modern technology</p>
										<p>(03)</p>
								</a></li>
								<li><a href="#" class="d-flex">
										<p>Product</p>
										<p>(11)</p>
								</a></li>
								<li><a href="#" class="d-flex">
										<p>Inspiration</p>
										<p>21</p>
								</a></li>
								<li><a href="#" class="d-flex">
										<p>Health Care (21)</p>
										<p>09</p>
								</a></li>
							</ul>
						</aside>

						<aside class="single_sidebar_widget popular_post_widget">
							<h3 class="widget_title">Recent Post</h3>
							<div class="media post_item">
								<img src="../static/img/post/post_1.png" alt="post">
								<div class="media-body">
									<a href="single-blog.html">
										<h3>From life was you fish...</h3>
									</a>
									<p>January 12, 2019</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="../static/img/post/post_2.png" alt="post">
								<div class="media-body">
									<a href="single-blog.html">
										<h3>The Amazing Hubble</h3>
									</a>
									<p>02 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="../static/img/post/post_3.png" alt="post">
								<div class="media-body">
									<a href="single-blog.html">
										<h3>Astronomy Or Astrology</h3>
									</a>
									<p>03 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="../static/img/post/post_4.png" alt="post">
								<div class="media-body">
									<a href="single-blog.html">
										<h3>Asteroids telescope</h3>
									</a>
									<p>01 Hours ago</p>
								</div>
							</div>
						</aside>
						<aside class="single_sidebar_widget tag_cloud_widget">
							<h4 class="widget_title">Tag Clouds</h4>
							<ul class="list">
								<li><a href="#">project</a></li>
								<li><a href="#">love</a></li>
								<li><a href="#">technology</a></li>
								<li><a href="#">travel</a></li>
								<li><a href="#">restaurant</a></li>
								<li><a href="#">life style</a></li>
								<li><a href="#">design</a></li>
								<li><a href="#">illustration</a></li>
							</ul>
						</aside>


						<aside class="single_sidebar_widget instagram_feeds">
							<h4 class="widget_title">Instagram Feeds</h4>
							<ul class="instagram_row flex-wrap">
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_5.png" alt="">
								</a></li>
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_6.png" alt="">
								</a></li>
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_7.png" alt="">
								</a></li>
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_8.png" alt="">
								</a></li>
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_9.png" alt="">
								</a></li>
								<li><a href="#"> <img class="img-fluid"
										src="../static/img/post/post_10.png" alt="">
								</a></li>
							</ul>
						</aside>


						<aside class="single_sidebar_widget newsletter_widget">
							<h4 class="widget_title">Newsletter</h4>

							<form action="#">
								<div class="form-group">
									<input type="email" class="form-control"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Enter email'"
										placeholder='Enter email' required>
								</div>
								<button
									class="button rounded-0 primary-bg text-white w-100 btn_1 boxed-btn"
									type="submit">Subscribe</button>
							</form>
						</aside>
					</div>
				</div>
				<div class="col-lg-9 mb-5 mb-lg-0">
					<div class="blog_left_sidebar">
						<article class="blog_item">
							<div class="blog_item_img">
								<img class="card-img rounded-0"
									src="../static/img/blog/single_blog_1.png" alt=""> <a href="#"
									class="blog_item_date">
									<h3>15</h3>
									<p>Jan</p>
								</a>
							</div>

							<div class="blog_details">
								<a class="d-inline-block" href="single-blog.html">
									<h2>Google inks pact for new 35-storey office</h2>
								</a>
								<p>That dominion stars lights dominion divide years for
									fourth have don't stars is that he earth it first without
									heaven in place seed it second morning saying.</p>
								<ul class="blog-info-link">
									<li><a href="#"><i class="fa fa-user"></i> Travel,
											Lifestyle</a></li>
									<li><a href="#"><i class="fa fa-comments"></i> 03
											Comments</a></li>
								</ul>
							</div>
						</article>

						<article class="blog_item">
							<div class="blog_item_img">
								<img class="card-img rounded-0"
									src="../static/img/blog/single_blog_2.png" alt=""> <a href="#"
									class="blog_item_date">
									<h3>15</h3>
									<p>Jan</p>
								</a>
							</div>

							<div class="blog_details">
								<a class="d-inline-block" href="single-blog.html">
									<h2>Google inks pact for new 35-storey office</h2>
								</a>
								<p>That dominion stars lights dominion divide years for
									fourth have don't stars is that he earth it first without
									heaven in place seed it second morning saying.</p>
								<ul class="blog-info-link">
									<li><a href="#"><i class="fa fa-user"></i> Travel,
											Lifestyle</a></li>
									<li><a href="#"><i class="fa fa-comments"></i> 03
											Comments</a></li>
								</ul>
							</div>
						</article>

						<article class="blog_item">
							<div class="blog_item_img">
								<img class="card-img rounded-0"
									src="../static/img/blog/single_blog_3.png" alt=""> <a href="#"
									class="blog_item_date">
									<h3>15</h3>
									<p>Jan</p>
								</a>
							</div>

							<div class="blog_details">
								<a class="d-inline-block" href="single-blog.html">
									<h2>Google inks pact for new 35-storey office</h2>
								</a>
								<p>That dominion stars lights dominion divide years for
									fourth have don't stars is that he earth it first without
									heaven in place seed it second morning saying.</p>
								<ul class="blog-info-link">
									<li><a href="#"><i class="fa fa-user"></i> Travel,
											Lifestyle</a></li>
									<li><a href="#"><i class="fa fa-comments"></i> 03
											Comments</a></li>
								</ul>
							</div>
						</article>

						<article class="blog_item">
							<div class="blog_item_img">
								<img class="card-img rounded-0"
									src="../static/img/blog/single_blog_4.png" alt=""> <a href="#"
									class="blog_item_date">
									<h3>15</h3>
									<p>Jan</p>
								</a>
							</div>

							<div class="blog_details">
								<a class="d-inline-block" href="single-blog.html">
									<h2>Google inks pact for new 35-storey office</h2>
								</a>
								<p>That dominion stars lights dominion divide years for
									fourth have don't stars is that he earth it first without
									heaven in place seed it second morning saying.</p>
								<ul class="blog-info-link">
									<li><a href="#"><i class="fa fa-user"></i> Travel,
											Lifestyle</a></li>
									<li><a href="#"><i class="fa fa-comments"></i> 03
											Comments</a></li>
								</ul>
							</div>
						</article>

						<article class="blog_item">
							<div class="blog_item_img">
								<img class="card-img rounded-0"
									src="../static/img/blog/single_blog_5.png" alt=""> <a href="#"
									class="blog_item_date">
									<h3>15</h3>
									<p>Jan</p>
								</a>
							</div>

							<div class="blog_details">
								<a class="d-inline-block" href="single-blog.html">
									<h2>Google inks pact for new 35-storey office</h2>
								</a>
								<p>That dominion stars lights dominion divide years for
									fourth have don't stars is that he earth it first without
									heaven in place seed it second morning saying.</p>
								<ul class="blog-info-link">
									<li><a href="#"><i class="fa fa-user"></i> Travel,
											Lifestyle</a></li>
									<li><a href="#"><i class="fa fa-comments"></i> 03
											Comments</a></li>
								</ul>
							</div>
						</article>

						<nav class="blog-pagination justify-content-center d-flex">
							<ul class="pagination">
								<li class="page-item"><a href="#" class="page-link"
									aria-label="Previous"> <i class="ti-angle-left"></i>
								</a></li>
								<li class="page-item"><a href="#" class="page-link">1</a></li>
								<li class="page-item active"><a href="#" class="page-link">2</a>
								</li>
								<li class="page-item"><a href="#" class="page-link"
									aria-label="Next"> <i class="ti-angle-right"></i>
								</a></li>
							</ul>
						</nav>
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