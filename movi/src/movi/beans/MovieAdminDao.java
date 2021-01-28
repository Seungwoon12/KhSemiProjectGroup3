package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MovieAdminDao {
	// 계정 정보를 상수로 저장
	public static final String USER = "movi";
	public static final String PASS = "movi";

// 영화 상세보기-/admin/movieDetail.jsp
	public MovieDto select_admin(int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = " select * from movie where movie_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();

		MovieDto movieDto;
		if (rs.next()) {
			movieDto = new MovieDto();
			movieDto.setMovie_no(rs.getInt("movie_no"));
			movieDto.setMovie_genre_no(rs.getInt("movie_genre_no"));
			movieDto.setMovie_name(rs.getString("movie_name"));
			movieDto.setMovie_rate(rs.getDouble("movie_rate"));
			movieDto.setMovie_time(rs.getInt("movie_time"));
			movieDto.setMovie_age(rs.getString("movie_age"));
			movieDto.setMovie_country(rs.getString("movie_country"));
			movieDto.setMovie_date(rs.getDate("movie_date"));
			movieDto.setMovie_director(rs.getString("movie_director"));
			movieDto.setMovie_content(rs.getString("movie_content"));
			movieDto.setMovie_audience(rs.getInt("movie_audience"));

		} else {
			movieDto = null;
		}
		con.close();

		return movieDto;

	}

// 영화 목록-/admin/movieList.jsp
	public List<MovieDto> select_admin() throws Exception {
		Connection con = JdbcUtil.getConnection(USER, USER);

		String sql = "select movie_no, movie_name,  movie_date, movie_audience "
						+ " from movie order by movie_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<MovieDto> movieList = new ArrayList<>();
		while (rs.next()) {
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

//영화추가 하기-/admin/movieInsert.jsp
	public void insert_admin(MovieDto movieDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "insert into movie values " 
						+ "(movie_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movieDto.getMovie_genre_no());
		ps.setString(2, movieDto.getMovie_name());
		ps.setDouble(3, movieDto.getMovie_rate());
		ps.setInt(4, movieDto.getMovie_time());
		ps.setString(5, movieDto.getMovie_age());
		ps.setString(6, movieDto.getMovie_country());
		ps.setDate(7, movieDto.getMovie_date());
		ps.setString(8, movieDto.getMovie_director());
		ps.setString(9, movieDto.getMovie_content());
		ps.setInt(10, movieDto.getMovie_audience());
		ps.execute();

		con.close();

	}

//영화 수정 - /admin/movieEdit.do
	public boolean edit_admin(MovieDto movieDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "update movie " 
						+ " set   movie_genre_no=? ,  movie_name=? , movie_rate=? , movie_time=? , "
							+ " movie_age=? , movie_country=? , movie_date= ? , "
							+ "	movie_director=? , movie_content=? , movie_audience=? " 
					+ " where movie_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movieDto.getMovie_genre_no());
		ps.setString(2, movieDto.getMovie_name());
		ps.setDouble(3, movieDto.getMovie_rate());
		ps.setInt(4, movieDto.getMovie_time());
		ps.setString(5, movieDto.getMovie_age());
		ps.setString(6, movieDto.getMovie_country());
		ps.setDate(7, movieDto.getMovie_date());
		ps.setString(8, movieDto.getMovie_director());
		ps.setString(9, movieDto.getMovie_content());
		ps.setInt(10, movieDto.getMovie_audience());
		ps.setInt(11, movieDto.getMovie_no());
		int count = ps.executeUpdate();

		con.close();

		return count > 0;

	}

//영화 삭제 - /admin/movieDelete.do
	public boolean delete_admin(int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "delete movie where movie_no =? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		int count = ps.executeUpdate();

		con.close();

		return count > 0;
	}

//영화 검색+리스트 - /admin/movieList.jsp
	public List<MovieDto> select_admin(String type, String key) throws Exception {
		if (type == null || key == null)
			return null;

		Connection con = JdbcUtil.getConnection(USER, USER);

		String sql = "select * from movie where instr(#1, ?) >0 order  by movie_no desc";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();

		List<MovieDto> movieList = new ArrayList<>();
		while (rs.next()) {
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

//페이징+영화 검색 :영화번호+ 영화제목 -/admin/movieList.jsp
	public List<MovieDto> page_admin(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "select * from( " 
				+ "    select rownum rn , TMP.* from( " 
				+ "        select * from movie "
				+ "        where instr( #1 , ?) >0 " 
				+ "        order by movie_no asc " 
				+ "    )TMP   "
				+ ") where rn between ? and ? ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();

		List<MovieDto> movieList = new ArrayList<>();
		while (rs.next()) {
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

//페이징+영화 목록(검색X) -admin/movieList.jsp
	public List<MovieDto> page_admin(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "select * from( " 
					+ "    select rownum rn , TMP.* from( "
					+ "        select * from movie order by movie_no asc "
					+ "    )TMP " 
					+ ") where rn between ? and ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();

		List<MovieDto> movieList = new ArrayList<>();
		while (rs.next()) {
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

//영화 목록 개수- /admin/movielist.jsp
	public int count_admin() throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "select count(*) from movie ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();

		return count;
	}

//영화 검색 개수 - /admin/movieList.jsp
	public int count_admin(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "select count(*) from movie where instr(#1 , ?) >0 ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
//영화 상세보기+배우 추가 -admin/movieDetail.jsp
	public List<MovieDtoVO> actor_admin(int movie_no, String actor_role) throws Exception{
		Connection con =JdbcUtil.getConnection(USER, PASS);
		
		String sql="select * from actor " + 
				"    right outer join actor_con " + 
				"    on actor_no = con_actor_no " + 
				"    where con_movie_no= ? and con_actor_role=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ps.setString(2, actor_role);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> actorList = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO actorDto = new MovieDtoVO();
			actorDto.setActor_name(rs.getString("actor_name"));
			actorList.add(actorDto);
		}
		con.close();
		
		return actorList;
	}

//영화 상세보기+장르 추가	
	public List<MovieDtoVO> genre_admin(int movie_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql="select M.*, G.genre_name from movie M " + 
					"    left outer join genre G on G.genre_no = M.movie_genre_no " + 
					"where M.movie_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> genreList = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO genreDto = new MovieDtoVO();
			genreDto.setMovie_no(rs.getInt("movie_no"));
			genreDto.setGenre_name(rs.getString("genre_name"));
			genreList.add(genreDto);
		}
			con.close();
			
			return genreList;
		
	}
	
//영화 상세보기+ 좋아요 수 추가
	public List<MovieDtoVO> mlike_amdin(int movie_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql= "select M.movie_no, M.movie_name, count(L.love_movie_no) mlike " + 
					"    from movie M " + 
					"    left outer join love L on M.movie_no = L.love_movie_no " + 
					"    where movie_no =? " + 
					"    group by M.movie_no, M.movie_name " ;
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> mlikeList = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO mlikeDto = new MovieDtoVO();
			mlikeDto.setMovie_no(rs.getInt("movie_no"));
			mlikeDto.setMlike(rs.getInt("mlike"));
			mlikeList.add(mlikeDto);
		}
		con.close();
		
		return mlikeList;
		
	}
	
	
	
}
