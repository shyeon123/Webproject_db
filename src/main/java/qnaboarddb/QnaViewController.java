package qnaboarddb;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qnaview.do")
public class QnaViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/*
	 서블릿의 수명주기 메서드중 요청을 받아 get/post 방식을 판단하는 service() 메서드를 통해
	 모든 방식의 요청을 처리 할 스ㅜ 있다.
	  */
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
	        throws ServletException, IOException {

	    QnaBoardDAO dao = new QnaBoardDAO();
	    String idx = req.getParameter("idx");
	    
	    // 조회수 업데이트
	    dao.updateVisitCount(idx);
	    
	    // 게시물 조회
	    QnaBoardDTO dto = dao.selectView(idx);
	    dao.close();

	    // 줄바꿈을 HTML <br> 태그로 처리
	    dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
	    
	    req.setAttribute("dto", dto);
	    req.getRequestDispatcher("/QnaView.jsp").forward(req, resp);
	}

}
