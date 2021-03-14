<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.board.BoardDTO"%>

<jsp:useBean id="dao" class="com.koreait.board.BoardDAO"/>
<jsp:useBean id="board" class="com.koreait.board.BoardDTO"/>
<c:set var="boardList" value="${boardDAO.selectBoard()}"/>
<%
	if (session.getAttribute("userid") == null) {
%>
		<script>
			alert('로그인 후 이용하세요');
			location.href='../login.jsp';
		</script>
<%
	} else {
		Date from = new Date();
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd"); // mm은 밀리세컨드와 혼동할 수 있으므로 대문자로 쓴다
		String to = fm.format(from); // 2021-03-14
		System.out.println(to);
		
		int totalCount = 0; // 전체 글 개수
		int pagePerCount = 10; // 페이지당 글 개수
		int start = 0; // 시작 글 번호
		List<BoardDTO> list = new ArrayList<>();
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum != null && !pageNum.equals("")){
			start = (Integer.parseInt(pageNum)-1) * pagePerCount;
			
		} else {
			pageNum = "1";
			start = 0;
		}
		
		totalCount = dao.count();
		list = dao.selectlist(pageNum, start);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<h2>리스트</h2>
	<p>게시글 : <%=totalCount%>개</p>
	<table border="1" width="800">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>좋아요</th>
			<th>날짜</th>
		</tr>
<%

			
			if(to.equals(b_regdate)) {
				newDateStr = "<img src='./images/new3.png' alt='새글'>";
			}
			
			if(rs_reply.next()) {
				int cnt = rs_reply.getInt("cnt");
				if(cnt > 0) { // 댓글이 1개이상 달렸을 때만 표기할 것
					replycntStr = "[" + rs_reply.getString("cnt") + "]";
				}
			}
			
			if(b_file != null && !b_file.equals("")) {
				fileStr = "<img src='./images/file.png' alt='파일'>";
			}
%>
		<!-- 게시판 내용 반복 -->
		<tr>
			<td><%=b_idx%></td>
			<td><a href="./view.jsp?b_idx=<%=b_idx%>"><%=b_title%></a> <%=replycntStr%> <%=fileStr%> <%=newDateStr%></td>
			<td><%=b_name%>(<%=b_userid%>)</td>
			<td><%=b_hit%></td>
			<td><%=b_up%></td>
			<td><%=b_regdate%></td>
		</tr>
<%
		}

		int pageNums = 0;
		if(totalCount % pagePerCount == 0) {
			pageNums = (totalCount / pagePerCount);
		} else {
			pageNums = (totalCount / pagePerCount) + 1;
		}
%>
		<tr>
			<td colspan="6">
<%
				for(int i=1; i<=pageNums; i++) {
					out.print("<a href='list.jsp?pageNum=" + i + "'>[" + i + "]</a>" + "&nbsp;&nbsp;");
				}
%>
			</td>
		</tr>
		<tr>
			<td colspan="6"><input type="button" value="글작성" onclick="location.href='./write.jsp'"> 
			<input type="button" value="돌아가기" onclick="location.href='../login.jsp'"></td>
		</tr>
	</table>
</body>
</html>