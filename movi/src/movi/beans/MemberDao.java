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
	
	//회원 삭제 - 관리자도 쓸 수 있게 반환값을 boolean으로 처리 -> 삭제할 대상이 없거나 실패할 경우 대비
	public boolean delete(int member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete member where member_no = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		int count = ps.executeUpdate();
		return count > 0;
	}
	
	//회원 검색 - member_no을 기준으로 단일 대상 찾기
	public MemberDto find(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ResultSet rs = ps.executeQuery();
		
		MemberDto memberDto;
		if(rs.next()) {
			memberDto = new MemberDto();
			memberDto.setMember_no(rs.getInt("member_no"));
			memberDto.setMember_event_no(rs.getInt("member_event_no"));
			memberDto.setMember_id(rs.getString("member_id"));
			memberDto.setMember_pw(rs.getString("member_pw"));
			memberDto.setMember_nick(rs.getString("member_nick"));
			memberDto.setMember_phone(rs.getString("member_phone"));
			memberDto.setMember_date(rs.getDate("member_date"));
			memberDto.setMember_auth(rs.getString("member_auth"));
		}
		else {
			memberDto = null;
		}
		
		con.close();
		
		return memberDto;		
	}
}
