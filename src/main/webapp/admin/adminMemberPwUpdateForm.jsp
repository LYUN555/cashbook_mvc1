<%@page import="dao.MemberDAO"%>
<%@page import="vo.Member"%>
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
	System.out.println("비번변경폼 세션:"+adminEmail);
	String errMsg="";
	// 유효성 검사
	if(request.getParameter("email")==null ||request.getParameter("email").equals("")){
		errMsg="없는 이메일입니다";
		System.out.println("비번변경폼 이메일:"+request.getParameter("email"));
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp+errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	String email = request.getParameter("email");
		
	MemberDAO memberDAO = new MemberDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%>님의 비밀번호 변경</h1>
	<form method = "post" action="<%=request.getContextPath()%>/admin/adminMemberPwUpdateAction.jsp">
	<table border="1">
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email" value="<%=email%>" readonly></td>
		</tr>	
		<tr>
			<td>비밀번호 변경</td>
			<td><input type="text" name="pw"></td>
		</tr>
	</table>
	<button type="submit">변경</button>
	</form>
</body>
</html>