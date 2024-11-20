package boarddb;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/likePost.do")
public class LikePostController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String postIdParam = req.getParameter("post_id");
        String userId = (String) req.getSession().getAttribute("UserId");

        if (postIdParam == null || postIdParam.isEmpty()) {
            System.out.println("Error: post_id is null or empty");
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\"}");
            return;
        }

        if (userId == null) {
            System.out.println("Error: User not logged in");
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\"}");
            return;
        }

        int postId = Integer.parseInt(postIdParam);

        try (LikeDAO likeDao = new LikeDAO()) {
            boolean alreadyLiked = likeDao.checkIfLiked(postId, userId);
            if (!alreadyLiked) {
                likeDao.likePost(postId, userId);
                int updatedLikesCount = likeDao.getLikesCount(postId);

                System.out.println("Success: Updated likes count = " + updatedLikesCount);
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"success\", \"likesCount\":" + updatedLikesCount + "}");
            } else {
                System.out.println("Error: Already liked by user " + userId);
                resp.setContentType("application/json");
                resp.getWriter().write("{\"status\":\"alreadyLiked\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"error\"}");
        }
    }
}

