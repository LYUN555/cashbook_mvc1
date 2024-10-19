<%@page import="vo.Cash"%>
<%@page import="java.util.List"%>
<%@page import="dao.CashDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//on
	if(session.getAttribute("loginEmail")==null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	
	// 출력 달력(년/월)
	Calendar target = Calendar.getInstance();
	target.set(Calendar.DATE, 1);
	

	if(request.getParameter("targetYear")!= null && request.getParameter("targetMonth")!=null){
		
		target.set(Calendar.YEAR, Integer.parseInt(request.getParameter("targetYear")));
		target.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	int targetYear = target.get(Calendar.YEAR);
	int targetMonth = target.get(Calendar.MONTH);
	
	// 0000년 00월 1일
	int yo = target.get(Calendar.DAY_OF_WEEK);
	int beginBlank = yo - 1; 
	int lastDay = target.getActualMaximum(Calendar.DATE);
	int afterBlank =0;
	int totalCell = beginBlank+lastDay+afterBlank;
	
	if(totalCell %7 != 0){
		afterBlank = 7-(totalCell% 7);
		totalCell += afterBlank;
	}
	
	// 모델값
	CashDAO cashDAO = new CashDAO();
	// cashDAO 에서 수입/지출 목록을 가져옴
	List<Cash> list = cashDAO.selectCashListByMonth(email, targetYear, targetMonth+1);
	
	// 이번달 총 수익/지출 구하기
	int totalIncome = 0;
	int totalExpense = 0;
	for(Cash c: list){
		if(c.getKind().equals("수입")){
			totalIncome += c.getMoney();
		}else if(c.getKind().equals("지출")){
			totalExpense += c.getMoney();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=email%>님 수입/지출 리스트</h1>
	<h2><%=targetYear%>년<%=targetMonth+1%>월</h2>
	<div><a href="<%=request.getContextPath()%>/member/memberOne.jsp">상세정보</a></div>
	<div>
		<a href="<%=request.getContextPath()%>/cash/cashByMonth.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth-1%>">이전달</a>
		<a href="<%=request.getContextPath()%>/cash/cashByMonth.jsp?targetYear=<%=targetYear%>&targetMonth=<%=targetMonth+1%>">다음달</a>
	</div>	
	
	<table border="1">
	
		<tr>
			<td>일</td><td>윌</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
		</tr>
		<tr>
		<%
			for(int i=1; i<=totalCell; i++){
		%>
			<td>
				<%
					if(i-beginBlank < 1 || i-beginBlank >lastDay){
				%>
						&nbsp;
				<%
					}else{
				%>						
						<a href="<%=request.getContextPath()%>/cash/cashByDate.jsp?y=<%=targetYear%>&m=<%=targetMonth+1%>&d=<%=i-beginBlank%>">
						<%=i-beginBlank%>
						</a>
				<%
					}
				%>
				<div>
					<!-- 날짜별 수입/지출 리스트 -->		
					<%
						for(Cash c : list){
							int d = Integer.parseInt(c.getCashDate().substring(8));
							if(d == (i-beginBlank)){
								if(c.getKind().equals("수입")){
					%>
									<div style = "color: #0000FF;">
										[<%=c.getKind()%>]<%=c.getMoney()%>
									</div>
					<%
								}else if(c.getKind().equals("지출")){
					%>
									<div style = "color: #FF0000;">
										[<%=c.getKind()%>]<%=c.getMoney()%>
									</div>
					<%				
								}
							}
						}
					%>								
				</div>
			</td>
				
		<%
			if(i%7==0){
		%>
					</tr><tr>
		<%
				}
			}
		%>				
		</tr>
	</table>
	
	<br>
	
	<h2><%=targetMonth+1%>월 수입/지출</h2>
	<table border ="1">
		<tr>
			<td>총 수입</td>
			<td><%= totalIncome %> 원</td>
		</tr>
		<tr>
			<td>총 지출</td>
			<td><%= totalExpense %> 원</td>
		</tr>
		<tr>
			<td>순수익</td>
			<td><%= totalIncome - totalExpense %> 원</td>
		</tr>
	</table>
</body>
</html>