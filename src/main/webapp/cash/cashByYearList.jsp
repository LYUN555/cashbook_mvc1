<%@page import="dao.CashDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// only memeber
	// 세션 유효성 검사
	if (session.getAttribute("loginEmail") == null) {
		response.sendRedirect(request.getContextPath() + "/member/loginForm.jsp");
		return;
	}
	
	String email = (String) (session.getAttribute("loginEmail"));
	
	// 년월 수입 지출 목록
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	if (request.getParameter("year") != null) {
		year = Integer.parseInt(request.getParameter("year"));
	}	
	CashDAO cashDAO = new CashDAO();
	List<Map<String,Object>> list = cashDAO.selectCashYearList(email, year);
	
	// 페이징
	Map<String, Integer> maxMin = cashDAO.selectCashMinMaxYear();
	int max = maxMin.get("max");
	int min = maxMin.get("min");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%>님의<%=year%>년 수입/지출 리스트</h1>
	<div><a href="<%=request.getContextPath()%>/member/memberOne.jsp">이전으로</a></div>
	<table border ="1">
		<tr>
			<td>month</td>
			<td>kind</td>
			<td>sum</td>
		</tr>
		<%
			for(Map<String,Object> m : list) {
		%>
				<tr>
					<td><%=m.get("month") %></td>
					<td><%=m.get("kind") %></td>
					<td>
						<%
							if(m.get("kind").equals("수입")){
						%>
								+<%=m.get("sum")%>
						<%
							}else if(m.get("kind").equals("지출")){
						%>								
								-<%=m.get("sum")%>
						<%
							}
						%>		
					</td>
				</tr>
		<%
			}
		%>				
	</table>
	<!-- 페이징 -->
	<div>
	<%
		if(year > min){
	%>
			<a href="<%=request.getContextPath()%>/cash/cashByYearList.jsp?year=<%=min%>">처음년도</a>
			<a href="<%=request.getContextPath()%>/cash/cashByYearList.jsp?year=<%=year-1%>">이전</a>
	<%
		}
	%>
	<%
		if(year < max){
	%>		
			<a href="<%=request.getContextPath()%>/cash/cashByYearList.jsp?year=<%=year+1%>">이후</a>
			<a href="<%=request.getContextPath()%>/cash/cashByYearList.jsp?year=<%=max%>">마지막년도</a>
	
	<%
		}
	%>			
	</div>
</body>
</html>