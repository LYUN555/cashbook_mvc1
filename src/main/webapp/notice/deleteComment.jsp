<%@page import="dao.CommentDAO"%>
<%@page import="vo.Comment"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 관리자 or 유저
	String email = (String)(session.getAttribute("loginEmail"));
	String adminId = (String)(session.getAttribute("loginAdmin"));
	if(email == null && adminId == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 유효성 검사
	String strNoticeNo = request.getParameter("noticeNo");
	String strCommentNo = request.getParameter("commentNo");
	if(strNoticeNo == null || strNoticeNo.equals("") ||
			strCommentNo == null || strCommentNo.equals("") ){
		
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	    return;
	}
	int noticeNo = Integer.parseInt(strNoticeNo);
	int commentNo = Integer.parseInt(strCommentNo);
	
	Comment c= new Comment();
	c.setNoticeNo(noticeNo);
	c.setCommentNo(commentNo);
	
	CommentDAO commentDAO = new CommentDAO();
	int row = commentDAO.deleteComment(c);
	
	if(row == 1){
		System.out.println("댓글 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
	}
	
%>    
