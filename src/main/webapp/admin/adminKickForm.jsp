<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 유효성 검사
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	System.out.println(session.getAttribute("loginAdmin")+"<-- session");
	
	if(request.getParameter("email")==null || request.getParameter("email").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	
	String email= request.getParameter("email");
	System.out.println(email+"<-- email");
	
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
	<h1><%=email%> 회원 강퇴</h1>
	<div><%=errMsg%></div>
	<form method="post" action="<%=request.getContextPath()%>/admin/adminKickAction.jsp">
	<table border="1">
		<tr>
			<td>이메일</td>
			<td><input type="text" name ="email" value="<%=email%>" readonly></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name = "pw"></td>
		</tr>
	</table>
	<button type="submit">강퇴</button>
	</form>
</body>
</html>