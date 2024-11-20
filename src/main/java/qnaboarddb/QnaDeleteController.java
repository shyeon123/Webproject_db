package qnaboarddb;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import oracle.jdbc.Const;
import utils.JSFunction;

@WebServlet("/qnadelete.do")
public class QnaDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, 
					"로그인 후 이용해주세요", "login.jsp");
			return;
		}
		String idx = req.getParameter("idx");
		QnaBoardDAO dao = new QnaBoardDAO();
		QnaBoardDTO dto = dao.selectView(idx);
		
		if(!dto.getId().equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 삭제할 수 있습니다.");
			return;
		}
		int result = dao.deletePost(idx);
		dao.close();
		if(result==1) {
			String saveFileName = dto.getSfile();
			FileUtil.deleteFile(req, "/Uploads", saveFileName);
		}
		JSFunction.alertLocation(resp, "삭제되었습니다", "./QnA.do");
		//confirm("정말 삭제 하시겠습니까?");
		
	
	}

	

}
