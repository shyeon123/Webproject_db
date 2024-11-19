<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String userId = request.getParameter("user_id");

    if (userId == null || userId.trim().isEmpty()) {
        out.print("아이디를 입력하세요.");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe"; // 데이터베이스 URL
        String dbUser = "webproject_db"; // 데이터베이스 사용자명
        String dbPass = "1234"; // 데이터베이스 비밀번호
        Class.forName("oracle.jdbc.OracleDriver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // 중복 아이디 확인 쿼리
        String query = "SELECT COUNT(*) FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int count = rs.getInt(1);
            if (count > 0) {
                out.print("중복된 아이디입니다.");
            } else {
                out.print("사용 가능한 아이디입니다.");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("오류가 발생했습니다. 다시 시도해주세요.");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
