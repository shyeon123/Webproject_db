package boarddb;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addComment.do")
public class AddCommentController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");
        int postId = Integer.parseInt(req.getParameter("post_id"));
        String content = req.getParameter("content");

        if (userId == null || content == null || content.trim().isEmpty()) {
            resp.sendRedirect("view.do?idx=" + postId);
            return;
        }

        // try-with-resources로 CommentDAO 사용
        try (CommentDAO dao = new CommentDAO()) {
            dao.addComment(postId, userId, content);
        }

        resp.sendRedirect("view.do?idx=" + postId);
    }
}
