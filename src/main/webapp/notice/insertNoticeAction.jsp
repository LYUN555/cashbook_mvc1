<%@page import="java.net.URLEncoder"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="vo.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// admin On 세션
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminId =(String)session.getAttribute("loginAdmin");
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");	
	// 유효성 검사
	if(noticeTitle==null||noticeTitle.equals("")||
			noticeContent==null||noticeContent.equals("")){
		String errMsg="입력을 확인하세요";
		response.sendRedirect(request.getContextPath()+"/notice/insertNoticeForm.jsp?errMsg="
							+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	
	// NoticeDAO.insertNotice(Notice)
	Notice n = new Notice();
	n.setAdminId(adminId);
	n.setNoticeTitle(noticeTitle);
	n.setNoticeContent(noticeContent);
	
	NoticeDAO noticeDAO = new NoticeDAO();
	noticeDAO.insertNotice(n);
	
	
	response.sendRedirect(request.getContextPath()+"/home.jsp");
%>