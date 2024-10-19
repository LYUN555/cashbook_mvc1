<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// off (loginAdmin)
	if(session.getAttribute("loginAdmin") !=null){
		// 이미 관리자로 로그인 된 상태
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	String errMsg="";
	if(request.getParameter("errMsg")!=null){
		errMsg=request.getParameter("errMsg");
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminLoginForm</title>
</head>
<body>
	<h1>관리자 로그인</h1>
	<div>
		<a href = "<%=request.getContextPath()%>/home.jsp">공지사항</a>
	</div>
	<div><%=errMsg%></div>
	<form method ="post" action="<%=request.getContextPath()%>/admin/adminLoginAction.jsp">
		<table border = "1">
			<tr>
				<td>관리자 ID</td>
				<td><input type ="text" name="adminId"></td>
			</tr>
			<tr>
				<td>관리자 PW</td>
				<td><input type ="password" name="adminPw"></td>
			</tr>
		</table>
		<button type ="submit">로그인</button>
	</form>
</body>
</html>