package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


/*
 JNDI(java naming and directory interface)
 	디렉토리 서비스에서 제공하는 데이터 및 객체를 찾아서 참조 (lookup하는 
 	api 로 쉽게 말하면 외부에 있는 객체를 이름으로 찾아오기 위한 기술.
 	
 	DBCP(DataBase Connection Pool)
 		:DB와 연결된 커넥션 인스턴스를 미리 만들어 풀에 저장해 두었다가
 		필요할때 가져다 쓰고 반납하는 기술을 말한다. DB의 부하를 줄이고 자원을
 		효율적으로 관리할수 있다 ( 워터파크의 유수풀과 비슷하다.)
  */
public class DBCP {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;

public DBCP() {
	try {
		//1. conntext 인스턴스를 생성한다. 톰켓 웹 서버라 생각하면 됨.
		Context initCtx = new InitialContext();
		/*
		 2. 앞에서 생성한 인스턴스를 통해 JNDI서비스 구조의 초기 루트 디렉토리를 얻어온다.
		 해당 디렉토리의 이름은 아래와 같이 이미 지정되어있으므로 그대로 사용하면된다.
		  */
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		/*
		 3. server.xml에 등록한 네ㅇ밍을 lookup하여 datasource를 얻어온다.
		 즉 DB연결을 위한 정보를 가지고있다.
		 */
		DataSource source = (DataSource)ctx.lookup("dbcp_oracle");
		//4. 커넥션 풀에 생성해둔 객체를 가져다가 사용한다.
		con = source.getConnection();
		System.out.println("DB커넥션 풀 연결 성공");
		
	}
	catch (Exception e ) {
		System.out.println("DB커넥션 풀 연결 실패");
		e.printStackTrace();
	}
}
public void close() {
	try { 
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(psmt != null) psmt.close();
		if(con != null) con.close();
		
		System.out.println("JDBC 자원 해제");
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	}
}

