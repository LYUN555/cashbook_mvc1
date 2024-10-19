<%@page import="vo.Cash"%>
<%@page import="dao.CashDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 on
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");
	
	// 캐시넘버 입력
	Cash c = new Cash();
	c.setCashNo(cashNo);
	
	// 삭제
	CashDAO cashDAO = new CashDAO();
	cashDAO.deleteCash(c);
	
	String[] arr = cashDate.split("-");
	response.sendRedirect(request.getContextPath()+"/cash/cashByDate.jsp?y="+arr[0]+"&m="+arr[1]+"&d="+arr[2]);

	
	
%>