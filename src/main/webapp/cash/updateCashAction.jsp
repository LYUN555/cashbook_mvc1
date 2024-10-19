<%@page import="vo.Cash"%>
<%@page import="dao.CashDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션 유효성 검사
	if(session.getAttribute("loginEmail")== null ) {
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	String cashDate = request.getParameter("cashDate"); 
	String strcashNo = request.getParameter("cashNo");
	String strmoney = request.getParameter("money");
	String kind = request.getParameter("kind");
	String memo = request.getParameter("memo");
	
	// 입력값 유효성 검사
	if(cashDate == null || cashDate.equals("")||
			strcashNo == null || strcashNo.equals("")||
			strmoney == null || strmoney.equals("")||
			kind == null || kind.equals("") || 
			memo == null || memo.equals("")) {
		
		String errMsg = "입력값을 확인하세요"; 		
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+strcashNo+"&cashDate="+cashDate + 
															"&errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		return;												
	}
	
	int money = Integer.parseInt(strmoney);
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	Cash c = new Cash();
	c.setCashNo(cashNo);
	c.setKind(kind);
	c.setMoney(money);
	c.setMemo(memo);
	
	CashDAO cashDao = new CashDAO();
	int row = cashDao.updateCash(c);
	
	System.out.println("cashDate : "+cashDate);
	// cashDate를 - 기준으로 잘라줌
	String[] arr = cashDate.split("-"); 
	response.sendRedirect(request.getContextPath()+"/cash/cashByDate.jsp?y="+arr[0]+"&m="+arr[1]+"&d="+arr[2]);
	
%>
