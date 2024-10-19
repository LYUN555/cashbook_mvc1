<%@page import="vo.Member"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 유효성
	// 관리자 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}

	MemberDAO memberDAO = new MemberDAO();
	Page page1 = new Page();
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage =Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	page1.setCurrentPage(currentPage);
	page1.setRowPerPage(rowPerPage);
	
	// 멤버리스트 가져오기
	List<Member> list = memberDAO.selectMemberList(page1);
	
	// 페이지 갯수 구하기
	int totalRow = memberDAO.memberCount();
	int lastPage = totalRow/rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage++;
	}
	String msg ="";
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>멤버 목록</h1>
	<div>
		관리자 : <%=(String)(session.getAttribute("loginAdmin")) %>님
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/adminLogout.jsp">관리자 로그아웃</a>
	</div>
	<div><%=msg%></div>
	<!-- 멤버 리스트 출력 -->
	<table border="1">
		<tr>
			<th>이메일</th>
			<th>birth</th>
			<th>수정날짜</th>
			<th>만든날짜</th>
			<th>비밀번호 변경</th>
			<th>강퇴</th>
		</tr>
		<%
			for(Member member : list){
		%>
				<tr>
					<td><%=member.getEmail()%></td>
					<td><%=member.getBirth()%></td>
					<td><%=member.getUpdatedate()%></td>
					<td><%=member.getCreatedate()%></td>
					<td>
					<a href="<%=request.getContextPath()%>/admin/adminMemberPwUpdateForm.jsp?email=<%=member.getEmail()%>">비밀번호 변경</a>
					</td>
					<td>
					<a href="<%=request.getContextPath()%>/admin/adminKickForm.jsp?email=<%=member.getEmail()%>">강퇴</a>
					</td>
				</tr>
		<%
			}
		%>		
	</table>
	<div>
	<%
		if(currentPage>1){
	%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
	<%
		}
	%>
	[<%=currentPage%>]
	<%
		if(currentPage<lastPage){
	%>			
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">끝</a>
	<%
		}
	%>			
	</div>
	<a href="<%=request.getContextPath()%>/home.jsp">공지사항</a><br>
</body>
</html>