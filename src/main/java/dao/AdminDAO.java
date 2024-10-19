package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBUtil;
import vo.Admin;
import vo.Member;

public class AdminDAO {
	// adminMemberPwUpdateAction.jsp
	public int memberPwUpdate(Member m) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("update member set pw=? where email=?");
		stmt.setString(1, m.getPw());
		stmt.setString(2, m.getEmail());
		System.out.println("AdminDAO.멤버 비밀번호 변경 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	
	// adminLoginAction.jsp
	public String Adminlogin(Admin admin) throws ClassNotFoundException, SQLException {
		String adminId= null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select admin_id,admin_pw from admin where admin_id=? and admin_pw=?");
		stmt.setString(1, admin.getAdminId());
		stmt.setString(2, admin.getAdminPw());
		System.out.println("AdminDAO.관리자 로그인 :"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			adminId=rs.getString("admin_id");
		}
		return adminId;
	}
}
