<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<jsp:useBean id="board" class="com.koreait.board.BoardDTO" />
<jsp:useBean id="dao" class="com.koreait.board.BoardDAO" />

<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("userid") == null){

%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='../login.jsp';
	</script>
<%
	} else { 
		String userid = (String)session.getAttribute("userid"); // session 값을 String으로 형변환
		String username = (String)session.getAttribute("username");
		String title = request.getParameter("b_title");
		String content = request.getParameter("b_content");
      
		board.setUserid(userid);
		board.setName(username);
		board.setTitle(title);
		board.setContent(content);
      
		if(dao.upload(board) >= 1) {
%>
			<script>
				alert('등록되었습니다.');
				location.href='./list.jsp';
			</script>
<%
		} else {
%>
			<script>
				alert('등록실패');
				history.back();
			</script>
<%
		}
	}
%>