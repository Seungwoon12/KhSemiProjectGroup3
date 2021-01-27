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
							+ "select m.movie_no, m.movie_name, count(l.love_movie_no) mlike "
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
			vo.setRank(rs.getInt("rn"));
			list.add(vo);
		}
		con.close();
		return list;
	}
	
	//관객순 - orderby 후에 rownum을 할것.
	public List<MovieDtoVO> select_aud(int start, int end) throws Exception{
		Connection con = JdbcUtil.getConnection(USER,PASS);
		
		String sql ="select rownum,M.* from( " 
					+ "select * from movie "
					+ "order by movie_audience desc)M " 
					+ "where rownum between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> list = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO dto = new MovieDtoVO();
			dto.setMovie_no(rs.getInt("movie_no"));
			dto.setMovie_name(rs.getString("movie_name"));
			dto.setRank(rs.getInt("rownum"));
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
		
		String sql ="select * from movie where instr(movie_name, ?) > 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, movie_name);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_name(rs.getString("movie_name"));
			dto.setMovie_genre_no(rs.getInt("movie_genre_no"));
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
	

	
	
//****************************01.22 예림 수정
	//영화이름 전체 가져오기 검색시 사용
	public List<MovieDto> search_movie_name() throws Exception{
		Connection con =JdbcUtil.getConnection(USER, PASS);
		
		String sql ="select movie_name from movie";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_name(rs.getString("movie_name"));
			list.add(dto);
		}
		con.close();
		return list;
	}
	

//****************************01.23 예림 수정
	//회원이 선호하는 장르에 따른 영화 이름 가져오기
	//join은 left, outer 상관 없음! 영화 이름과 장르는 not null이니까
	public List<MovieDto> find_movie(int mygenre_member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		String sql ="select * "
				+ "from movie m "
				+ "left outer join mygenre mg "
				+ "on mg.mygenre_genre_no = m.movie_genre_no "
				+ "where mg.mygenre_member_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, mygenre_member_no);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDto> list = new ArrayList<>();
		while(rs.next()) {
			MovieDto dto = new MovieDto();
			dto.setMovie_name(rs.getString("movie_name"));
			dto.setMovie_no(rs.getInt("movie_no"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}
	
	//영화 이름으로 상세보기 +장르 이름까지
	//select_movie() 업그레이드 버전
		public List<MovieDtoVO> select_movie_detail(int movie_no) throws Exception{
			Connection con = JdbcUtil.getConnection(USER,PASS);
			
			String sql ="select * " + 
					"from movie m " + 
					"left outer join genre g on g.genre_no = m.movie_genre_no " + 
					"where m.movie_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, movie_no);
			ResultSet rs = ps.executeQuery();
			
			List<MovieDtoVO> list = new ArrayList<>();
			while(rs.next()) {
				MovieDtoVO dto = new MovieDtoVO();
				dto.setMovie_name(rs.getString("movie_name"));
				dto.setMovie_genre_no(rs.getInt("movie_genre_no"));
				dto.setMovie_age(rs.getString("movie_age"));
				dto.setMovie_audience(rs.getInt("movie_audience"));
				dto.setMovie_content(rs.getString("movie_content"));
				dto.setMovie_country(rs.getString("movie_country"));
				dto.setMovie_date(rs.getDate("movie_date"));
				dto.setMovie_director(rs.getString("movie_director"));
				dto.setMovie_rate(rs.getDouble("movie_rate"));
				dto.setMovie_time(rs.getInt("movie_time"));
				dto.setMovie_no(rs.getInt("movie_no"));
				dto.setGenre_name(rs.getString("genre_name"));
				
				list.add(dto);
			}
			con.close();
			return list;
		}
		
		//영화 이름에 따른 배우 리스트 쫙 불러오기 (주연,조연에 따라)
		public List<MovieDtoVO> find_actor(int movie_no, String actor_role) throws Exception{
			Connection con = JdbcUtil.getConnection(USER,PASS);
			
			String sql ="select * "
					+ "from actor "
					+ "right outer join actor_con "
					+ "on actor_no=con_actor_no "
					+ "where con_movie_no=? and con_actor_role=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, movie_no);
			ps.setString(2, actor_role);
			ResultSet rs = ps.executeQuery();
			
			List<MovieDtoVO> list = new ArrayList<>();
			while(rs.next()) {
				MovieDtoVO dto = new MovieDtoVO();
				dto.setActor_name(rs.getString("actor_name"));
				list.add(dto);
			}
			con.close();
			return list;
		}
		
}