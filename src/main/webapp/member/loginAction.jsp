<%@page import="vo.Member"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String errMsg ="";
	// off
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail")!=null){ // 로그인 값이 있을때
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
		return;
	}

	if(	request.getParameter("email")==null || request.getParameter("pw") == null ||
		request.getParameter("email").equals("") ||	request.getParameter("pw").equals("")){
		
		errMsg = "아이디, 비밀번호를 입력하세요";
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		//+URLEncoder.encode(errMsg, "utf-8") <- 한글이 깨지지 않게
		return;
	}
	Member member = new Member();
	member.setEmail(request.getParameter("email"));
	member.setPw(request.getParameter("pw"));
	
	MemberDAO memberDAO = new MemberDAO();
	String email = memberDAO.login(member);
	
	// 로그인 실패
	if(email == null){
		errMsg = "로그인 실패";
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		return;
	}
	// 로그인 성공
	session.setAttribute("loginEmail", email); // 세션에 이메일 저장
	response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
%>