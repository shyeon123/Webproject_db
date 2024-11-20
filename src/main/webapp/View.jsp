<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String userId = (String) session.getAttribute("UserId");
String userName = (String) session.getAttribute("UserName");
boolean isLoggedIn = userId != null && userName != null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Blog Post - Start Bootstrap Template</title>
<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap) -->
<link href="css/Poststyles.css" rel="stylesheet" />
</head>
<body>
	<!-- Responsive navbar -->
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="./list.do">블로그</a></li>
					<li class="nav-item"><a class="nav-link" href="./QnA.do">Q&A</a></li>
					<%
					if (isLoggedIn) {
					%>
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
	<!-- Page content -->
	<div class="container mt-5">
		<div class="row">
			<!-- Main content -->
			<div class="col-lg-8">
				<!-- Post content -->
				<article>
					<!-- Post header -->
					<header class="mb-4">
						<h1 class="fw-bolder mb-1">${dto.title}</h1>
						<p class="text-muted">작성자: ${dto.name} | 작성일: ${dto.postdate}
							| 조회수: ${dto.visitcount}</p>
					</header>
					<!-- Post content -->
					<section class="mb-5">
						<p>${dto.content}</p>
						<c:if test="${not empty dto.ofile}">
							<c:choose>
								<c:when
									test="${dto.ofile.endsWith('.jpg') || dto.ofile.endsWith('.png') || dto.ofile.endsWith('.gif')}">
									<img src="./Uploads/${dto.sfile}" style="max-width: 100%;"
										alt="첨부 이미지" />
								</c:when>
								<c:when test="${dto.ofile.endsWith('.mp3')}">
									<audio controls>
										<source src="./Uploads/${dto.sfile}" type="audio/mpeg">
										이 브라우저는 오디오 재생을 지원하지 않습니다.
									</audio>
								</c:when>
								<c:when test="${dto.ofile.endsWith('.mp4')}">
									<video controls style="max-width: 100%;">
										<source src="./Uploads/${dto.sfile}" type="video/mp4">
										이 브라우저는 비디오 재생을 지원하지 않습니다.
									</video>
								</c:when>
								<c:otherwise>
                                    첨부파일: ${dto.ofile}
                                    <a
										href="./download.do?ofile=${dto.ofile}&sfile=${dto.sfile}&idx=${dto.idx}">[다운로드]</a>
								</c:otherwise>
							</c:choose>
						</c:if>
					</section>
				</article>
				<hr />
				<!-- 댓글 입력 폼 -->
				<form action="addComment.do" method="post">
					<input type="hidden" name="post_id" value="${dto.idx}" />
					<textarea class="form-control" name="content" rows="4"
						placeholder="댓글을 입력하세요." required></textarea>
					<div class="d-flex mt-2">
						<button type="submit" class="btn btn-success me-2">댓글 작성</button>
						<!-- 좋아요 버튼 -->
						<button type="button" id="likeButton" class="btn btn-primary">
							좋아요 (<span id="likesCount">${likesCount}</span>)
						</button>
						
				<script src="js/likeHandler.js"></script>
						

					</div>
				</form>
				<hr />
				<!-- 댓글 목록 -->
				<h3>댓글 목록</h3>
				<c:choose>
					<c:when test="${empty comments}">
						<p>등록된 댓글이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="comment" items="${comments}">
							<div>
								<strong>${comment.userId}</strong>: ${comment.content}
								<p>
									<small>${comment.createdAt}</small>
								</p>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- Side widgets -->
			<div class="col-lg-4">
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
					<div class="card-header">회원 정보</div>
					<div class="card-body">
						<%
						if (isLoggedIn) {
						%>
						<p>
							이름:
							<%=userName%></p>
						<p>
							아이디:
							<%=userId%></p>
						<button class="btn btn-primary"
							onclick="location.href='./logout.jsp'">로그아웃</button>
						<%
						} else {
						%>
						<p>로그인 후 정보를 확인할 수 있습니다.</p>
						<button class="btn btn-primary"
							onclick="location.href='./login.jsp'">로그인하기</button>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
