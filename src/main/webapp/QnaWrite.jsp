<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
<title>Blog Post - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/Poststyles.css" rel="stylesheet" />
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
					<li class="nav-item"><a class="nav-link" href="index.jsp">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="#">블로그</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="./QnA.do">Q&A</a></li>

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
	<!-- Page content-->
	<div class="container mt-5">
		<div class="row">
			<div class="col-lg-8">
				<!-- Post content-->
				<article>
					<!-- Post header-->
					<header class="mb-4">
						<!-- Post title-->
						<h1 class="fw-bolder mb-1">블로그 게시판!</h1>
					</header>
					<!-- Preview image figure-->

					<!-- Post content-->
					<section class="mb-5">
						
						<script type="text/javascript">
							function validateForm(form) { // 필수 항목 입력 확인
								if (form.title.value == "") {
									alert("제목을 입력하세요.");
									form.title.focus();
									return false;
								}
								if (form.content.value == "") {
									alert("내용을 입력하세요.");
									form.content.focus();
									return false;
								}
							}
						</script>
						</head>
						<h2>파일 첨부형 게시판 - 글쓰기(Write)</h2>
						<form name="writeFrm" method="post" enctype="multipart/form-data"	action="./qnawrite.do"	onsubmit="return validateForm(this);">
							<table border="1" width="90%">
								<tr>
									<td>제목</td>
									<td><input type="text" name="title" style="width: 90%;" />
									</td>
								</tr>
								<tr>
									<td>내용</td>
									<td><textarea name="content"
											style="width: 90%; height: 100px;"></textarea></td>
								</tr>
								<tr>
									<td>첨부 파일</td>
									<td><input type="file" name="ofile" /></td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<button type="submit">작성 완료</button>
										<button type="reset">RESET</button>
										<button type="button"
											onclick="location.href='./QnA.do';">목록
											바로가기</button>
									</td>
								</tr>
							</table>
					</section>
				</article>
				<!-- Comments section-->

			</div>
			<!-- Side widgets-->
			<div class="col-lg-4">
				<!-- Search widget-->
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


						<button type="button" class="btn btn-primary w-40"
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
	<script src="js2/scripts.js"></script>
</body>
</html>
