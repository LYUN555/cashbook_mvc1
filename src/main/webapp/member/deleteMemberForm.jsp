<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//on
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	String errMsg ="";
	if(request.getParameter("errMsg")!=null){
		errMsg = request.getParameter("errMsg");
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%> 회원 탈퇴</h1>
	<div><%=errMsg%></div>
	<form method ="post" action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp">
		<table border="1">
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" value="<%=email%>" readonly></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>
		<button type ="submit">탈퇴</button>
	</form>
	
</body>
</html>