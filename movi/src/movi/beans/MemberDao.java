package movi.beans;

import java.sql.Connection;
import java.sql.DriverManager;
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
	
	//로그인 
	public void insert(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into member("
				+ "member_no,member_id,member_pw,member_nick,member_phone,member_auth)"
				+ " values(member_seq.nextval,?,?,?,?,'일반')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ps.setString(3, dto.getMember_nick());
		ps.setString(4, dto.getMember_phone());
		ps.execute();
		
		con.close();
	}
	
	//관리자모드
	
	//회원 상세보기-memberDetail.jsp
	public MemberDto select(int member_no) throws Exception{
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
	
	
	//회원 검색- memberList.jsp
	public List<MemberDto> select(String member_id)throws Exception{
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
		}
		con.close();
		
		return memberList;
		
	}
	
}
