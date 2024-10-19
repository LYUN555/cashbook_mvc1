<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//ON
	if(session.getAttribute("loginEmail") ==null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	
	// 입력값
	String cashDate = request.getParameter("cashDate");
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
	<h1>cash 입력</h1>
	<div><%=errMsg%></div>
	<div>
	<a href="<%=request.getContextPath()%>/cash/cashByMonth.jsp">
		월별목록
	</a>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/cash/insertCashAction.jsp">
		<table border="1">
			<tr>
				<td>cashDate</td>
				<td><input type="text" name="cashDate" value="<%=cashDate%>" readonly></td>
			</tr>
			<tr>
				<td>kind</td>
				<td>
					<input type = "radio" name="kind" value="수입">수입
					<input type = "radio" name="kind" value="지출">지출
				</td>
			</tr>
			<tr>
				<td>money</td>
				<td><input type="number" name="money"></td>
			</tr>
			<tr>
				<td>memo</td>
				<td><textarea cols="50" rows="3" name="memo"></textarea></td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>