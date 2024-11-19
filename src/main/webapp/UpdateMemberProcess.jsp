<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userId = (String) session.getAttribute("UserId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userName = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");

    String jdbcDriver = "oracle.jdbc.driver.OracleDriver";
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
    String dbUser = "webproject_db";
    String dbPassword = "1234";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName(jdbcDriver);
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String sql = "UPDATE users SET name = ?, email = ?, phone = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userName);
        pstmt.setString(2, email);
        pstmt.setString(3, phone);
        pstmt.setString(4, userId);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('회원 정보가 성공적으로 수정되었습니다!'); location.href='correction.jsp';</script>");
        } else {
            out.println("<script>alert('수정 실패. 다시 시도해주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
