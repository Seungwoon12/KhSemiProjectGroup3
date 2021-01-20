package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MygenreDao {
	
	public static final String USER="movi";
	public static final String PW="movi";
	
	public List<MygenreDtoVO> find(int mygenre_member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PW);
		String sql ="select g.genre_name, m.mygenre_member_no " + 
					"from genre G right outer join mygenre M on g.genre_no=m.mygenre_no " + 
					"where m.mygenre_member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, mygenre_member_no);
		ResultSet rs = ps.executeQuery();
		
		List<MygenreDtoVO> list = new ArrayList<>();
		while(rs.next()) {
			MygenreDtoVO dto = new MygenreDtoVO();
			dto.setGenre_name(rs.getString("genre_name"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}

}
