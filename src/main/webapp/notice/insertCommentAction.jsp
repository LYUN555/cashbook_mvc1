<%@page import="dao.CommentDAO"%>
<%@page import="vo.Comment"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	// admin ON or member ON
	String email = (String)(session.getAttribute("loginEmail"));
	String adminId = (String)(session.getAttribute("loginAdmin"));
	if(email == null && adminId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 댓글창에서 값 받아오기
	String commentWriter = request.getParameter("commentWriter");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String commentContent = request.getParameter("commentContent");
	System.out.println("commentWriter :" + commentWriter);
	// 유효성 검증
	if(commentContent==null || commentContent.equals("")){
		String errMsg="댓글을 입력하세요";
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo+"&errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	
	Comment c = new Comment();
	c.setNoticeNo(noticeNo);
	c.setCommentContent(commentContent);
	c.setCommentWriter(commentWriter);
	
	CommentDAO commentDAO = new CommentDAO();
	int row = commentDAO.insertCommentNotice(c);
	
	//noticeOne.jsp redirect
	if(row ==1){
		System.out.println("댓글 생성 성공");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
	}
%>