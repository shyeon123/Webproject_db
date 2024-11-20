package qnaboarddb;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

//게시물 수정하기
@WebServlet("/qnaedit.do")
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
		)
public class QnaEditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//수정페이지로 진입하기
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요", 
					"login.jsp");
			return;
		}
		String idx = req.getParameter("idx");
		QnaBoardDAO dao = new QnaBoardDAO();
		QnaBoardDTO dto = dao.selectView(idx);
		
		if(!dto.getId().equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다.");
			return;
		}
		
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("QnaEdit.jsp")
					.forward(req, resp);
	
	}
	//수정 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		//로그인 확인
		HttpSession session = req.getSession();
		//로그인 전이라면 로그인 페이지로 이동
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요", 
					"login.jsp");
			return;
			}
		//작성자 본인 확인 : 수정폼의 hidden 속성으로 추가한 내용으로 비교
		if(!req.getParameter("id").equals(session.getAttribute("UserId")
						.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다.");
			return;
		}
		
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		String originalFileName = "";
		try {
			originalFileName = FileUtil.uploadFile(req, saveDirectory);
		}
		catch (Exception e) {
			JSFunction.alertBack(resp, "파일 업로드 오류입니다..");
			return;
		}
		
		String idx = req.getParameter("idx");
		//기존에 입력된 파일 정보(원본 파일명, 저장된 파일명)
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		//dto에 저장
		QnaBoardDTO dto = new QnaBoardDTO();
		//파일을 제외한 나머지 폼값을 먼저 저장
		dto.setIdx(idx);
		//특히 아이디는 session에 저장된 내용으로 추가 
		dto.setId(session.getAttribute("UserId").toString());
		dto.setTitle(title);
		dto.setContent(content);
		
		//원본 파일명과 저장된 파일 이름 설정
		if(originalFileName != "") {
			//새로운 파일을 업로드 하는 경우에는 서버에 저장된 파일명을 변경한다.
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
		//파일정보를 DTO에 저장
		dto.setOfile(originalFileName);
		dto.setSfile(savedFileName);
		
		FileUtil.deleteFile(req, "/Upload", prevSfile);
		}else {
			//첨부파일이 없으면 기존 이름 유지(hidden 입력 상자에 설정한 내용)
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		QnaBoardDAO dao = new QnaBoardDAO();
		int result = dao.updatePost(dto);
		dao.close();
		//성공 / 실패?
		if(result == 1) { //수정 성공
			//수정에 성공하면 '열람'페이지로 이동해서 수정된 내용을 확인한다.
			resp.sendRedirect("./qnaview.do?idx=" + idx);
		}else { //수정 실패:경고창을 띄운다
			JSFunction.alertLocation(resp, "게시글 수정을 실패했습니다", 
					"./qnaview.do?idx=" + idx);
		}
		
	}
	
}
