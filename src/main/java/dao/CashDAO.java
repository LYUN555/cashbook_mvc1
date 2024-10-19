package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.DBUtil;
import vo.Cash;

public class CashDAO {
	
	// cashList.jsp
	public Map<String, Integer> selectCashMinMaxYear() throws ClassNotFoundException, SQLException{
		Map<String, Integer> m = new HashMap<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select min(year(cash_date)) min, max(year(cash_date)) max from cash");
		System.out.println("cashByYearList :"+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			m.put("min", rs.getInt("min"));
			m.put("max", rs.getInt("max"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return m;
	}
	// cashList.jsp
	public List<Map<String,Object>> selectCashYearList(String email, int year) throws ClassNotFoundException, SQLException{
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select month(cash_date) month,kind, sum(money) sum from cash where email =? and year(cash_date) = ? group by month(cash_date), kind order by month(cash_date)");
		stmt.setString(1, email);
		stmt.setInt(2, year);
		System.out.println("selectCashYearList :"+stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Map<String,Object> m = new HashMap<>();
			m.put("month", rs.getInt("month"));
			m.put("kind", rs.getString("kind"));
			m.put("sum", rs.getInt("sum"));
			list.add(m);
		}
		return list;
	}
	// updateCashAction.jsp
	public int updateCash(Cash c) throws ClassNotFoundException, SQLException {
		int row=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("update cash set kind=?, money=?, memo = ?, updatedate = now() where cash_no =?");
		stmt.setString(1, c.getKind());
		stmt.setInt(2, c.getMoney());
		stmt.setString(3, c.getMemo());
		stmt.setInt(4, c.getCashNo());
		System.out.println("updateCash :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	//updateCashForm.jsp
	public Cash selectCashOne(int cashNo) throws ClassNotFoundException, SQLException {
		Cash c = null;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select cash_date, kind, money, memo, cash_no from cash where cash_no =?");
		stmt.setInt(1, cashNo);
		System.out.println("selectCashOne :"+stmt);
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) {
			c= new Cash();
			c.setCashDate(rs.getString("cash_date"));
			c.setKind(rs.getString("kind"));
			c.setMoney(rs.getInt("money"));
			c.setMemo(rs.getString("memo"));
			c.setCashNo(rs.getInt("cash_no"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return c;
	}
	
	// deleteCash.jsp
	public int deleteCash(Cash c) throws ClassNotFoundException, SQLException {
		int row=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("delete from cash where cash_no = ?");
		stmt.setInt(1,c.getCashNo());
		System.out.println("deleteCash :"+stmt);
		row=stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	// insertCashAction.jsp
	public int insertCash(Cash c) throws ClassNotFoundException, SQLException {
		int row=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("insert into cash(email, cash_date, kind, money, memo, updatedate, createdate) values(?,?,?,?,?,now(),now())") ;
		stmt.setString(1, c.getEmail());
		stmt.setString(2, c.getCashDate());
		stmt.setString(3, c.getKind());
		stmt.setInt(4, c.getMoney());
		stmt.setString(5, c.getMemo());
		System.out.println("insertCash :"+stmt);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	// cashByDate.jsp
	public List<Cash> selectCashListByDate(Cash c) throws ClassNotFoundException, SQLException{
		List<Cash> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select cash_no, email, cash_date, kind, money, memo,updatedate,createdate from cash where email=? and cash_date=? order by kind asc");
		stmt.setString(1, c.getEmail());
		stmt.setString(2, c.getCashDate());
		System.out.println("selectCashListByDate :"+ stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Cash cash = new Cash();
			cash.setCashNo(rs.getInt("cash_no"));
			cash.setEmail(rs.getString("email"));
			cash.setCashDate(rs.getString("cash_date"));
			cash.setKind(rs.getString("kind"));
			cash.setMoney(rs.getInt("money"));
			cash.setMemo(rs.getString("memo"));
			cash.setUpdatedate(rs.getString("updatedate"));
			cash.setCreatedate(rs.getString("createdate"));
			list.add(cash);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// cashByMonth.jsp 호출
	public List<Cash> selectCashListByMonth(String email, int targetYear, int targetMonth) throws ClassNotFoundException, SQLException{
		List<Cash> list = new ArrayList<>();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select cash_no, email, cash_date, kind, money from cash where email=? and year(cash_date)=? and month(cash_date)=? order by cash_date asc, kind asc");
		stmt.setString(1, email);
		stmt.setInt(2, targetYear);
		stmt.setInt(3, targetMonth);
		System.out.println("selectCashListByMonth :"+stmt);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Cash c = new Cash();
			c.setCashNo(rs.getInt("cash_no"));
			c.setEmail(rs.getString("email"));
			c.setCashDate(rs.getString("cash_date"));
			c.setKind(rs.getString("kind"));
			c.setMoney(rs.getInt("money"));
			list.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// deleteMemberAction
	public int countCash(Cash c) throws ClassNotFoundException, SQLException {
		int count = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("select count(*) from cash where email=?");
		stmt.setString(1,c.getEmail());
		System.out.println("countCash :"+stmt);
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("count(*)");
		}
		rs.close();
		stmt.close();
		conn.close();
		return count;
	}
	
	// deleteMemberAction 호출
	// 회원 탈퇴시 cash테이블 회원 정보들을 삭제
	public int deleteCashByEmail(String email) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("delete from cash where email=?");
		stmt.setString(1, email);
		
		System.out.println("삭제할 cash 레코드의 이메일: " + email);
		row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
}
