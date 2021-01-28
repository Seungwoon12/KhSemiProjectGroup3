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
	
	public List<MemberCouponInfoVO> find_member(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "select C.coupon_name, C.coupon_start, C.coupon_end, E.event_name "
				+ "from member_coupon MC "
				+ "left outer join coupon C on MC.member_coupon_no = C.coupon_no "
				+ "left outer join event E on MC.member_event_no = E.event_no "
				+ "where MC.event_member_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<MemberCouponInfoVO> list = new ArrayList<>();
		while(rs.next()) {
			MemberCouponInfoVO memberCouponInfoVO = new MemberCouponInfoVO();
			memberCouponInfoVO.setCoupon_name(rs.getString("coupon_name"));
			memberCouponInfoVO.setStart(rs.getDate("coupon_start"));
			memberCouponInfoVO.setEnd(rs.getDate("coupon_end"));
			memberCouponInfoVO.setEvent_name(rs.getString("event_name"));
			
			list.add(memberCouponInfoVO);
		}
		con.close();
		return list;
	}
}
