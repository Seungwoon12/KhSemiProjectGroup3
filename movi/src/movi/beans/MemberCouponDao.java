package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import movi.util.JdbcUtil;

public class MemberCouponDao {
	public void insert(int member_no, int coupon_no, int event_no) throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "insert into member_coupon values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ps.setInt(2, coupon_no);
		ps.setInt(3, event_no);
		
		ps.execute();
		con.close();
	}
}
