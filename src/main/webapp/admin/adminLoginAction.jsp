<%@page import="java.net.URLEncoder"%>
<%@page import="dao.AdminDAO"%>
<%@page import="vo.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 세션 유효성
	if(session.getAttribute("loginAdmin") !=null){
		// 이미 관리자로 로그인 된 상태
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	System.out.println(session.getAttribute("loginAdmin"));

	// 입력값 유효성
	String errMsg="";
	if(request.getParameter("adminId")==null || request.getParameter("adminPw")==null||
		request.getParameter("adminId").equals("")||request.getParameter("adminPw").equals("")){
		
		errMsg = "입력을 확인하세요";
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	
	Admin admin = new Admin();
	admin.setAdminId(adminId);
	admin.setAdminPw(adminPw);
	
	AdminDAO adminDAO = new AdminDAO();
	String loginAdmin = adminDAO.Adminlogin(admin);
	if(loginAdmin == null){
		errMsg = "로그인 실패";
		response.sendRedirect(request.getContextPath()+"/admin/adminLoginForm.jsp?errMsg="+URLEncoder.encode(errMsg, "UTF-8"));
		return;
	}
	
	// 로그인 성공
	session.setAttribute("loginAdmin", loginAdmin);
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>