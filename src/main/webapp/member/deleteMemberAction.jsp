<%@page import="vo.Cash"%>
<%@page import="vo.Member"%>
<%@page import="dao.CashDAO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// on
	// 세션 유효성 검사
	if(session.getAttribute("loginEmail") == null){
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	String email = (String)(session.getAttribute("loginEmail"));
	
	// 입력값 유효성 검사
	if(request.getParameter("pw")==null || request.getParameter("pw").equals("")){
		String errMsg = "비밀번호를 입력하세요";
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		//+URLEncoder.encode(errMsg, "utf-8") <- 한글이 깨지지 않게
		return;
	}
	String pw = request.getParameter("pw");
	
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
	if(count > 0){
		// 삭제할 cash행이 있다
		int row = cashDAO.deleteCashByEmail(email);
		if(row==1){
			// cash테이블의 정보 삭제 성공했다면 회원 탈퇴
			memberDAO.deleteMemberEmail(m);
		}else{
			// 
			System.out.println("캐시 삭제 실패");
			response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp");
		}
	} else{
		memberDAO.deleteMemberEmail(m);
	}
	session.invalidate(); // 세션영역
	
	response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
%>