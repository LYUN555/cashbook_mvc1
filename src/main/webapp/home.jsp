<%@page import="vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="dao.NoticeDAO"%>
<%@page import="vo.Page"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// on or off
	String email = (String)(session.getAttribute("loginEmail"));
	String adminId = (String)(session.getAttribute("loginAdmin"));

	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	Page p = new Page();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	NoticeDAO noticeDAO = new NoticeDAO();
	List<Notice> noticeList = noticeDAO.selectNoticeListByPage(p);
	int totalRow = noticeDAO.totalCount();
	
	int lastPage = totalRow/p.getRowPerPage();
	
	if(totalRow % p.getRowPerPage() !=0){
		lastPage++;
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>HOME</h1>
	<%
		if(adminId != null){
	%>
			<div><%=adminId%>님 반갑습니다.</div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리</a>
			<a href="<%=request.getContextPath()%>/admin/adminLogout.jsp">로그아웃</a>
	<%
		}else if(email ==null){
	%>
			<a href ="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
			<a href ="<%=request.getContextPath()%>/member/loginForm.jsp">로그인</a>
	<%
		}else{
	%>			
			<a href="<%=request.getContextPath()%>/member/memberOne.jsp"><%=email%>님</a> 반갑습니다.<br>
			<a href="<%=request.getContextPath()%>/member/logout.jsp">로그아웃</a>
	<%
		}
	%>		
	
	<!-- notice list 출력 -->
	<h1>공지사항</h1>
	<table border ="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
		</tr>
		<%
			for(Notice n : noticeList){
		%>
				<tr>
					<td><%=n.getNoticeNo()%></td>
					<td>
						<%
							if(email == null && adminId == null){// 공지만 볼수 있게
						%>
								<%=n.getNoticeTitle()%>
						<%
							}else{ // 로그인된 상태에선 링크 클릭 가능하게
						%>
								<a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>">
									<%=n.getNoticeTitle()%>
								</a>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
		%>				
	</table>
	<div>
		<%
			if(p.getCurrentPage()>1){
		%>
			<a href="<%=request.getContextPath()%>/home.jsp?currentPage=1">처음</a>
			<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		[<%=currentPage%>]
		<%
			if(p.getCurrentPage()<lastPage){
		%>			
			<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<a href="<%=request.getContextPath()%>/home.jsp?currentPage=<%=lastPage%>">끝</a>
		<%
			}
		%>				
	</div>
	<div>
		<!-- 관리자로 로그인 되어 있다면 -->
		<%
			if(adminId != null){
		%>
				<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp">공지입력</a>
		<%
			}
		%>				
	</div>
</body>
</html>