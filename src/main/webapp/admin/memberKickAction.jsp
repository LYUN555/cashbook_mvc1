<%@page import="vo.Cash"%>
<%@page import="dao.CashDAO"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginAdmin")==null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	String errMsg ="";
	if(request.getParameter("pw")==null ||request.getParameter("pw").equals("")){
		errMsg = "잘못된 비밀번호";
		response.sendRedirect(request.getContextPath()+"/admin/memberKickForm.jsp?errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	String email = request.getParameter("email");
	System.out.println("email : "+email);
	String pw = request.getParameter("pw");
	System.out.println("pw : "+pw);
	
	Cash c = new Cash();
	c.setEmail(email);
	
	CashDAO cashDAO= new CashDAO();
	// 삭제할 cash행이 있다면
	// int count select count(*) from cash where email = ?
	int count = cashDAO.countCash(c);
	
	Member m = new Member();
	m.setEmail(email);
	m.setPw(pw);
	
	MemberDAO memberDAO = new MemberDAO();
	if(count > 1){
		
		int row = cashDAO.deleteCashByEmail(email);
		if(row==1){
			// cash테이블의 정보 삭제 성공했다면 회원 탈퇴
			System.out.println("삭제 성공");
			memberDAO.deleteMemberEmail(m);
		}
	}else{
		memberDAO.deleteMemberEmail(m);
	}
	
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>