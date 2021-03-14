<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 로그인 세션 체크
	if(session.getAttribute("userid") == null){
%>
	<script>
		alert('로그인 후 이용하세요');
		location.href='./login.jsp';
	</script>
<%
	}else{
		// info.jsp로 부터 데이터를 전달 받음
		request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean class="com.koreait.member.MemberDTO" id="member"/>
	<jsp:useBean class="com.koreait.member.MemberDAO" id="dao"/>
		<jsp:setProperty property="*" name="member"/>
<%
		member.setIdx(Integer.parseInt(String.valueOf(session.getAttribute("useridx"))));
		member.setUserid((String)session.getAttribute("userid"));
		// member.setUsername((String)session.getAttribute("username"));

		if (!dao.pwCheck(member)) {
%>
			<script>
				alert('비밀번호가 틀렸습니다.');
				history.back();
			</script>
<%
		} else {
			if (dao.edit(member) == 1) {
%>
				<script>
					alert('수정되었습니다.');
					location.href='./info.jsp';
				</script>
<%
			} else {
%>
				<script>
					alert('수정에 실패했습니다.');
					history.back();
				</script>
<%
			}
		}
	}
%>