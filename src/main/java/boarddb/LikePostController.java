package boarddb;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/likePost.do")
public class LikePostController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("UserId");
        int postId = Integer.parseInt(req.getParameter("post_id"));

        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try (LikeDAO dao = new LikeDAO()) {
            boolean alreadyLiked = dao.checkIfLiked(postId, userId);
            if (!alreadyLiked) {
                dao.likePost(postId, userId);
            }
        }

        resp.sendRedirect("view.do?idx=" + postId);
    }
}
