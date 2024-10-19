<%@page import="dao.MemberDAO"%>
<%@page import="vo.Member"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//off
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail")!=null){ // 로그인 값이 있을때
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
		return;
	}
	// 입력값 유효성 검사
	if(	request.getParameter("email")==null || request.getParameter("pw") == null || 
		request.getParameter("repw") == null || request.getParameter("birth") == null ||
		request.getParameter("email").equals("") || request.getParameter("pw").equals("") ||
		request.getParameter("birth").equals("")|| !request.getParameter("pw").equals(request.getParameter("repw"))){
		
		String errMsg = "입력값을 확인하세요";
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		//+URLEncoder.encode(errMsg, "utf-8") <- 한글이 깨지지 않게
		return;
	}
	
	Member member = new Member();
	member.setEmail(request.getParameter("email"));
	member.setPw(request.getParameter("pw"));
	member.setBirth(request.getParameter("birth"));

	// 이메일 유효성 검사 
	MemberDAO memberDAO = new MemberDAO();
	boolean isEmail = memberDAO.selectMemberEmail(member.getEmail()); // true : 이미 사용중
	if(isEmail){
		String errMsg = "사용중인 이메일입니다";
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		return;
	}
	
	// 성공 유무에 따른 분기코드 추가 가능
	int row = memberDAO.insertMember(member);
	System.out.println(row +"<--- insertMemberAction row");
	response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
%>