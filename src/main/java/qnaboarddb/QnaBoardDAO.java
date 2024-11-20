package qnaboarddb;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.DBCP;



//DBCP (커넥션 풀)을 통해 Oracle에 연결하기 위해 상속을 받아 정의 
public class QnaBoardDAO extends DBCP {

	// 기본 생성자를 통해 부모 클래스의 생성자 호출 (생략가능)
	public QnaBoardDAO() {
		super();
	}

	// 게시물의 갯수를 카운트
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		// 오라클의 그룹 함수는 count()를 사용해서 쿼리문 작성
		String query = "SELECT COUNT(*) FROM qnaboard";
		// 매개변수로 전달된 검색어가 있는 경우에만 where절을 동적으로 추가
		if (map.get("searchWord2") != null) {
			query += " WHERE " + map.get("searchField2") + "" + " LIKE '%" + map.get("searchWord2") + "%'";
		}
		try {
			// Statement 인스턴스 생성(정적 쿼리문 실행)
			stmt = con.createStatement();
			// 쿼리문을 실행한 후 결과를 ResultSet으로 변환받는다.
			rs = stmt.executeQuery(query);
			/*
			 * count() 함수는 조건에 상관없이 항상 결과가 인출되므로 if문과 같은 조건절 없이 바로 next() 함수를 실행할수있다.
			 */
			rs.next();
			// 반환된 결과를 저장한다.

			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 카운트중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;

	}

	// 글쓰기 처리를 위한 쿼리문 실행
	public int insertWrite(QnaBoardDTO dto) {
		int result = 0;
		try {
			/*
			 * default값이 있는 3개의 컬럼을 제외한 나머지 컬럼에 대해서만 insert쿼리문을 작성 일련번호 idx 의 경우에는 시퀀스를 사용
			 */
			String query = "INSERT INTO qnaboard ( " 
					+ " idx, id, title, content, ofile, sfile)" 
					+ " VALUES ( "
					+ " seq_board3_num.NEXTVAL, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			// 쿼리문 실행 insert쿼리의 경우 입력된 행의 갯수가 반환됨.
			result = psmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 입력중 예외발생");
			e.printStackTrace();
		}
		return result;
	}

	// 게시판 목록에 출력할 레코드를 인출하기위한 메소드 정의
	public List<QnaBoardDTO> selectList(Map<String, Object> map) {
		// 오아클에서 인출한 레코드를 저장하기 위한List 생성
		List<QnaBoardDTO> qnaboard = new Vector<QnaBoardDTO>();

		// 레코드 인출을 위한 쿼리문 작성
		String query = "SELECT COUNT(*) FROM qnaboard";
		if (map.get("searchWord2") != null) {
		    query += " WHERE " + map.get("searchField2") + " LIKE '%" + map.get("searchWord2") + "%'";
		}

		
		// 일렴번호의 내림차순으로 정렬한 후 인출한다.
		query += " ORDER BY idx DESC";
		// 게시판은 항상 최근에 작성한 게시물이 상단에 노출 되어야한다.

		try {
			// PreparedStatement 인스턴트 생성
			psmt = con.prepareStatement(query);
			// 쿼리문 실행 및 결과 반환 (ResultSet)
			rs = psmt.executeQuery();

			// ResultSet 크기만큼 즉 , 인출된 레코드의 갯수만큼 반복
			while (rs.next()) {
				// 하나의 레코드를 저장하기 위해 DTO 인스턴스 생성.
				QnaBoardDTO dto = new QnaBoardDTO();

				/*
				 * ResultSet 인스턴스에서 데이터를 추출할때 멤버변수의 타입에 따라 getSring(), getInt(), getDate() 로
				 * 구분하여 호출한다. 이 데이터를 DTO 의 setter를 이용해서 저장한다.
				 */
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setVisitcount(rs.getInt(8));

				// 레코드가 저장된 DTO를 List 에 갯수만큼 추가한다.
				qnaboard.add(dto);

			}
		} catch (Exception e) {
			System.out.println("게시물 조회중 예외1 발생");
			e.printStackTrace();
		}
		// 마지막으로 인출할 레코드를 저장한 List 를 반환한다.
		return qnaboard;

	}
	
	public QnaBoardDTO selectView(String idx) {
		QnaBoardDTO dto = new QnaBoardDTO();
		String query = "SELECT Bo.*, Us.name FROM qnaboard Bo "
					+ " INNER JOIN users Us ON Bo.id=Us.id"
					+ " WHERE idx =?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			//쿼리 실행시 주로 아래의 두가지 메서드를 사용한다.
			//executeQuery(): selec계열의 쿼리문을 실행한다.반환타입은 resultSet
			//executeUpdate(): insert update delete 계열의 쿼리문을 실행한다. 반환타입은 int
			// 만약 쿼리 실행 후 별도의 반환값이 필요하지 않다면 위 2개의 메서드중 어떤것을 사용해도 무방하다.
			rs = psmt.executeQuery();
			//int result = psmt.executeUpdate();
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setVisitcount(rs.getInt(8));
				dto.setName(rs.getString(9));
				
				
			}
			
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	public void updateVisitCount(String idx) {
		String query = "update qnaboard set "
					+ " visitcount=visitcount+1 "
					+ " where idx=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
	}
		catch (Exception e) {
		System.out.println("게시물 상1세보기 중 예외 발생");
		e.printStackTrace();
	}
}
	
	public int deletePost(String idx) {
		int result = 0;
		try {
			String query = "DELETE FROM qnaboard WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	public int updatePost(QnaBoardDTO dto) {
		int result = 0;
		try {
			
			String query = "UPDATE qnaboard" 
					+ " SET title=?, content=?, ofile=?, sfile=? "
					+ " WHERE idx=? and id=?";
			
				psmt=con.prepareStatement(query);
				psmt.setString(1, dto.getTitle());
				psmt.setString(2, dto.getContent());
				psmt.setString(3, dto.getOfile());
				psmt.setString(4, dto.getSfile());
				psmt.setString(5, dto.getIdx());
				psmt.setString(6, dto.getId());
				
				result = psmt.executeUpdate();
				
		}catch (Exception e) {
			System.out.println("게시물 수정중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
public List<QnaBoardDTO> selectListPage(
		Map<String, Object> map) {
	List<QnaBoardDTO> qnaboard = new Vector<QnaBoardDTO>();
	String query = 
			  " SELECT * FROM ( "
			+ " SELECT Tb.*, ROWNUM rNum FROM ( "
			+ " SELECT * FROM qnaboard ";
	if(map.get("searchWord2") != null) { 
		query += " WHERE " + map.get("searchField2")
			  +  " LIKE '%" + map.get("searchWord2") + "%'";
	}
	query += " 		ORDER BY idx DESC "
			+ " 	) Tb "
			+ " ) "
			+ "  WHERE rNum BETWEEN ? AND ? ";
	
	try {
		psmt = con.prepareStatement(query);
		psmt.setString(1, map.get("start").toString());
		psmt.setString(2, map.get("end").toString());
		rs = psmt.executeQuery();
		
		while ( rs.next()) {
			QnaBoardDTO dto = new QnaBoardDTO();
			
			dto.setIdx(rs.getString(1));
			dto.setId(rs.getString(2));
			dto.setTitle(rs.getString(3));
			dto.setContent(rs.getString(4));
			dto.setPostdate(rs.getDate(5));
			dto.setOfile(rs.getString(6));
			dto.setSfile(rs.getString(7));
			dto.setVisitcount(rs.getInt(8));
			
			qnaboard.add(dto);
			
		}
	}
	catch (Exception e) {
		System.out.println("게시물 조회중 예외 발생");
		e.printStackTrace();
	}
	return qnaboard;
	
}

}
	
