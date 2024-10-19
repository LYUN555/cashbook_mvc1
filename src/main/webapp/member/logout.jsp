<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// on
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}

	session.invalidate(); // 현재 세션사용자에게 새로운 세션공간을 부여
	response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
%>