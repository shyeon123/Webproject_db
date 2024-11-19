package boarddb;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		if (session.getAttribute("UserId") == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", "login.jsp");
			return;
		}

		req.getRequestDispatcher("/Write.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		if (session.getAttribute("UserId") == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", "login.jsp");
			return;
		}
		

		String saveDirectory = req.getServletContext().getRealPath("/Uploads");

		String originalFileName = "";
		try {

			originalFileName = FileUtil.uploadFile(req, saveDirectory);

		} catch (Exception e) {
			JSFunction.alertLocation(resp, "파일 업로드 오류 입니다."
					, "./write.do");
			return;
		}

		////
		BoardDTO dto = new BoardDTO();
		dto.setId(session.getAttribute("UserId").toString());
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));

		if (originalFileName != "") {
			String savedFileName = 
					FileUtil.renameFile(saveDirectory, originalFileName);

			dto.setOfile(originalFileName);
			dto.setSfile(savedFileName);
		}

		BoardDAO dao = new BoardDAO();
		
		int result = dao.insertWrite(dto);
		/***********************************************/
		/*더미데이터 100개 입력하기
		for(int i = 1;  i <=100 ; i++) {
			dto.setTitle(req.getParameter("title")+"-" +i);
			dao.insertWrite(dto);
		}*/
		
		/***********************************************/
		
		
		dao.close();

		if (result == 1) {
			resp.sendRedirect("./list.do");

		} else {
			JSFunction.alertLocation(resp, "글쓰기에 실패했습니다. "
					, "./wrtie.do");

		}

	}
}