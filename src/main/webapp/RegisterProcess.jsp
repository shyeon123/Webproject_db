<%@ page import="blog.UserDAO" %>
<%@ page import="blog.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 가져오기
    String userId = request.getParameter("user_id");
    String userPwd = request.getParameter("user_pwd");
    String userName = request.getParameter("user_name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    // UserDTO 객체 생성 및 값 설정
    UserDTO user = new UserDTO();
    user.setUserId(userId);
    user.setUserPwd(userPwd);
    user.setUserName(userName);
    user.setEmail(email);
    user.setPhone(phone);

    // UserDAO를 통해 데이터베이스에 사용자 정보 삽입
    UserDAO userDAO = new UserDAO();
    int result = userDAO.insertUser(user);

    if (result > 0) {
        out.println("<script>alert('회원가입 성공'); location.href='login.jsp';</script>");
    } else {
        out.println("<script>alert('회원가입 실패'); history.back();</script>");
    }
%>
