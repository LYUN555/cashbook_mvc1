<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 유효성
	
	session.invalidate();
	
	// 관리자 로그인폼으로
	
	response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
%>