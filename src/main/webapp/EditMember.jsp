<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 상태 확인
    String userId = (String) session.getAttribute("UserId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 기존 회원 정보 가져오기 (MemberInfo.jsp와 동일)
    String userName = "";
    String email = "";
    String phone = "";

    // 데이터베이스 연결 설정
    String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "webproject_db";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName(jdbcDriver);
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "SELECT user_name, email, phone FROM users WHERE user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("name");
            email = rs.getString("email");
            phone = rs.getString("phone");
        } else {
            out.println("<script>alert('회원 정보를 찾을 수 없습니다.'); location.href='index.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
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
<style>
/* 로그인 div 중앙 정렬 및 너비 조정 */
.login-container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 50px;
}

.card {
	width: 50%; /* 너비를 절반으로 설정 */
	min-width: 300px;
	padding: 20px;
}

/* 버튼을 나란히 배치 */
.button-group {
	display: flex;
	justify-content: space-between;
}

/* 버튼 크기 조정 */
.btn {
	width: 48%;
}
</style>
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
					<li class="nav-item"><a class="nav-link" href="Post.jsp">블로그</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">회원 정보</a></li>
				</ul>
			</div>
		</div>
	</nav>
   <div class="login-container">
		<div class="card mb-4">
			<div class="card-header text-center">회원 정보</div>
			<div class="card-body">
				<form action="UpdateMemberProcess.jsp" method="post">
        <label for="user_name">이름:</label>
        <input type="text" id="name" name="name" value="<%= userName %>" required><br>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required><br>

        <label for="phone">전화번호:</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" required><br>

        <button type="submit">수정</button>
    </form>
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
</body>
</html>