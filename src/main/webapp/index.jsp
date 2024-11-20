<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// 세션에서 로그인 정보를 가져옵니다.
String userId = (String) session.getAttribute("UserId");
String userName = (String) session.getAttribute("UserName");

// 로그인 상태 확인
boolean isLoggedIn = userId != null && userName != null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Blog Home - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Responsive navbar-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="./index.jsp">Start Bootstrap</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">홈</a></li>

					<li class="nav-item"><a class="nav-link" href="./list.do">블로그</a></li>
					<li class="nav-item"><a class="nav-link" href="./QnA.do">Q&A</a></li>
					<%
					if (isLoggedIn) {
					%>
					<!-- 여기는 로그인 됐을때 -->
					<li class="nav-item"><a class="nav-link"
						href="./correction.jsp">회원 정보</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link" href="./login.jsp">로그인</a></li>

					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Page header with logo and tagline-->
	<header class="py-5 bg-light border-bottom mb-4">
		<div class="container">
			<div class="text-center my-5">
				<h1 class="fw-bolder">아직 대충 만든 블로그에 오신걸 환영합니다!</h1>
				<p class="lead mb-0">아직 아무내용 없음</p>
			</div>
		</div>
	</header>
	<!-- Page content-->
	<div class="container">
		<div class="row">
			<!-- Blog entries-->
			<div class="col-lg-8">
				<!-- Featured blog post-->
				<div class="card mb-4">
					<a href="#!"><img class="card-img-top"
						src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
					<div class="card-body">
						<div class="small text-muted">January 1, 2023</div>
						<h2 class="card-title">메인 포스트 타이틀</h2>
						<p class="card-text">대충 내용</p>
						<a class="btn btn-primary" href="#!">Read more →</a>
					</div>
				</div>
				<!-- Nested row for non-featured blog posts-->
				<div class="row">
					<div class="col-lg-6">
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">January 1, 2023</div>
								<h2 class="card-title h4">아마그냥 포스트 1</h2>
								<p class="card-text">대충 포스트 1 내용</p>
								<a class="btn btn-primary" href="#!">Read more →</a>
							</div>
						</div>
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">January 1, 2023</div>
								<h2 class="card-title h4">아마그냥 포스트 2</h2>
								<p class="card-text">대충 포스트 2 내용</p>
								<a class="btn btn-primary" href="#!">Read more →</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">January 1, 2023</div>
								<h2 class="card-title h4">아마 그냥 포스트 3</h2>
								<p class="card-text">대충 포스트 3 내용</p>
								<a class="btn btn-primary" href="#!">Read more →</a>
							</div>
						</div>
						<!-- Blog post-->
						<div class="card mb-4">
							<a href="#!"><img class="card-img-top"
								src="https://dummyimage.com/700x350/dee2e6/6c757d.jpg" alt="..." /></a>
							<div class="card-body">
								<div class="small text-muted">January 1, 2023</div>
								<h2 class="card-title h4">아마 그냥 포스트 4</h2>
								<p class="card-text">대충 포스트 4</p>
								<a class="btn btn-primary" href="#!">Read more →</a>
							</div>
						</div>
					</div>
				</div>
				<!-- Pagination-->
				<nav aria-label="Pagination">
					<hr class="my-0" />
					<ul class="pagination justify-content-center my-4">
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true">Newer</a></li>
						<li class="page-item active" aria-current="page"><a
							class="page-link" href="#!">1</a></li>
						<li class="page-item"><a class="page-link" href="#!">2</a></li>
						<li class="page-item"><a class="page-link" href="#!">3</a></li>
						<li class="page-item disabled"><a class="page-link" href="#!">...</a></li>
						<li class="page-item"><a class="page-link" href="#!">15</a></li>
						<li class="page-item"><a class="page-link" href="#!">Older</a></li>
					</ul>
				</nav>
			</div>




			<!-- Side widgets-->
			<div class="col-lg-4">
				<!-- Search widget-->
				<div class="card mb-4">
					<div class="card-header">블로그 포스트 검색</div>
					<div class="card-body">
						<form method="get" action="./list.do">

							<tr>
								<td align="center"><select name="searchField">
										<option value="title">제목</option>
										<option value="content">내용</option>
								</select> <input type="text" name="searchWord" /> <input type="submit"
									value="검색하기" /></td>
							</tr>

						</form>
					</div>
				</div>
				<div class="card mb-4">
					<div class="card-header">Q&A 포스트 검색</div>
					<div class="card-body">
						<form method="get">

							<tr>
								<td align="center"><select name="searchField2">
										<option value="title">제목</option>
										<option value="content">내용</option>
								</select> <input type="text" name="searchWord2" /> <input type="submit"
									value="검색하기" /></td>
							</tr>

						</form>

					</div>
				</div>

				<!-- Side widget-->
				<!-- Login widget-->
				<div class="card mb-4">
					<div class="card-header">회원 정보</div>
					<div class="card-body">
						<%
						if (isLoggedIn) {
						%>
						<!-- 로그인된 상태 -->
						<p>
							이름:
							<%=userName%></p>
						<p>
							아이디:
							<%=userId%></p>


						<button type="button" class="btn btn-primary w-100"
							onclick="location.href='./logout.jsp'">로그아웃</button>
						<%
						} else {
						%>
						<!-- 로그인되지 않은 상태 -->
						<p>로그인 후 정보를 확인할 수 있습니다.</p>
						<button type="button" class="btn btn-primary w-100"
							onclick="location.href='./login.jsp'">로그인하기</button>

						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
