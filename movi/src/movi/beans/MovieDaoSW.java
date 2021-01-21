
//시험용(승운)
package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import movi.util.JdbcUtil;

public class MovieDaoSW {
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
	public MovieDto find(String movie_name) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from movie where movie_name = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, movie_name);
		ResultSet rs = ps.executeQuery();
		
		MovieDto movieDto;
		if(rs.next()) {
			movieDto = new MovieDto();
			movieDto.setMovie_no(rs.getInt("movie_no"));
			movieDto.setMovie_genre_no(rs.getInt("movie_genre_no"));
			movieDto.setMovie_name(rs.getString("movie_name"));
			movieDto.setMovie_rate(rs.getInt("movie_rate"));
			movieDto.setMovie_time(rs.getInt("movie_time"));
			movieDto.setMovie_age(rs.getString("movie_age"));
			movieDto.setMovie_country(rs.getString("movie_country"));
			movieDto.setMovie_date(rs.getDate("movie_date"));
			movieDto.setMovie_director(rs.getString("movie_director"));
			movieDto.setMovie_content(rs.getString("movie_content"));
			movieDto.setMovie_audience(rs.getInt("movie_audience"));
			
			
		}
		else {
			movieDto = null;
		}
		
		con.close();
		return movieDto;
	}
	
	public MovieDto find(int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from movie where movie_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		
		MovieDto movieDto;
		if(rs.next()) {
			movieDto = new MovieDto();
			movieDto.setMovie_no(rs.getInt("movie_no"));
			movieDto.setMovie_genre_no(rs.getInt("movie_genre_no"));
			movieDto.setMovie_name(rs.getString("movie_name"));
			movieDto.setMovie_rate(rs.getInt("movie_rate"));
			movieDto.setMovie_time(rs.getInt("movie_time"));
			movieDto.setMovie_age(rs.getString("movie_age"));
			movieDto.setMovie_country(rs.getString("movie_country"));
			movieDto.setMovie_date(rs.getDate("movie_date"));
			movieDto.setMovie_director(rs.getString("movie_director"));
			movieDto.setMovie_content(rs.getString("movie_content"));
			movieDto.setMovie_audience(rs.getInt("movie_audience"));
			
			
		}
		else {
			movieDto = null;
		}
		
		con.close();
		return movieDto;
	}
}
