package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.Comment;
import vo.Page;

public class CommentDAO {
	// deleteNotice.jsp 댓글 전체 삭제
	public int deleteCommentsByNotice(Comment c) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("delete from comment where notice_no = ?");
		stmt.setInt(1, c.getNoticeNo());
		System.out.println("CommentDAO.댓글 전부삭제 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	// deleteComment.jsp 댓글 한개만 삭제
	public int deleteComment(Comment c) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("delete from comment where notice_no = ? and comment_no = ?");
		stmt.setInt(1, c.getNoticeNo());
		stmt.setInt(2, c.getCommentNo());
		System.out.println("CommentDAO.댓글삭제 :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	
	//  noticeOne.jsp 댓글 수
	public int totalCountComment(int noticeNo) throws ClassNotFoundException, SQLException {
		int total = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select count(*) from comment where notice_no = ?");
		stmt.setInt(1, noticeNo);
		System.out.println("CommentDAO.카운트 수 :"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("count(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return total;
	}
	
	// noticeOne.jsp
	public List<Comment> selectCommentListByNotice(int noticeNo, Page p) throws ClassNotFoundException, SQLException{
		List<Comment> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select comment_no, notice_no, comment_content, comment_writer,updatedate,createdate from comment where notice_no = ? order by notice_no desc limit ?,?");
		stmt.setInt(1, noticeNo);
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());
		System.out.println("CommentDAO.댓글보기 :"+stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("comment_no"));
			c.setNoticeNo(rs.getInt("notice_no"));
			c.setCommentContent(rs.getString("comment_content"));
			c.setCommentWriter(rs.getString("comment_writer"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		return list;
	}
	
	// insertCommentAction.jsp
	public int insertCommentNotice(Comment c) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("insert into comment(notice_no, comment_content, comment_writer,updatedate,createdate) values(?, ?, ?, now(), now())");
		stmt.setInt(1, c.getNoticeNo());
		stmt.setString(2, c.getCommentContent());
		stmt.setString(3, c.getCommentWriter());
		System.out.println("CommentDAO.댓글 생성 :"+ stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
}
