package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MemberAdminDao {
	// 계정 정보를 상수로 저장
	public static final String USERNAME = "kh43";
	public static final String PASSWORD = "kh43";

//회원 상세보기-/admin/memberDetail.jsp
	public MemberDto select_admin(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select member_no, member_id, member_nick, member_phone, "
						+ " member_date, member_auth from member "
					+ " where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();

		MemberDto memberDto;
		if (rs.next()) {
			memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_nick(rs.getString("member_nick"));
			memberDto.setMember_phone(rs.getString("member_phone"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));

		} else {
			memberDto = null;
		}
		con.close();

		return memberDto;
	}
	
//회원 상세보기(+mygenre,event)  - /admin/memberDetail.jsp	
	public MemberAdminDtoVO SelectAll_admin(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql= "select M.* , E.event_name, C.coupon_name from member M  " + 
						"    left outer join  member_coupon MC on MC.event_member_no = M.member_no " + 
						"    left outer join event E on E.event_no = MC.member_event_no " + 
						"    left outer join coupon C on C.coupon_no = member_coupon_no " + 
						"    where member_no = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		MemberAdminDtoVO memberDto;
		if (rs.next()) {
			memberDto = new MemberAdminDtoVO();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_nick(rs.getString("member_nick"));
			memberDto.setMember_phone(rs.getString("member_phone"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			memberDto.setEvent_name(rs.getString("event_name"));
			memberDto.setCoupon_name(rs.getString("coupon_name"));
		} else {
			memberDto = null;
		}
		con.close();

		return memberDto;
		
	}
	
	
	

//회원 목록- /admin/memberList.jsp
	public List<MemberDto> select_admin() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select member_no, member_id , member_date , member_auth "
						+ " from member order by member_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<MemberDto> memberList = new ArrayList<>();
		while (rs.next()) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			memberList.add(memberDto);
		}
		con.close();

		return memberList;

	}

//회원 정보 수정 -/admin/memberEdit.jsp
	public boolean edit_admin(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "update member set member_nick = ? , member_auth= ? "
						+ " where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, memberDto.getMember_nick());
		ps.setString(2, memberDto.getMember_auth());
		ps.setInt(3, memberDto.getMember_no());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;

	}


//회원 삭제 - /admin/memberDelete.do
	public boolean delete_admin(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "delete member where member_no = ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;

	}

//회원 임시 비밀번호 발급 - /admin/memberPw.do
	public boolean editPw_admin(int member_no, String pw) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = " update member set member_pw= ? where member_no= ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, pw);
		ps.setInt(2, member_no);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;

	}

//회원 검색+리스트 - /admin/memberList.jsp
	public List<MemberDto> select_admin(String type, String key) throws Exception {
		if (type == null || key == null)
			return null;

		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select * from member where instr(#1, ?) >0 order  by member_no desc";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();

		List<MemberDto> memberList = new ArrayList<>();
		while (rs.next()) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			memberList.add(memberDto);
		}
		con.close();

		return memberList;
	}

//페이징+회원 검색: 아이디 or번호 - /admin/memberList.jsp
	public List<MemberDto> page_admin(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select * from( " 
						+ "select rownum rn , TMP.* from( " 
							+ "select * from member  "
							+ "where instr( #1 , ?) >0 " 
							+ "order by member_no asc " 
						+ ")TMP "
					+ ") where rn between ? and ? ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<MemberDto> memberList = new ArrayList<>();
		while (rs.next()) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			memberList.add(memberDto);
		}
		con.close();

		return memberList;
	}

//페이징+ 회원 목록(검색X일때) -/admin/memberList.jsp
	public List<MemberDto> page_admin(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select * from( " 
						+ "select rownum rn , TMP.* from( "
							+ "select * from member order by member_no asc " 
						+ ")TMP  "
					+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		List<MemberDto> memberList = new ArrayList<>();
		while (rs.next()) {
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			memberList.add(memberDto);
		}
		con.close();

		return memberList;

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
	
	

}
