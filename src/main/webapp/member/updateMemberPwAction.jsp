<%@page import="vo.Member"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// on
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	
	// 입력값 유효성 검사
	if(request.getParameter("newpw")==null || request.getParameter("prepw")==null ||
		request.getParameter("newpw").equals("")|| request.getParameter("prepw").equals("")){
		
		String errMsg = "비밀번호를 입력하세요";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		//+URLEncoder.encode(errMsg, "utf-8") <- 한글이 깨지지 않게
		return;
	}
	
	String prePw = request.getParameter("prepw");
	String newPw = request.getParameter("newpw");
	
	MemberDAO memberDAO = new MemberDAO();
	int row = memberDAO.updateMemberPw(email, prePw, newPw);
	if(row == 1){
		session.invalidate(); // 세션영역
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
	}else{
		String errMsg = "비밀번호를 수정 실패했습니다.";
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp?errMsg="+URLEncoder.encode(errMsg, "utf-8"));
		//+URLEncoder.encode(errMsg, "utf-8") <- 한글이 깨지지 않게
		return;
	}
%>