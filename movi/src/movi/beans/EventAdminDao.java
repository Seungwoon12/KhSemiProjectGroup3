package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class EventAdminDao {
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
	
	//쿠폰 발급하기 - /admin/memberCouponInsert.jsp
	public void insert_admin(EventAdminDtoVO eventDto) throws Exception{
		Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into event values(event_seq.nextval, ?, ?, ?, ?, ?, ?) ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventDto.getEvent_member_no());
		ps.setString(2,eventDto.getEvent_name());
		ps.setDate(3, eventDto.getEvent_start());
		ps.setDate(4, eventDto.getEvent_end());
		ps.setString(5, eventDto.getEvent_content());
		ps.setString(6, eventDto.getEvent_coupon());
		ps.execute();
		
		con.close();
	}
	
	
	//쿠폰 목록- /admin/memberCouponList.jsp
	//페이징 + 회원 쿠폰 목록:아이디, 이벤트명 -/admin/memberCouponList.jsp	
		public List<MemberAdminDtoVO> coupage_admin(String type, String key, int startRow, int endRow)throws Exception{
			Connection con =JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from( " + 
						"    select rownum rn , TMP.* from( " + 
						"        select  " + 
						"                    M.member_no, M.member_id ,M.member_phone, " + 
						"                    E.event_name, E.event_coupon ,E.event_start, E.event_end " + 
						"             from member M " + 
						"                    right outer join event E on E.event_member_no = M.member_no " + 
						"        where instr(#1 , ?)>0    " + 
						"        order by M.member_no " + 
						"    )TMP   " + 
						") where rn between ? and ?   ";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			ResultSet rs = ps.executeQuery();		
			
			List<MemberAdminDtoVO> memberList = new ArrayList<>();
			while(rs.next()) {
				MemberAdminDtoVO memberDto = new MemberAdminDtoVO();
				memberDto.setMember_no(rs.getInt("member_no"));
				memberDto.setMember_id(rs.getString("member_id"));
				memberDto.setMember_phone(rs.getString("member_phone"));
				memberDto.setEvent_name(rs.getString("event_name"));
				memberDto.setEvent_coupon(rs.getString("event_coupon"));
				memberDto.setEvent_start(rs.getDate("event_start"));
				memberDto.setEvent_end(rs.getDate("event_end"));
				memberList.add(memberDto);
			}
			con.close();
			
			return memberList;
			
		}
		
	//페이징 + 쿠폰 목록(검색X) -/admin/memberCouponList.jsp
		public List<MemberAdminDtoVO> coupage_admin(int startRow , int endRow)throws Exception{
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = " select * from( " + 
					"        select rownum rn, TMP.* from( " + 
					"            select " + 
					"                M.member_no, M.member_id ,M.member_phone, " + 
					"                E.event_name, E.event_coupon ,E.event_start, E.event_end " + 
					"                from member M " + 
					"                right outer join event E on E.event_member_no = M.member_no    " + 
					"            order by M.member_no  " + 
					"        )TMP " + 
					"    )where rn between ? and ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			ResultSet rs = ps.executeQuery();
			
			List<MemberAdminDtoVO> memberList = new ArrayList<>();
			while(rs.next()) {
				MemberAdminDtoVO memberDto = new MemberAdminDtoVO();
				memberDto.setMember_no(rs.getInt("member_no"));
				memberDto.setMember_id(rs.getString("member_id"));
				memberDto.setMember_phone(rs.getString("member_phone"));
				memberDto.setEvent_name(rs.getString("event_name"));
				memberDto.setEvent_coupon(rs.getString("event_coupon"));
				memberDto.setEvent_start(rs.getDate("event_start"));
				memberDto.setEvent_end(rs.getDate("event_end"));
				memberList.add(memberDto);
			}
			con.close();
			
			return memberList;
		
		}
	
	//쿠폰 수정하기
	
	//회원 쿠폰 정보 수정- /admin/memberCouponEdit.jsp
	public boolean couedit_admin(MemberAdminDtoVO memberDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "update event E " + 
					"    set E.event_name=?, E.event_coupon=? , " + 
					"        E.event_start=? , E.event_end=?  " + 
					"where event_member_no= ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getEvent_name());
		ps.setString(2, memberDto.getEvent_coupon());
		ps.setDate(3, memberDto.getEvent_start());
		ps.setDate(4, memberDto.getEvent_end());
		ps.setInt(5, memberDto.getMember_no());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;

	} 
	
	//쿠폰 삭제하기 - /admin/CouDelete.do
	public boolean delete_admin(int event_member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete event where event_member_no = ? ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_member_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ; 
		
	}
	
	//회원 목록 개수 -/admin/memberList.jsp
		public int count_admin() throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = "select count(*) from member ";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();

			return count;
		}

	//회원 검색 개수 -/admin/memberList.jsp
		public int count_admin(String type, String key) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = " select count(*) from member where instr(#1, ?) >0 ";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);

			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);

			con.close();

			return count;

		}
	
	//진행중인 이벤트 목록보기- /admin/EventList.jsp
	
	//진행중인 이벤트 상세보기- /admin/EventDetail.jsp
	
	//진행중인 이벤트 삭제- /admin/EventDelete.do
	
	//진행중인 이벤트 수정 - /admin/EventEdit.jsp
	
///////////////////////////////////////////////////////////////////////////////////	
	
}
