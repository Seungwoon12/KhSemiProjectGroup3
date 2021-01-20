package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.beans.MemberDto;
import movi.util.JdbcUtil;

public class MemberDao {
	
	//계정 정보를 상수로 저장
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
	
	
	//관리자모드
	
	//회원 상세보기-/admin/memberDetail.jsp
	public MemberDto select_admin(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql="select member_no, member_id, member_nick, member_phone, " 
					+ " member_date, member_auth from member "
					+ " where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		MemberDto memberDto;
		if(rs.next()) {
			memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_nick(rs.getString("member_nick"));
			memberDto.setMember_phone(rs.getString("member_phone"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
			
		}else {
			memberDto = null;
		}
		con.close();
		
		return memberDto;
	}
	
	
	//회원 목록- /admin/memberList.jsp
	public List<MemberDto> select_admin() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select member_no, member_id , member_date , member_auth " 
						+ " from member order by member_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<MemberDto> memberList = new ArrayList<>();
		while(rs.next()) {
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
	
	//회원 정보 수정
	public boolean edit_admin(MemberDto memberDto) throws Exception{
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
	
	public boolean delete_admin(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
		String sql = "delete member where member_no = ?";
			
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
			
	}
	
		
	//member 탈퇴(삭제)
	public boolean delete(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
		String sql = "delete member where member_no = ?";
			
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		int count = ps.executeUpdate();
			
		return count > 0;
			
		//반환값 boolean으로 한 이유 : 관리자도 쓸 수 있는 공용 명령 -> 관리자가 사용시 없는 유저이거나 삭제가 안될경우 false 반환
	}
	
	
}
