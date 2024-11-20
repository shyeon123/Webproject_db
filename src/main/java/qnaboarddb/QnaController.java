package qnaboarddb;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import qnaboarddb.QnaBoardDTO;
import utils.BoardPage;

//이 컨트롤러(서블릿)의 매핑은 web.xml에서 정의한다.
public class QnaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//게시판에서 목록은 특정 메뉴를 클릭해서 진입하므로 get 방식의 요청임
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//DAO 인스턴스 생성. 생성과 동시에 DBCP를 통해 오라클에 연결된다
		QnaBoardDAO dao2 = new QnaBoardDAO();
		
		//검색어 관련 파라미터 저장을 위해 Map 생성.
		Map<String, Object> map = new HashMap<String, Object>();
		
		//검색을 위해 검색어를 입력했다면 파라미터로 전달된 값을 Map에 저장
		String searchField2 = req.getParameter("searchField2");
		String searchWord2 = req.getParameter("searchWord2");
		if(searchWord2 != null) {
			//검색어가 있는 경우 Map에 파라미터를 저장한다.
			map.put("searchField2", searchField2);
			map.put("searchWord2", searchWord2);
		}
		
		//게시물의 갯수 카운트를 위한 메소드 호출 
		int totalCount = dao2.selectCount(map);
		//결과를 Map에 저장 
		map.put("totalCount", totalCount);
		
		/*페이지 처리 start*/
		//application 내장 객체 얻어옴
		ServletContext application = getServletContext();
		//web.xml에서 컨텍스트 초기화 파라미터를 읽어옴
		//읽어온 값은 String 이므로 연산을 위해 int형으로 변환한다.
		int pageSize = Integer.parseInt(
				application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(
				application.getInitParameter("PAGES_PER_BLOCK"));
		
		/*
		 현재 페이지 확인 : 목록에 처음 진입했을때는 파라미터가 없는 상태이므로
		  			1페이지로 지정한다. 그외 번호가 있다면 받아와서 사용한다.
		 */
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		
		//목록에 출력할 게시물 범위 계산
		int start = (pageNum - 1) * pageSize + 1;
		int end = pageNum * pageSize;
		//DAO로 전달하기 위해 Map에 저장
		map.put("start", start);
		map.put("end", end);
		/*페이지 처리 end*/
		
		//DAO의 메서드를 호출하여 목록에 출력할 게시물을 얻어온다.
		//목록에 출력할 레코드를 인출하기 위한 메서드 호출
		List<QnaBoardDTO> qnaboardLists = dao2.selectListPage(map);
				//DB연결 해제
				dao2.close();
		
		
		
		//뷰에 전달할 매개변수 추가
		//목록 하단에 출력할 페이지 바로가기 링크를 얻어온 후 Map에 추가
		String pagingImg = BoardPage.pagingStr(totalCount,
				pageSize, blockPage, pageNum, "./QnA.do");
		


		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		//View 로 전달할 데이터는 request 영역에 저장한다.
		req.setAttribute("qnaboardLists", qnaboardLists);
		req.setAttribute("map", map);
		//View 로 포워드한다.
		req.getRequestDispatcher("/QnA.jsp")
				.forward(req, resp);
		
		/*
		 request 영역은 포워드된 페이지까지 데이터를 공유할 수 있으므로
		 서블릿에서 처리한 내용은 request 영역을 통해 jsp쪽으로 공유된다. 
	
		  *
		  */
		//System.out.println(boardLists);
		//System.out.println("pageSize: " + pageSize);
		System.out.println(qnaboardLists);
	}

}
