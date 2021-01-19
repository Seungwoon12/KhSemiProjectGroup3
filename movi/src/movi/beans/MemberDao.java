package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import movi.util.JdbcUtil;

public class MemberDao {
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
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
