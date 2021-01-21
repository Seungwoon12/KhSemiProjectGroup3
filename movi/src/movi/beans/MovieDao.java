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
	public List<MovieDtoVO> select_love(int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from("
					+ "select rownum rn, TMP.* from("
							+ "select m.movie_no, m.movie_name, count(l.love_no) mlike "
							+ "from movie M "
					        + "left outer join love L on m.movie_no=l.love_movie_no " 
					        + "group by m.movie_no,m.movie_name " 
					        + "order by mlike desc)TMP"
					 + ")where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, end);
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
	public List<MovieDto> select_aud(int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from ( "
						+ "select M.*, rownum rn from movie M "
						+ "order by movie_audience desc"
						+ ")where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, end);
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
	
	//영화 이름으로 상세보기
	public List<MovieDto> select_movie(String movie_name) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select * from movie where movie_name=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, movie_name);
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
	public MovieDto select_admin(int movie_no) throws Exception{
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
	
	// 영화 목록-/admin/movieList.jsp
	public List<MovieDto> select_admin() throws Exception{
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
	

	//영화 이름 검색 검사
	public List<MovieDto> search_select(String search_name) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, USER);
		String sql = "select * from movie where instr(movie_name,?)>0";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, search_name);
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

	//영화추가 하기-/admin/movieInsert.jsp
	public void insert_admin(MovieDto movieDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "insert into movie values "
				+ "(movie_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movieDto.getMovie_genre_no());
		ps.setString(2, movieDto.getMovie_name());
		ps.setDouble(3, movieDto.getMovie_rate());
		ps.setInt(4, movieDto.getMovie_time());
		ps.setString(5, movieDto.getMovie_age());
		ps.setString(6, movieDto.getMovie_country());
		ps.setString(7, movieDto.getMovie_director());
		ps.setString(8, movieDto.getMovie_content());
		ps.setInt(9, movieDto.getMovie_audience());
		ps.execute();
		
		con.close();
		
	}
	
	//영화 수정 - /admin/movieEdit.do
	public boolean edit_admin(MovieDto movieDto) throws Exception{
		Connection con =JdbcUtil.getConnection(USER, PASS);
		
		String sql = "update movie " 
						+ " set   movie_genre_no=? ,  movie_name=? , movie_rate=? , movie_time=? , "
						+ "       movie_age=? , movie_country=? , movie_date=sysdate, " 
						+ "       movie_director=? , movie_content=? , movie_audience=? "
					+ " where movie_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movieDto.getMovie_genre_no());
		ps.setString(2, movieDto.getMovie_name());
		ps.setDouble(3, movieDto.getMovie_rate());
		ps.setInt(4, movieDto.getMovie_time());
		ps.setString(5, movieDto.getMovie_age());
		ps.setString(6, movieDto.getMovie_country());
		ps.setString(7, movieDto.getMovie_director());
		ps.setString(8, movieDto.getMovie_content());
		ps.setInt(9, movieDto.getMovie_audience());
		ps.setInt(10, movieDto.getMovie_no());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;

	}
}
