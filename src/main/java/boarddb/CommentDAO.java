package boarddb;

import java.util.ArrayList;
import java.util.List;

import com.DBCP;

public class CommentDAO extends DBCP { // DBCP 클래스 상속
    public void addComment(int postId, String userId, String content) {
        String sql = "INSERT INTO comments (post_id, user_id, content) VALUES (?, ?, ?)";
        try {
            psmt = con.prepareStatement(sql); // DBCP 클래스의 Connection 사용
            psmt.setInt(1, postId);
            psmt.setString(2, userId);
            psmt.setString(3, content);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(); // DBCP의 자원 해제 메서드 호출
        }
    }

    public List<CommentDTO> getComments(int postId) {
        List<CommentDTO> comments = new ArrayList()<>();
        String sql = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at DESC";
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, postId);
            rs = psmt.executeQuery();
            while (rs.next()) {
                CommentDTO dto = new CommentDTO();
                dto.setCommentId(rs.getInt("comment_id"));
                dto.setPostId(rs.getInt("post_id"));
                dto.setUserId(rs.getString("user_id"));
                dto.setContent(rs.getString("content"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                comments.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(); // 자원 해제
        }
        return comments;
    }
}
