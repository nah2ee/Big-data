package com.koreait.board;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
// sql 연결 부분은 member.xml에서 이미 처리했으므로 여기선 필요X
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.koreait.db.Dbconn;
import com.koreait.db.SqlMapConfigBoard;

public class BoardDAO {
	SqlSessionFactory ssf = SqlMapConfigBoard.getSqlMapInstance();
	SqlSession sqlsession;
	
	public BoardDAO() {
		sqlsession = ssf.openSession(true); // openSession(true) 설정시 자동 commit 됨
		System.out.println("마이바티스 설정 성공!");
	}
	
	public int upload(BoardDTO board) {
		HashMap<String, String> dataMap = new HashMap<>();
		
		dataMap.put("b_userid", board.getUserid());
		dataMap.put("b_name", board.getName());
		dataMap.put("b_title", board.getTitle());
		dataMap.put("b_content", board.getContent());
		
		return sqlsession.insert("Board.upload", dataMap);
	}
	
	public int count() {
		return sqlsession.insert("Board.totalCount");
	}
	
	List<BoardDTO> selectBoardList(BoardDTO board) throws Exception;
}
