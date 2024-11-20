package boarddb;

import com.DBCP;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO extends DBCP implements AutoCloseable {

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

    // 댓글 목록 페이징 처리
    public List<CommentDTO> getCommentsWithPagination(int postId, int offset, int limit) {
        List<CommentDTO> comments = new ArrayList<>();
        String sql = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            psmt = con.prepareStatement(sql); // prepareStatement를 try-with-resources에서 제외
            psmt.setInt(1, postId);
            psmt.setInt(2, offset);
            psmt.setInt(3, limit);
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
            try {
                if (psmt != null) psmt.close();
                if (rs != null) rs.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return comments;
    }

    // 전체 댓글 수 가져오기
    public int getTotalComments(int postId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE post_id = ?";
        int total = 0;
        try {
            psmt = con.prepareStatement(sql); // prepareStatement를 try-with-resources에서 제외
            psmt.setInt(1, postId);
            rs = psmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (psmt != null) psmt.close();
                if (rs != null) rs.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return total;
    }
 // 댓글 추가 메서드
    public void addComment(int postId, String userId, String content) {
        String sql = "INSERT INTO comments (post_id, user_id, content, created_at) VALUES (?, ?, ?, SYSDATE)";
        try {
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, postId);
            psmt.setString(2, userId);
            psmt.setString(3, content);
            psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("댓글 추가 중 오류 발생");
        } finally {
            try {
                if (psmt != null) psmt.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

}
