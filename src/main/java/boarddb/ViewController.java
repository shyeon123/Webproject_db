package boarddb;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/view.do")
public class ViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String idx = req.getParameter("idx");
        String userId = (String) req.getSession().getAttribute("UserId"); // 현재 로그인 사용자 ID

        if (idx == null || idx.isEmpty() || userId == null) {
            resp.sendRedirect("list.do");
            return;
        }

        // 게시글 정보 가져오기
        BoardDAO boardDao = new BoardDAO();
        BoardDTO dto = boardDao.selectView(idx);

        if (dto == null) {
            boardDao.close();
            resp.sendRedirect("list.do");
            return;
        }

        // 조회수 증가 조건 - 쿠키 확인
        String visitKey = "post_" + idx + "_user_" + userId; // 쿠키 키 생성
        boolean hasVisited = false;

        // 쿠키 검사
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(visitKey)) {
                    hasVisited = true; // 이미 방문한 경우
                    break;
                }
            }
        }

        // 조회수 증가 및 쿠키 생성
        if (!hasVisited) {
            boardDao.updateVisitCount(idx); // 조회수 증가
            Cookie newCookie = new Cookie(visitKey, URLEncoder.encode(userId, "UTF-8"));
            newCookie.setMaxAge(getSecondsUntilMidnight()); // 자정까지 남은 시간 설정
            newCookie.setPath("/"); // 모든 경로에서 접근 가능
            resp.addCookie(newCookie);
        }

        boardDao.close();

        // 게시글 내용 처리 및 View 전달
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
        req.setAttribute("dto", dto);

        req.getRequestDispatcher("/View.jsp").forward(req, resp);
    }

    // 자정까지 남은 시간을 초 단위로 반환
    private int getSecondsUntilMidnight() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime midnight = now.plusDays(1).truncatedTo(ChronoUnit.DAYS);
        return (int) ChronoUnit.SECONDS.between(now, midnight);
    }
}
