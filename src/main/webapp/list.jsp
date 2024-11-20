<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<%
// 세션에서 로그인 정보를 가져옵니다.
String userId = (String) session.getAttribute("UserId");
String userName = (String) session.getAttribute("UserName");

// 로그인 상태 확인
boolean isLoggedIn = userId != null;
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
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">블로그</a></li>
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
							<tr>
								<th width="10%">번호</th>
								<th width="*">제목</th>
								<th width="15%">작성자</th>
								<th width="10%">조회수</th>
								<th width="15%">작성일</th>
								<th width="8%">첨부</th>
							</tr>
							<c:choose>
								<c:when test="${ empty boardLists }">
									<!-- List에 저장된 값이 없다면 등록된 게시물이 없거나, 검색된 게시물이 없는경우. -->
									<tr>
										<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
									</tr>
								</c:when>
								<c:otherwise>
									<!-- List에 저장된 데이터가 있다면, 크기만큼 반복하여 출력한다.	해당 루프의 데이터를 인출하여 변수 row에 저장한다. -->

									<c:forEach items="${ boardLists }" var="row" varStatus="loop">
										<tr align="center">
											<td>
												<!-- 게시물의 갯수를 저장한 totalCount 에서 인출되는 인스턴스의 인덱스를 차감해서 순차적인 번호를 출력--> 
												 ${ map.totalCount - (((map.pageNum-1) * map.pageSize)	+ loop.index) }
											</td>
											<td align="left">
												<!-- 제목클릭시 '열람' 페이지로 이동해야하므로 게시물의 일련번호를 파라미터로 저장한다. --> <a
												href="./view.do?idx=${ row.idx }"> ${ row.title }</a>
											</td>
											<!-- 현재 루프에서 row는 MVCBoardeDTO를 의미하므로     각 멤버변수의 getter()를 통해 저장된 값을 출력한다. -->
											<td>${ row.id }</td>
											<td>${ row.visitcount }</td>
											<td>${ row.postdate }</td>
											<td>
												<!-- 첨부파일이 있는 경우에만 다운로드 링크를 출력한다. --> 
												<c:if	test="${ not empty row.ofile }">
													<a href="./download.do?ofile=${ row.ofile }
													 &sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
						
						
						
						
						 <!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%">
        <tr align="center">
        <!-- 현재는 페이지 번호 없음 -->
            <td>
            ${ map.pagingImg }
            </td>
            <td width="100"><button type="button"
                onclick="location.href='./write.do';">
                	글쓰기</button></td>
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
					<div class="card-header">블로그 포스트 검색</div>
					<div class="card-body">
						<form method="get">  
  
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
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
			<p class="m-0 text-center text-white">Copyright &copy; Your	Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js2/scripts.js"></script>
	<c:out value="${ boardList }" />
</body>
</html>
