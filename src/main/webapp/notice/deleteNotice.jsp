<%@page import="vo.Notice"%>
<%@page import="dao.CommentDAO"%>
<%@page import="vo.Comment"%>
<%@page import="dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("loginAdmin:"+session.getAttribute("loginAdmin"));
	// 관리자 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminId = (String)(session.getAttribute("loginAdmin"));
	
	String strNoticeNo = request.getParameter("noticeNo");
	System.out.println("noticeNo:"+strNoticeNo);
	//유효성 검증
	if(strNoticeNo == null || strNoticeNo.equals("")){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	    return;
	}
	int noticeNo = Integer.parseInt(strNoticeNo);
	
	
	// 참조(자식) comment먼저 삭제후 삭제
	Comment c= new Comment();
	c.setNoticeNo(noticeNo);
	
	CommentDAO commentDAO = new CommentDAO();
	int count = commentDAO.totalCountComment(noticeNo);
	
	Notice n = new Notice();
	n.setNoticeNo(noticeNo);
	NoticeDAO noticeDAO = new NoticeDAO();
	if (count > 0) {
	    // 삭제할 댓글이 있다면 댓글 삭제 시도
	    int row = commentDAO.deleteCommentsByNotice(c);
	    if (row == 1) { 
	        // 댓글 삭제 성공 후 공지글 삭제
	        noticeDAO.deleteNotice(n);
	    } else {
	        System.out.println("댓글 삭제 실패");
	        response.sendRedirect(request.getContextPath() + "/notice/noticeOne.jsp?noticeNo="+noticeNo);
	    }
	} else {
	    // 댓글이 없다면 바로 공지글 삭제
	    noticeDAO.deleteNotice(n);
	}
	response.sendRedirect(request.getContextPath()+"/home.jsp");
%>