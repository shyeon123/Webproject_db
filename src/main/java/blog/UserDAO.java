package blog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
    private DataSource dataSource;

    public UserDAO() {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/UserDB");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 회원 정보 삽입 메서드
    public int insertUser(UserDTO user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;

        String SQL = "INSERT INTO users (user_id, user_pwd, user_name, email, phone) VALUES (?, ?, ?, ?, ?)";

        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPwd());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPhone());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
