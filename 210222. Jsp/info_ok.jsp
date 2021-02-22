<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	if(session.getAttribute("userid") == null) {
%>
	<!-- 로그인이 되어있지 않으면 로그인을 실행하라며 해당 페이지로 돌아감 -->
	<script>
		alert('로그인 후 이용하세요');
		location.href = './login.jsp';
	</script>
<%
	} else {
		// 로그인 세션 체크 (info.jsp처럼 로그인 안한 사용자가 들어오면 안됨)
		// info.jsp로부터 데이터를 전달 받음
		// DB연결
		// 비밀번호가 맞는지 여부 체크 (select를 해봐야 함)
		// update문 실행
		// info.jsp로 이동하여 제대로 바뀌었는지 아닌지 확인
		// 과제는 23일 밤 11시 59분까지 깃허브에 올리기...
		
		String userpw = request.getParameter("userpw");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "";
		String url = "jdbc:mysql://localhost:3306/jspstudy";
		String uid = "root";
		String upw = "1234";
		
		String userid = (String)session.getAttribute("userid");
		String username = (String)session.getAttribute("username");
		String mem_hp = (String)session.getAttribute("mem_hp");
		String mem_email = (String)session.getAttribute("mem_email");
		String mem_hobby = (String)session.getAttribute("mem_hobby");
		String hobbystr = "";
		String mem_ssn1 = (String)session.getAttribute("mem_ssn1");
		String mem_ssn2 = (String)session.getAttribute("mem_ssn2");
		String mem_zipcode = (String)session.getAttribute("mem_zipcode");
		String mem_address1 = (String)session.getAttribute("mem_address1");
		String mem_address2 = (String)session.getAttribute("mem_address2");
		String mem_address3 = (String)session.getAttribute("mem_address3");
			
		try {
			Class.forName("com.mysql.jdbc.Driver"); // com.mysql.cj.jdbc.Driver
			conn = DriverManager.getConnection(url, uid, upw);
			if(conn != null) {
				// sql = "UPDATE tb_member SET mem_userid=?, mem_name=?, mem_hp=?, mem_email=?, mem_hobby=?, mem_ssn1=?, mem_ssn2=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_address3=? WHERE mem_userid=?";
				sql = "UPDATE tb_member SET mem_userid=?, mem_name=?, mem_hp=?, mem_email=?, mem_ssn1=?, mem_ssn2=?, mem_zipcode=?, mem_address1=?, mem_address2=?, mem_address3=? WHERE mem_userid=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, username);
				pstmt.setString(3, mem_hp);
				pstmt.setString(4, mem_email);
				// pstmt.setString(5, hobbystr);
				pstmt.setString(6, mem_ssn1);
				pstmt.setString(7, mem_ssn2);
				pstmt.setString(8, mem_zipcode);
				pstmt.setString(9, mem_address1);
				pstmt.setString(10, mem_address2);
				pstmt.setString(11, mem_address3);
				
				pstmt.executeUpdate();	
				
				// if(rs.next() && session.getAttribute("userpw") == userpw) {
				if(session.getAttribute("userpw") == userpw) {
					// session.setAttribute("userid", userid);
					// session.setAttribute("username", username);
					// session.setAttribute("mem_hp", mem_hp);
					// session.setAttribute("mem_email", mem_email);
					// session.setAttribute("hobbystr", hobbystr);
					// session.setAttribute("mem_ssn1", mem_ssn1);
					// session.setAttribute("mem_ssn2", mem_ssn2);
					// session.setAttribute("mem_zipcode", mem_zipcode);
					// session.setAttribute("mem_address1", mem_address1);
					// session.setAttribute("mem_address2", mem_address2);
					// session.setAttribute("mem_address3", mem_address3);
	%>
					<script>
						alert('정보가 수정되었습니다.');
						location.href = 'info.jsp';
					</script>
	<%
				} else {
	%>
					<script>
						alert('비밀번호를 확인하세요.');
						history.back();
					</script>
	<%
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>