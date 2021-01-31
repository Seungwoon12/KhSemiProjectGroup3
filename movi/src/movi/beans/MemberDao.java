
package movi.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MemberDao {

	//계정 정보를 상수로 저장
		public static final String USERNAME = "movi";
		public static final String PASSWORD = "movi";
	
	//회원가입
	public void insert(MemberDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into member("
				+ "member_no,member_id,member_pw,member_nick,member_phone,member_auth,member_email)"
				+ " values(member_seq.nextval,?,?,?,?,'일반')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ps.setString(3, dto.getMember_nick());
		ps.setString(4, dto.getMember_phone());

		ps.execute();
		
		con.close();
	}
//아이디중복
	public boolean confirm(String id) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from member where member_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();

	
	boolean result=rs.next();
	
		con.close();
		
		return result;
	}
	
	

	    //로그인

		public boolean login(MemberDto dto) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			
			String sql = "select * from member where member_id=? and member_pw=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getMember_id());
			ps.setString(2, dto.getMember_pw());

			ResultSet rs = ps.executeQuery();

	//데이터는 있거나 없거나 둘중 하나
		
		boolean result=rs.next();
		
			con.close();
			
			return result;
		}


	
		
		
		
		
		
		
		
		
		
		
		
		
		
		


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
		
		con.close();
		
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
	
	//회원 정보 수정 - 세션에서 받아온 멤버 번호의 회원의 비밀번호와 입력한 비밀번호가 일치하는지 확인해서 일치하면 수정
	public boolean edit(MemberDto memberDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member "
				+ "set member_nick=?, member_phone=? "
				+ "where member_no=? and member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, memberDto.getMember_nick());
		ps.setString(2, memberDto.getMember_phone());
		ps.setInt(3, memberDto.getMember_no());
		ps.setString(4, memberDto.getMember_pw());
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	//회원 비밀번호 수정 
	public boolean editPassword(MemberDto memberDto, String member_pw) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update member "
				+ "set member_pw=? "
				+ "where member_no=? and member_pw=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_pw);
		ps.setInt(2, memberDto.getMember_no());
		ps.setString(3, memberDto.getMember_pw());
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}	
		
///찾기
		public MemberDto find(String member_id)  throws Exception {
				Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
				String sql = "select * from member where member_id = ?";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, member_id);
				ResultSet rs = ps.executeQuery();
				
				MemberDto dto;
				if(rs.next()) {
					dto = new MemberDto();
					dto.setMember_no(rs.getInt("member_no"));
					dto.setMember_id(rs.getString("member_id"));
					dto.setMember_pw(rs.getString("member_pw"));
					dto.setMember_nick(rs.getString("member_nick"));								
					dto.setMember_auth(rs.getString("member_auth"));
				
				}
				else {
					dto = null;
				}
				
				con.close();
				
				return dto;		
			}

}
