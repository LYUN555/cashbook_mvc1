<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 관리자 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminId = (String)(session.getAttribute("loginAdmin"));
	
	// 게시판 번호 검증
	String strNoticeNo = request.getParameter("noticeNo");
	if(strNoticeNo == null || strNoticeNo.equals("")){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	    return;
	}
	int noticeNo = Integer.parseInt(strNoticeNo);
	
	// 수정 하기 위해 공지번호 내용 호출
	NoticeDAO noticeDAO = new NoticeDAO();
	Notice n = noticeDAO.selectNoticeOne(noticeNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
	<form method="post" action="<%=request.getContextPath()%>/notice/updateNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>공지번호</td>
				<td><input type ="text" name = "noticeNo" value="<%=n.getNoticeNo()%>" readonly></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type ="text" name = "adminId" value="<%=n.getAdminId()%>" readonly></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type ="text" name = "noticeTitle" value="<%=n.getNoticeTitle()%>"></td>
			</tr>		
			<tr>
				<td>내용</td>
				<td><textarea rows="5" cols="50" name="noticeContent"><%=n.getNoticeContent()%></textarea></td>
			</tr>	
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>