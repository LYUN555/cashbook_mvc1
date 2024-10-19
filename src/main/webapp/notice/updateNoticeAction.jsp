<%@page import="vo.Notice"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//관리자 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String adminId = (String)(session.getAttribute("loginAdmin"));
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	// 유효성 검증
	if(noticeTitle==null || noticeTitle.equals("") ||
			noticeContent==null || noticeContent.equals("")){
		
		String errMsg="내용을 입력하세요";
		response.sendRedirect(request.getContextPath()+"/notice/updateNoticeForm.jsp?noticeNo="+noticeNo+"&errMsg="+URLEncoder.encode(errMsg,"UTF-8"));
		return;
	}
	
	// 업데이트 파라미터값 저장
	Notice n = new Notice();
	n.setAdminId(adminId);
	n.setNoticeTitle(noticeTitle);
	n.setNoticeContent(noticeContent);
	n.setNoticeNo(noticeNo);
	
	NoticeDAO noticeDAO = new NoticeDAO();
	int row = noticeDAO.updateNotice(n);
	
	if(row == 1){
		System.out.println("updatenoticeAction 성공");
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo?="+noticeNo);
		return;		
	}
	
%>