package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import movi.util.JdbcUtil;

public class PosterTestDao {
	public static final String USERNAME="movi";
	public static final String PASSWORD="movi";
	
	public boolean update(int movie_no, String poster_file_name) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update movie set movie_poster = ? where movie_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, poster_file_name);
		ps.setInt(2, movie_no);
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
	
	public String find(int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select movie_poster from movie where movie_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		
		String poster_file_name = null;
		if(rs.next()) {
			poster_file_name = rs.getString("movie_poster");
		}
		
		con.close();
		
		return poster_file_name;
	}
}
