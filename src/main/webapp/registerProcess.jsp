<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 클라이언트에서 전달된 폼 데이터 받기
    String userId = request.getParameter("user_id");
    String userPwd = request.getParameter("user_pwd");
    String userName = request.getParameter("user_name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    // 데이터베이스 연결 설정
    String jdbcDriver = "oracle.jdbc.driver.OracleDriver"; // Oracle 드라이버
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";  // DB URL (본인의 DB 설정에 맞게 변경)
    String dbUser = "webproject_db";                        // DB 사용자 이름
    String dbPassword = "1234";                // DB 비밀번호

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // JDBC 드라이버 로드
        Class.forName(jdbcDriver);
        // 데이터베이스 연결
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // 회원 정보 삽입 SQL
        String sql = "INSERT INTO users (id, pass,  name, email, phone) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPwd);
        pstmt.setString(3, userName);
        pstmt.setString(4, email);
        pstmt.setString(5, phone);

        // 쿼리 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 회원가입 성공
            out.println("<script>alert('회원가입이 성공적으로 완료되었습니다!'); location.href='login.jsp';</script>");
        } else {
            // 회원가입 실패
            out.println("<script>alert('회원가입에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        // 오류 처리
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        // 리소스 해제
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
