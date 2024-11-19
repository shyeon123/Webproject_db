package utils;

public class BoardPage {
	/*
	 totalCount :  전체 게시물의 수
	 pageSize : web.xml에 설정한 값. 한 페이지에 출력할 게시물 수
	 blockPage :  위와 동일 . 한 블럭당 출력할 페이지의 번호 수
	 pageNum :  현재 진입해있는 페이지 번호
	 reqUrl :  게시판 목록의 요청명 혹은 현재 페이지 URL 
	 * */
	
	
	public static String pagingStr(int totalCount, int pageSize, int blockPage,
			int pageNum, String reqUrl) {
		String pagingStr = "";
		
		int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));
		//이전 페이지 블록 바로가기 출력
		
		
		/*
		 * 페이지 블럭에서 첫번째 페이지번호를 구하기 위한 계산식
		 * 우리는 blockPage를 5로 설정했으므로 아래 계산식에 pageNum 1~5를 대입해보면
		 * 1의 결과가 나온다. 
		 * 즉 1~5페이지일때는 pageTemp가 1이 되어 반복하면서 출력할수있다.
		 * */
		
		
		
		int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
		
		
		if(pageTemp != 1) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[첫 페이지]</a>";
			pagingStr += " &nbsp";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + (pageTemp -1)
						+ "'>[이전 블럭]</a>";
		}
		int blockCount = 1;
		while(blockCount <= blockPage && pageTemp <=totalPages) {
			if(pageTemp == pageNum ) {
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			}else {
				pagingStr += "&nbsp;<a href='" + reqUrl + "?pageNum=" + pageTemp
							+"'>" + pageTemp + "</a>&nbsp;";
			}
			pageTemp++;
			blockCount++;
		}
		
		if(pageTemp <= totalPages) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + pageTemp
						+"'>[다음 블록]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + totalPages
						+ "'>[마지막 페이지]</a>";
		}
		return pagingStr;

	}
}
