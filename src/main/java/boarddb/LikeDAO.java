package boarddb;

import com.DBCP;

public class LikeDAO extends DBCP { // DBCP 클래스 상속
    public boolean checkIfLiked(int postId, String userId) {
        String sql = "SELECT COUNT(*) FROM likes WHERE post_id = ? AND user_id = ?";
        boolean isLiked = false;
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, postId);
            psmt.setString(2, userId);
            rs = psmt.executeQuery();
            if (rs.next()) {
                isLiked = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return isLiked;
    }

    public void likePost(int postId, String userId) {
        String sql = "INSERT INTO likes (post_id, user_id) VALUES (?, ?)";
        String updateLikesCount = "UPDATE posts SET likes_count = likes_count + 1 WHERE idx = ?";
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, postId);
            psmt.setString(2, userId);
            psmt.executeUpdate();

            psmt = con.prepareStatement(updateLikesCount);
            psmt.setInt(1, postId);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }
}
