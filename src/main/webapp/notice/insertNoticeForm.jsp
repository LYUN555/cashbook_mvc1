<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// admin ON
	// 관리자 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminId = (String)(session.getAttribute("loginAdmin"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertNoticeForm</title>
</head>
<body>
	<h1>공지 입력</h1>
	<form method="post" action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>작성자</td>
				<td><input type ="text" name = "text" value="<%=adminId%>" readonly></td>
			</tr>		
			<tr>
				<td>제목</td>
				<td><input type ="text" name = "noticeTitle"></td>
			</tr>		
			<tr>
				<td>내용</td>
				<td><textarea rows="5" cols="50" name="noticeContent"></textarea></td>
			</tr>		
		</table>
		<button type ="submit">작성</button>
	</form>
</body>
</html>