package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.Member;
import vo.Page;

public class MemberDAO {
	
	//(/admin/memberList.jsp)
	public int memberCount() throws ClassNotFoundException, SQLException {
		int count= 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select count(*) from member");
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("count(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
	
	// (/admin/memberList.jsp)
	public List<Member> selectMemberList(Page page) throws ClassNotFoundException, SQLException{
		List<Member> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select email,pw,birth,updatedate,createdate from member limit ?,?");
		stmt.setInt(1, page.getBeginRow());
		stmt.setInt(2, page.getRowPerPage());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member member = new Member();
			member.setEmail(rs.getString("email"));
			member.setPw(rs.getString("pw"));
			member.setBirth(rs.getString("birth"));
			member.setUpdatedate(rs.getString("updatedate"));
			member.setCreatedate(rs.getString("createdate"));
			list.add(member);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// (/member/deleteMemberAction.jsp)
		public int deleteMemberEmail(Member m) throws ClassNotFoundException, SQLException {
			int row = 0;
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("delete from member where email=? and pw =?");
			stmt.setString(1,m.getEmail());
			stmt.setString(2,m.getPw());
			System.out.println(stmt+"<-- MemberDAO.deleteMemberEmail");
			row = stmt.executeUpdate();
			
			stmt.close();
			conn.close();
			return row;
		}
	
	// (/member/updateMemberPwAction.jsp)
	// 비밀번호 변경
	public int updateMemberPw(String email, String prePw,String newPw) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("update member set pw =? where email=? and pw =?");
		stmt.setString(1, newPw);
		stmt.setString(2, email);
		stmt.setString(3, prePw);
		System.out.println(stmt+"<-- MemberDAO.updateMemberPw");
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	// (/member/insertMember.jsp)
	// 이메일 중복 검사(존재하면 true, 없으면 false)
	public boolean selectMemberEmail(String email) throws ClassNotFoundException, SQLException {
		boolean result = false;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select email from member where email=?");
		stmt.setString(1, email);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			// 사용 불가 아이디(이미 사용중)
			result = true;
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return result;
	}
	
	// (/member/insertMember.jsp)
	public int insertMember(Member member) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("insert into member(email, pw,birth,updatedate,createdate) values(?,?,?,now(),now())");
		stmt.setString(1, member.getEmail());
		stmt.setString(2, member.getPw());
		stmt.setString(3, member.getBirth());
		System.out.println(stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	// (/member/loginAction.jsp) 호출
	public String login(Member member) throws ClassNotFoundException, SQLException {
		String email = null;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select email from member where email=? and pw =?");
		stmt.setString(1, member.getEmail());
		stmt.setString(2, member.getPw());
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) {
			// 로그인 성공
			email = rs.getString("email");
		}
		rs.close();
		stmt.close();
		conn.close();
		return email;
	}
}
