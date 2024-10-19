<%@page import="dao.*"%>
<%@page import="vo.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//세션 유효성 검사
	// on : session.loginEmail 변수가 있음
	if(session.getAttribute("loginEmail") == null){ //세션에서 loginEmail의 데이터를 조회
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	// request param
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));	
	System.out.println("cashForm.cashNo : "+cashNo);	
	
	CashDAO cashDao = new CashDAO();
	Cash c = cashDao.selectCashOne(cashNo);
	
	// 에러메시지 표시
	String errMsg="";
	if(request.getParameter("errMsg") != null){
		errMsg = request.getParameter("errMsg"); 
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><%=errMsg%></div>
	<h1>cash 수정</h1>
	<form method ="post" action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
		<table border="1">
			<tr>
				<td>cashDate</td>
				<td><input type="text" name="cashDate" value="<%=c.getCashDate()%>"readonly></td>
			</tr>
			<tr>
				<td>cashNo</td>
				<td><input type="text" name="cashNo" value="<%=c.getCashNo()%>" readonly></td>
			</tr>			
			<tr>
				<td>kind</td>
				<td>
					<input type="radio" name="kind" value="수입"> 수입
					<input type="radio" name="kind" value="지출" > 지출
				</td>
			</tr>
			<tr>
				<td>money</td>
				<td><input type="number" name="money" value="<%=c.getMoney()%>"></td>
			</tr>
			<tr>
				<td>memo</td>
				<td>
					<textarea cols="50" rows="3" name="memo"><%=c.getMemo()%></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
