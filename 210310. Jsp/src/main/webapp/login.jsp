<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String userid = null;
if (session.getAttribute("userid") != null) {
	userid = (String) session.getAttribute("userid");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<h2>Login</h2>
	<%
	if (userid == null) {
	%>
	<form method="post" action="login_ok.jsp">
		<p><label>아이디 : <input type="text" name="userid"></label></p>
		<p><label>비밀번호 : <input type="password" name="userpw"></label></p>
		<p><input type="submit" value="로그인"> <input type="button" value="회원가입" onclick="location.href='./regist.jsp'"></p>
	</form>
	<%
	} else {
	%>
	<h4><%=userid%>(<%=session.getAttribute("username") %>)님 환영합니다.</h4>
	<p><input type="button" value="로그아웃" onclick="location.href='logout.jsp'">
	<input type="button" value="정보수정" onclick="location.href='info.jsp'">
	<input type="button" value="게시판" onclick="location.href='./board/list.jsp'"></p>
	<%
	}
	%>
</body>
</html>