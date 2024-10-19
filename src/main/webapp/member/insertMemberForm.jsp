<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//offㄷ
	if(session.getAttribute("loginEmail")!=null){ // 로그인 값이 있을때
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
		return;
	}
	
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
	<h1>회원 가입</h1>
	<div><%=errMsg%></div>
	<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp">
		<table border = "1">
			<tr>
				<td>이메일</td>
				<td><input type="text" name ="email"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name ="repw"></td>
			</tr>
			<tr>
				<td>비밀번호확인</td>
				<td><input type="password" name ="pw"></td>
			</tr>
			<tr>
				<td>생일</td>
				<td><input type="date" name ="birth"></td>
			</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>