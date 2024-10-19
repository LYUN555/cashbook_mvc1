<%@page import="vo.Page"%>
<%@page import="vo.Comment"%>
<%@page import="java.util.List"%>
<%@page import="dao.CommentDAO"%>
<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// admin ON
	// or
	// member ON
	String email = (String)(session.getAttribute("loginEmail"));
	String adminId = (String)(session.getAttribute("loginAdmin"));
	if(email == null && adminId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 게시판 번호 검증
	String strNoticeNo = request.getParameter("noticeNo");
	if(strNoticeNo == null || strNoticeNo.equals("")){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	    return;
	}
	
	int noticeNo = Integer.parseInt(strNoticeNo);
	
	// 댓글 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	Page p = new Page();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	NoticeDAO noticeDAO = new NoticeDAO();
	// 댓글 리스트 호출
	Notice n = noticeDAO.selectNoticeOne(noticeNo);
	
	CommentDAO commentDAO = new CommentDAO();
	List<Comment> commentList = commentDAO.selectCommentListByNotice(noticeNo,p);
	// VIEW
	// 1.noticeOne + 2.commentList+3.insertCommnetForm
	
	int totalRow = commentDAO.totalCountComment(noticeNo);
	int lastPage = totalRow/p.getRowPerPage();
	
	if(totalRow % p.getRowPerPage() !=0){
		lastPage++;
	}
	// 에러메세지 출력
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
	<h1>공지</h1>
	<div><a href="<%=request.getContextPath()%>/home.jsp">처음 화면으로</a></div>
	<table border = "1">
		<tr>
			<td>공지번호</td>
			<td><%=n.getNoticeNo()%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=n.getAdminId()%></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><%=n.getNoticeTitle()%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=n.getNoticeContent()%></td>
		</tr>
		<tr>
			<td>생성날짜</td>
			<td><%=n.getCreatedate()%></td>
		</tr>
		<tr>
			<td>수정날짜</td>
			<td><%=n.getUpdatedate()%></td>
		</tr>
	</table>
	<div>
		<!-- 공지글 수정 삭제 : 관리자에게만 노출 -->
		<%
			if(adminId != null){
		%>
				<a href="<%=request.getContextPath()%>/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a>
				<a href="<%=request.getContextPath()%>/notice/deleteNotice.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
		<%
			}
		%>				
	</div>
	
	<br>
	
	<div>
	<div><%=errMsg%></div>
		<!-- 이 공지글의 댓글 입력 폼 -->
		<form method="post" action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp">
			<input type ="hidden" name="noticeNo" value="<%=n.getNoticeNo()%>">
			<table border="1">
				<tr>
					 <td>
    				    <input type="text" name="commentWriter" value="<%= adminId != null ? adminId : email %>" readonly>
   					 </td>
				</tr>
				<tr>
					<td>댓글을 입력하세요</td>
					<td><textarea rows="3" cols="50" name="commentContent"></textarea> </td>
				</tr>
						
			</table>
			<button type="submit">댓글입력</button>
		</form>
	</div>
	<div>
		<!-- 이 공지글의 댓글 리스트 -->
		<h2>댓글</h2>
		<table border="1">
			<tr>	
				<td>작성자</td>
				<td>내용</td>
				<td>날짜</td>
				<td>삭제</td>
			</tr>
			<%
				for(Comment c : commentList){
			%>
				<tr>
					<td><%=c.getCommentWriter()%></td>
					<td><%=c.getCommentContent()%></td>
					<td><%=c.getCreatedate()%></td>
					<td>
						<!-- 삭제 링크는 글쓴이와 세션이 같을때 -->
						<%
							if(c.getCommentWriter().equals(email) || adminId !=null ){
						%>
								<a href="<%=request.getContextPath()%>/notice/deleteComment.jsp?noticeNo=<%=c.getNoticeNo()%>&commentNo=<%=c.getCommentNo()%>">삭제</a>
						<%
							} else {
						%>								
							삭제
						<%
							}
						%>								
					</td>
				</tr>
			<%
				}
			%>				
		</table>
		<!-- 댓글 페이징 -->
		<div>
		<%
			if(p.getCurrentPage()>1){
		%>
			<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=noticeNo%>&currentPage=1">처음</a>
			<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=noticeNo%>&currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		[<%=currentPage%>]
		<%
			if(p.getCurrentPage()<lastPage){
		%>			
			<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=noticeNo%>&currentPage=<%=currentPage+1%>">다음</a>
			<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=noticeNo%>&currentPage=<%=lastPage%>">끝</a>
		<%
			}
		%>				
	</div>
	</div>
</body>
</html>