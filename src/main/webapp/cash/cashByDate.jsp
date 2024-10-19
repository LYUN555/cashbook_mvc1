<%@page import="vo.Cash"%>
<%@page import="java.util.List"%>
<%@page import="dao.CashDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// ON
	if(session.getAttribute("loginEmail") ==null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	// 입력값 유효성
	 if (y == null || m == null || d == null || y.equals("") || m.equals("") || d.equals("")) {
	        // 날짜가 null일 경우 noticeOne.jsp로 리다이렉트
	        response.sendRedirect(request.getContextPath() + "/notice/memberOne.jsp");
	        return;
	    }

	String cashDate = y+"-"+m+"-"+d;
	System.out.println(cashDate);
	
	Cash c = new Cash();
	c.setEmail(email);
	c.setCashDate(cashDate);
	
	CashDAO cashDAO = new CashDAO();
	List<Cash> list = cashDAO.selectCashListByDate(c);
	String errMsg = "";
	if (request.getParameter("errMsg") != null) {
	    errMsg = request.getParameter("errMsg");
	}
	System.out.println("errMsg"+errMsg);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%>님 <%=cashDate%> cash 목록</h1>
	<div>
	<a href="<%=request.getContextPath()%>/cash/cashByMonth.jsp">
		월별목록
	</a>
	<div>
	<a href="<%=request.getContextPath()%>/cash/insertCashForm.jsp?cashDate=<%=cashDate%>">
		cash 추가
	</a>
	</div>
	</div>
	<table border="1">
		<tr>
			<!-- 컬럼명 -->
			<th>생성날짜</th>
			<th>수입/지출</th>
			<th>money</th>
			<th>메모</th>
			<th>수정날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(Cash cash : list){
		%>
		<tr>
			<td><%=cash.getCreatedate()%></td>
			<td><%=cash.getKind()%></td>
			<td><%=cash.getMoney()%></td>
			<td>
				<a href="<%=request.getContextPath()%>/cash/memoOne.jsp?cashNo=<%=cash.getCashNo()%>"><%=cash.getMemo()%></a>
			</td>
			<td><%=cash.getUpdatedate()%></td>
			<td>
				<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cash.getCashNo()%>">수정</a>
			</td>
			<td>
				<a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cash.getCashNo()%>&cashDate=<%=cash.getCashDate()%>">삭제</a>
			</td>
		</tr>		
		<%
			}
		%>				
		
	</table>
</body>
</html>