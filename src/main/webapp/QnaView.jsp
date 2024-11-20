<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<p class="fs-5 mb-4"></p>
						<p class="fs-5 mb-4"></p>
						<p class="fs-5 mb-4"></p>
						<h2 class="fw-bolder mb-4 mt-5">대충 게시판 들어갈 자리</h2>
						<table border="1" width="90%">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="*" />
		</colgroup>
		<tr>
			<td>번호</td>
			<td>${ dto.idx }</td>
			<td>작성자</td>
			<td>${ dto.name }</td>
		</tr>
		
		<tr>
			<td>작성일</td>
			<td>${ dto.postdate }</td>
			<td>조회수</td>
			<td>${ dto.visitcount }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${ dto.title }</td>

		</tr>

		<tr>
			<td>내용</td>
			<td colspan="3" height="100">${ dto.content } 
			<c:if	test="${ not empty dto.ofile }">
					<br>
					<c:choose>
						<c:when
							test="${ dto.ofile.endsWith('.jpg') or dto.ofile.endsWith('.png') or dto.ofile.endsWith('.gif') }">
							<img src="./Uploads/${ dto.sfile }" style="max-width: 100%;"
								alt="첨부 이미지" />
						</c:when>
						<c:when test="${ dto.ofile.endsWith('.mp3') }">
							<audio controls>
								<source src="./Uploads/${ dto.sfile }" type="audio/mpeg">
								이 브라우저는 오디오 재생을 지원하지 않습니다.
							</audio>
						</c:when>
						<c:when test="${ dto.ofile.endsWith('.mp4') }">
							<video controls style="max-width: 100%;">
								<source src="./Uploads/${ dto.sfile }" type="video/mp4">
								이 브라우저는 비디오 재생을 지원하지 않습니다.
							</video>
						</c:when>


						
					</c:choose>
				</c:if>
			</td>
		</tr>


		<td colspan="4" align="center">
    <!-- 로그인 상태일 때만 수정/삭제 버튼 표시 -->
   <c:if test="${ UserId eq dto.id }">
        <button type="button" onclick="location.href='./qnaedit.do?idx=${ param.idx }';">수정하기</button>
        <button type="button" onclick="location.href='./qnadelete.do?idx=${ param.idx }';">삭제하기</button>
    </c:if>
    <!-- 목록 버튼은 항상 표시 -->
    <button type="button" onclick="location.href='./QnA.do';">목록</button>
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
