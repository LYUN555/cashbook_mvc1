<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	// off : session.loginEmail 변수가 없을때
	
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail")!=null){ // 로그인 값이 있을때
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
		return;
	}

	String errMsg = "";
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
	<h1>로그인</h1>
	<div><%=errMsg%></div>
		<form method = "post" action="<%=request.getContextPath()%>/member/loginAction.jsp">
			<table border="1">
				<tr>
					<td>이메일</td>
					<td><input type = "text" name="email"></td>
				</tr>		
				<tr>
					<td>비밀번호</td>
					<td><input type = "password" name="pw"></td>
				</tr>		
			</table>
			<button type = "submit">로그인</button>
			<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">
				회원가입
			</a>
		</form>
</body>
</html>