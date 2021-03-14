package com.koreait.db;

/* ctrl+shift+o 를 눌러 자동으로 import 하도록 한다. */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Dbconn {
	public static Connection getConnection() {
		Connection conn = null;

		try {
			String url = "jdbc:mysql://localhost:3306/jspstudy";
			String uid = "root";
			String upw = "1234";

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, uid, upw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn, PreparedStatement pstmt) {
		try {
			if (pstmt != null) { pstmt.close(); }
			if (conn != null) { conn.close(); }
		} catch (Exception e) { e.printStackTrace(); }
	}
	
	public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) { rs.close(); }
			close(conn, pstmt);
		} catch (Exception e) { e.printStackTrace(); }
	}
}
