package com.koreait.db;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
	private static SqlSessionFactory sqlsession;
	
	// 메모리에 미리 올라가는, '한번만 실행되는' 초기화 블럭
	static {
		try {
			String resource = "com/koreait/db/config.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			sqlsession = new SqlSessionFactoryBuilder().build(reader);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlMapInstance() {
		return sqlsession;
	} // MemberDAO.java에서 return sqlsession 값을 가져갈 수 있도록 함
}
