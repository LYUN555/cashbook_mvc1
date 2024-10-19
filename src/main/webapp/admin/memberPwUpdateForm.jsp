<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 관리자 세션 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminEmail = (String)session.getAttribute("loginAdmin");
	String errMsg="";
	// 유효성 검사
	if(request.getParameter("eamil")==null ||request.getParameter("eamil").equals("")){
		errMsg="없는 이메일입니다";
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp+errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=adminEmail%>님의 멤버 비밀번호 변경</h1>
	<form method = "post" action="<%=request.getContextPath()%>"></form>
	<table>
	
	</table>

</body>
</html>