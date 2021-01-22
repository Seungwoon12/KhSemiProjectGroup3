package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class GenreDao {
	public List<GenreDto> view() throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "select * from Genre";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<GenreDto> list = new ArrayList<>();
		while(rs.next()) {
			GenreDto dto = new GenreDto();
			dto.setGenre_no(rs.getInt("genre_no"));
			dto.setGenre_name(rs.getString("genre_name"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	//동진 수정
	//장르 번호로 -> 장르 이름 찾기
	public String find(int genre_no) throws Exception{
		Connection con = JdbcUtil.getConnection("movi", "movi");
		String sql = "select * from Genre where genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genre_no);
		
		ResultSet rs = ps.executeQuery();
		
		String genre_name;
		if(rs.next()) {
			genre_name = rs.getString("genre_name");
		}
		else {
			genre_name = null;
		}
		con.close();
		return genre_name;
	}
}
