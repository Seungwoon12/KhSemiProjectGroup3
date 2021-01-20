package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MovieDao {
	
	public static final String USER="movi";
	public static final String PASS="movi";
	
	//좋아요순
	public List<MovieDtoVO> select_love() throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from("
					+ "select rownum rn, TMP.* from("
							+ "select m.movie_no, m.movie_name, count(l.love_no) mlike "
							+ "from movie M "
					        + "left outer join love L on m.movie_no=l.love_movie_no " 
					        + "group by m.movie_no,m.movie_name " 
					        + "order by mlike desc)TMP"
					 + ")where rn between 1 and 5";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> list = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO vo = new MovieDtoVO();
			vo.setMovie_no(rs.getInt("movie_no"));
			vo.setMovie_name(rs.getString("movie_name"));
			vo.setMlike(rs.getInt("mlike"));
			list.add(vo);
		}
		con.close();
		return list;
	}
	
	//관객순
	public List<MovieDto> select_aud() throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from ( "
						+ "select M.*, rownum rn from movie M "
						+ "order by movie_audience desc"
						+ ")where rn between 1 and 5";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_no(rs.getInt("movie_no"));
			dto.setMovie_name(rs.getString("movie_name"));
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	//장르 불러오기
	public List<MovieDto> select_genre(int movie_genre_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from movie where movie_genre_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_genre_no);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_no(rs.getInt("movie_no"));
			dto.setMovie_name(rs.getString("movie_name"));
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	//영화 상세보기
	public List<MovieDto> select_movie(int movie_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from movie where movie_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_name(rs.getString("movie_name"));
			dto.setMovie_age(rs.getString("movie_age"));
			dto.setMovie_audience(rs.getInt("movie_audience"));
			dto.setMovie_content(rs.getString("movie_content"));
			dto.setMovie_country(rs.getString("movie_country"));
			dto.setMovie_date(rs.getDate("movie_date"));
			dto.setMovie_director(rs.getString("movie_director"));
			dto.setMovie_rate(rs.getDouble("movie_rate"));
			dto.setMovie_time(rs.getInt("movie_time"));
			dto.setMovie_no(rs.getInt("movie_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	//고객맞춤순
	//public List<MovieDto> select_mem() throws Exception{

	//}
	
	
	
	// 관리자 모드
	// 영화 상세보기-/admin/movieDetail.jsp
	public MovieDto select(int movie_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql =" select * from movie where movie_no=?";
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
			
		}else {
			movieDto = null;
		}
		con.close();
		
		return movieDto;
		
	}
	
	// 영화 목록-/admin/moveList.jsp
	public List<MovieDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, USER);
		
		String sql="select movie_no, movie_name,  movie_date, movie_audience "
				+ " from movie order by movie_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> movieList = new ArrayList<>();
		while(rs.next()) {
			MovieDto movieDto = new MovieDto();
			movieDto.setMovie_no(rs.getInt("movie_no"));
			movieDto.setMovie_name(rs.getString("movie_name"));
			movieDto.setMovie_date(rs.getDate("movie_date"));
			movieDto.setMovie_audience(rs.getInt("movie_audience"));
			movieList.add(movieDto);
		}
			con.close();
			
			return movieList;
		
	}
	
}
