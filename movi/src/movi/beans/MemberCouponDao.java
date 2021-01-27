package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
	
	public List<MemberCouponDto> find_member(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "select * from member_coupon where event_member_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<MemberCouponDto> list = new ArrayList<>();
		while(rs.next()) {
			MemberCouponDto memberCouponDto = new MemberCouponDto();
			memberCouponDto.setEvent_member_no(rs.getInt("event_member_no"));
			memberCouponDto.setMember_event_no(rs.getInt("member_event_no"));
			memberCouponDto.setMember_coupon_no(rs.getInt("member_coupon_no"));
			list.add(memberCouponDto);
		}
		con.close();
		return list;
	}
}
