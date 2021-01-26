package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import movi.util.JdbcUtil;

public class MemberCouponDao {
	public void insert(MemberCouponDto dto) throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "insert into member_coupon values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getEvent_member_no());
		ps.setInt(2, dto.getMember_event_no());
		ps.setInt(3, dto.getMember_coupon_no());
		
		ps.execute();
		con.close();
	}
}
