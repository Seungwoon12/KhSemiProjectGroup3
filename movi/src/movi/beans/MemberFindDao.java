package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import movi.util.JdbcUtil;

public class MemberFindDao {
	
	public String id_find insert(MemberFindDto dto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into member("
				+ "member_no,member_id,member_pw,member_nick,member_phone,member_auth)"
				+ " values(member_seq.nextval,?,?,?,?,'일반')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getMember_id());
		ps.setString(2, dto.getMember_pw());
		ps.setString(4, dto.getMember_phone());
		ps.execute();
		
		con.close();
	}
	
}
