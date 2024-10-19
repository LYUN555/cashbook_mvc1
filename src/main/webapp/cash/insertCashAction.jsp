<%@page import="java.net.URLEncoder"%>
<%@page import="vo.Cash"%>
<%@page import="dao.CashDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ON
	if(session.getAttribute("loginEmail") ==null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	// request parameter
	
	
	String cashDate = request.getParameter("cashDate");
	String kind = request.getParameter("kind");
	String strMoney = request.getParameter("money");
	String memo = request.getParameter("memo");
	
	// cashDate 는"0000-0-0"
	String[] arr = cashDate.split("-");
	// 유효성 검사
	if(cashDate == null || cashDate.equals("")|| kind == null ||kind.equals("")||
		strMoney==null || strMoney.equals("")|| memo==null || memo.equals(""))	{
		
		String errMsg="잘못된 입력입니다.";
		response.sendRedirect(request.getContextPath()+"/cash/insertCashForm.jsp?cashDate="
								+cashDate+"&errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	int money= Integer.parseInt(strMoney);
	
	
	
	//cashDAO.insertCash()
	Cash c = new Cash();
	c.setEmail(email);
	c.setCashDate(cashDate);
	c.setKind(kind);
	c.setMoney(money);
	c.setMemo(memo);
	
	
	CashDAO cashDAO = new CashDAO();
	cashDAO.insertCash(c);
	
	// redirect =
	
	response.sendRedirect(request.getContextPath()+"/cash/cashByDate.jsp?y="+arr[0]+"&m="+arr[1]+"&d="+arr[2]);
%>