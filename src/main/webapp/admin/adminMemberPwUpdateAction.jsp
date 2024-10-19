<%@page import="dao.AdminDAO"%>
<%@page import="vo.Member"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 바로 변경되게 만듦
	//관리자 세션 on
	if(session.getAttribute("loginAdmin") == null){
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp");
		return;
	}
	
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	if(pw==null || pw.equals("")){
		String msg = "변경할 비밀번호를 입력하세요";		
		response.sendRedirect(request.getContextPath()+"/admin/adminMemberPwUpdateForm.jsp?email="+email+"&errMsg="
										+URLEncoder.encode(msg, "UTF-8"));
		return;
	}
	System.out.println("Action : email= "+email+" pw= "+pw);
	Member m = new Member();
	m.setEmail(email);
	m.setPw(pw);
	
	AdminDAO adminDAO = new AdminDAO();
	adminDAO.memberPwUpdate(m);
	
	
	String msg ="비밀번호 변경 성공";
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp?msg="+URLEncoder.encode(msg, "UTF-8"));
	
	
%>