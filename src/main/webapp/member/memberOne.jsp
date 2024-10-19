<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// on : session.loginEmail변수가 있다
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}

	String email = (String)(session.getAttribute("loginEmail"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%>님 반갑습니다</h1>
	<a href="<%=request.getContextPath()%>/home.jsp">공지사항</a><br>
	<a href="<%=request.getContextPath()%>/cash/cashByMonth.jsp">수입/지출 리스트</a><br>
	<a href="<%=request.getContextPath()%>/cash/cashByYearList.jsp">연간 수입/지출 리스트</a><br>
	<a href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a><br>
	<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호변경</a><br>
	<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a><br>
</body>
</html>