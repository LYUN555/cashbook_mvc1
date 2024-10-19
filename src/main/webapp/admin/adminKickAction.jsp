<%@page import="dao.CashDAO"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 관리자 on
	if(session.getAttribute("loginAdmin")==null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}

	String msg ="";
	
	if(request.getParameter("pw")==null ||request.getParameter("pw").equals("")){
		msg = "잘못된 비밀번호";
		response.sendRedirect(request.getContextPath()+"/admin/adminKickForm.jsp?errMsg="+URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	String email = request.getParameter("email");
	System.out.println("email : "+email);
	String pw = request.getParameter("pw");
	System.out.println("pw : "+pw);
	
	CashDAO cashDAO= new CashDAO();
	cashDAO.deleteCashByEmail(email);
	
	Member m = new Member();
	m.setEmail(email);
	m.setPw(pw);
	
	MemberDAO memberDAO = new MemberDAO();
	int row =memberDAO.deleteMemberEmail(m);
	if(row==1){
		msg="멤버계정 삭제 성공";
	}
	System.out.println("삭제 성공");
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="
							+URLEncoder.encode(msg, "UTF-8"));
	
%>