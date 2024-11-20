package boarddb;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.DBCP;

public class LikeDAO extends DBCP implements AutoCloseable {

    @Override
    public void close() {
        try {
            if (rs != null) rs.close();
            if (psmt != null) psmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 확인
    public boolean checkIfLiked(int postId, String userId) {
        String sql = "SELECT COUNT(*) FROM likes WHERE post_id = ? AND user_id = ?";
        boolean isLiked = false;

        try {
            psmt = con.prepareStatement(sql);

            // 파라미터 설정
            psmt.setInt(1, postId);
            psmt.setString(2, userId);

            rs = psmt.executeQuery();
            if (rs.next()) {
                isLiked = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isLiked;
    }

    // 좋아요 처리
    public void likePost(int postId, String userId) {
        String insertSql = "INSERT INTO likes (post_id, user_id) VALUES (?, ?)";
        String updateLikesCountSql = "UPDATE board SET likes_count = likes_count + 1 WHERE idx = ?";

        try {
            psmt = con.prepareStatement(insertSql);
            psmt.setInt(1, postId);
            psmt.setString(2, userId);
            psmt.executeUpdate();

            psmt = con.prepareStatement(updateLikesCountSql);
            psmt.setInt(1, postId);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 수 가져오기
    public int getLikesCount(int postId) {
        String sql = "SELECT COUNT(*) FROM likes WHERE post_id = ?";
        int likesCount = 0;

        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, postId);
            rs = psmt.executeQuery();
            if (rs.next()) {
                likesCount = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return likesCount;
    }
}
