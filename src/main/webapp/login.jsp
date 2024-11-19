<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" 
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">홈</a></li>
                    <li class="nav-item"><a class="nav-link" href="./list.do">블로그</a></li>
                    <li class="nav-item"><a class="nav-link" href="./QnA.jsp">Q&A</a></li>
                    <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">로그인</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 로그인 영역 -->
    <div class="login-container">
        <div class="card mb-4">
            <div class="card-header text-center" onsubmit="return validateFrom(this)">로그인</div>
            <div class="card-body">
                <form action="loginProcess.jsp" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="user_Id" name="user_id" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="user_Pwd" name="user_pwd" required>
                    </div>

                    <!-- 버튼 그룹 -->
                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">로그인</button>
                        <a href="register.jsp" class="btn btn-secondary">회원가입</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer-->
    <footer class="py-5 bg-dark">
        <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
    </footer>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js2/scripts.js"></script>
</body>
</html>
