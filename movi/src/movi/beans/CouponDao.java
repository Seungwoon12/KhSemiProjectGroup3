package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class CouponDao {
	public List<CouponDto> goods(int event_no) throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "select * from coupon where coupon_event_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		List<CouponDto> list = new ArrayList<>();
		while(rs.next()) {
			CouponDto dto = new CouponDto();
			dto.setCoupon_name(rs.getString("coupon_name"));
			list.add(dto);
		}
		con.close();
		return list;
		}
}
