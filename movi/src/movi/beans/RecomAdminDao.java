package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class RecomAdminDao {

	public static final String USER="kh43";
	public static final String PASS="kh43";
	
//3조 추천영화 상세보기 -admin/recomList.jsp
	public List<RecommendDtoVO> select_admin(String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select r.recom_title,m.movie_name,r.recom_movie_no,r.recom_no "
				+"from recommend R "
				+ "left outer join movie M on r.recom_movie_no=m.movie_no "
				+ "where r.recom_title=?"; 
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, recom_title);
		ResultSet rs = ps.executeQuery();
		
		List<RecommendDtoVO> recomList = new ArrayList<>();
		while(rs.next()) {
			RecommendDtoVO recomDto = new RecommendDtoVO();
			recomDto.setRecom_title(rs.getString("recom_title"));
			recomDto.setRecom_movie_name(rs.getString("movie_name"));
			recomDto.setRecom_movie_no(rs.getInt("recom_movie_no"));
			recomDto.setRecom_no(rs.getInt("recom_no"));
			recomList.add(recomDto);
		}
		con.close();
		return recomList;
	}
 	
//추천태그 태그들 보기-admin/recomList.jsp
	public List<RecommendDto> select_title() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select recom_title from recommend group by recom_title"; 
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<RecommendDto> recomList = new ArrayList<>();
		while(rs.next()) {
			RecommendDto dto = new RecommendDto();
			dto.setRecom_title(rs.getString("recom_title"));
			recomList.add(dto);
		}
		con.close();
		return recomList;
	}	

//회원 상세보기 반환형은 Dto 
	public List<RecommendDto> selectAll_admin(String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select * from recommend where recom_title = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, recom_title);
		ResultSet rs = ps.executeQuery();
		
		List<RecommendDto> list = new ArrayList<>();
		while(rs.next()) {
			RecommendDto recomDto = new RecommendDto();
			recomDto.setRecom_title(rs.getString("recom_title"));
			recomDto.setRecom_movie_no(rs.getInt("recom_movie_no"));
			list.add(recomDto);
		}
		con.close();
		return list;
	}
	
		
//3조 추천영화 추가 -admin/recomInsert.jsp
	public void insert_admin(int movie_no , String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		String sql="insert into recommend values(recom_seq.nextval, ? , ?) ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ps.setString(2,recom_title);
		ps.execute();
		con.close();
		
	}
	
//3조 추천영화 삭제	-admin/recomDelete.do
	//테그안에서 영화를 삭제
	//delete recommend where recom_movie_no= ? and recom_title= ?  ;
	public boolean delete_movie(int recom_movie_no, String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "delete recommend where recom_movie_no= ? and recom_title= ?  ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recom_movie_no);
		ps.setString(2,recom_title);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;
	}
	
	
	
	//테그를 삭제
	//delete recommend where recom_title=? ;
	public boolean delete_amdin(String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "delete recommend where recom_title=? ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, recom_title);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;
		
	}
	
//태그명 변경
	//update recommend set recom_title= ? where recom_title=? ;
	public boolean edit_admin(String new_recom_title, String recom_title) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql ="update recommend set recom_title= ? where recom_title=?" ; 
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, new_recom_title);
		ps.setString(2, recom_title);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count >0 ;
		
		
	}
	
	//추천 영화의 영화 삭제
	public boolean delete_no_admin(int recom_movie_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "delete recommend where recom_movie_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recom_movie_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;
	}
	//recom_no으로 reom_title찾기
	public List<RecommendDto> find(int recom_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select * from recommend where recom_no = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recom_no);
		ResultSet rs = ps.executeQuery();
		
		List<RecommendDto> list = new ArrayList<>();
		while(rs.next()) {
			RecommendDto recomDto = new RecommendDto();
			recomDto.setRecom_title(rs.getString("recom_title"));
			list.add(recomDto);
		}
		con.close();
		return list;
	}
	
}
