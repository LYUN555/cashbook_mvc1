package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.Notice;
import vo.Page;

public class NoticeDAO {
	// /notice/deleteNotice.jsp
	public int deleteNotice(Notice n) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("delete from notice where notice_no = ?");
		stmt.setInt(1, n.getNoticeNo());
		System.out.println("NoticeDAO.공지 삭제 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	// /notice/updateNoticeAction.jsp
	public int updateNotice(Notice n) throws ClassNotFoundException, SQLException {
		int row=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("update notice set admin_id= ?, notice_title = ?, notice_content = ?, updatedate = now() where notice_no = ? ");
		stmt.setString(1, n.getAdminId());
		stmt.setString(2, n.getNoticeTitle());
		stmt.setString(3, n.getNoticeContent());
		stmt.setInt(4, n.getNoticeNo());
		System.out.println("NoticeDAO.공지 수정 업데이트 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	// /notice/noticeOne.jsp
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		Notice n = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title, notice_content, admin_id, updatedate, createdate from notice where notice_no = ?");
		stmt.setInt(1, noticeNo);
		System.out.println("NoticeDAO.공지사항 상세정보 :"+stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			n = new Notice();
			n.setNoticeNo(rs.getInt("notice_no"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setAdminId(rs.getString("admin_id"));
			n.setUpdatedate(rs.getString("updatedate"));
			n.setCreatedate(rs.getString("createdate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return n;
	}
	
	// /notice/insertNoticeAction.jsp
	public int insertNotice(Notice n) throws ClassNotFoundException, SQLException {
		int row =0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("insert into notice(notice_title, notice_content, admin_id, createdate, updatedate) values (?,?,?,now(),now())");
		stmt.setString(1, n.getNoticeTitle());
		stmt.setString(2, n.getNoticeContent());
		stmt.setString(3, n.getAdminId());
		System.out.println("NoticeDAO.공지입력 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	// home.jsp
	public List<Notice> selectNoticeListByPage(Page p) throws ClassNotFoundException, SQLException{
		List<Notice> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select notice_no, notice_title from notice order by notice_no desc limit ?, ?");
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		System.out.println("NoticeDAO.페이지 :"+ stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("notice_no"));
			n.setNoticeTitle(rs.getString("notice_title"));
			list.add(n);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// home.jsp 호출
	public int totalCount() throws ClassNotFoundException, SQLException {
		int total = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select count(*) from notice");
		System.out.println("NoticeDAO.카운트 수 :"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("count(*)");
		}
		return total;
	}
}
