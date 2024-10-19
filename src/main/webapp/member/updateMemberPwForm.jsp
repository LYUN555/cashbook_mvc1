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
	<h1><%=email%>비밀번호 변경</h1>
	<div><%=errMsg%></div>
	<form method = "post" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
		<table border="1">
			<tr>
				<td>현재 비밀번호</td>
				<td><input type ="password" name = "prepw"></td>
			</tr>
			<tr>
				<td>새로운 비밀번호</td>
				<td><input type ="password" name = "newpw"></td>
			</tr>
		</table>
		<button type = "submit">비밀번호 변경</button>
	</form>
</body>
</html>