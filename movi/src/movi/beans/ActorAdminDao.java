package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.jdbc.pool.JdbcInterceptor;

import movi.util.JdbcUtil;

public class ActorAdminDao {
	// 계정 정보를 상수로 저장
	public static final String USER = "movi";
	public static final String PASS = "movi";
	
//배우 목록 -admin.actorList.jsp
	public List<ActorDto> select_admin() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql="select * from actor ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ActorDto> actorList = new ArrayList<>();
		while(rs.next()) {
			ActorDto actorDto = new ActorDto();
			actorDto.setActor_no(rs.getInt("actor_no"));
			actorDto.setActor_name(rs.getString("actor_name"));
			actorList.add(actorDto);
		}
		con.close();
		
		return actorList;
		
	}
	
//배우 수정 - /admin/actorEdit.do
	public boolean edit_admin(ActorDto actorDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "update actor set actor_name = ? where actor_no=?";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, actorDto.getActor_name());
		ps.setInt(2, actorDto.getActor_no());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;
		
	}
	
//배우 삭제하기 - /admin/actorDelete.do
	//public boolean delete_admin(int )
	
	
//배우 상세보기- admin/actorDetail.jsp
	public ActorDto select_admin(int actor_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select * from actor where actor_no = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, actor_no);
		ResultSet rs = ps.executeQuery();
		
		ActorDto actorDto;
		if(rs.next()) {
			actorDto = new ActorDto();
			actorDto.setActor_no(rs.getInt("actor_no"));
			actorDto.setActor_name(rs.getString("actor_name"));
		}else {
			actorDto = null;
		}
		con.close();
		
		return actorDto;
	}
	
//페이징 +배우 검색:배우 번호 or 배우이름  =/admin/actorList.jsp
	public List<ActorDto> page_admin(String type, String key, int startRow, int endRow)throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select * from( " + 
				"    select rownum rn , TMP.* from( " + 
				"        select * from actor " + 
				"        where instr( #1 , ? ) >0 " + 
				"        order by actor_no asc " + 
				"    )TMP   " + 
				") where rn between ? and ? ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ActorDto> actorList = new ArrayList<>();
		while(rs.next()) {
			ActorDto actorDto = new ActorDto();
			actorDto.setActor_no(rs.getInt("actor_no"));
			actorDto.setActor_name(rs.getString("actor_name"));
			actorList.add(actorDto);
		}
		con.close();
		
		return actorList;
	}
	
//페이징 +배우 목록(검색X) -admin/actorList.jsp
	public List<ActorDto> page_admin(int startRow, int endRow) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select * from(  " + 
				"    select rownum rn , TMP.* from( " + 
				"        select * from actor order by actor_no asc " + 
				"    )TMP   " + 
				") where rn between ? and ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ActorDto> actorList = new ArrayList<>();
		while(rs.next()) {
			ActorDto actorDto = new ActorDto();
			actorDto.setActor_no(rs.getInt("actor_no"));
			actorDto.setActor_name(rs.getString("actor_name"));
			actorList.add(actorDto);			
		}
		con.close();		
		
		return actorList;
	}
	
//배우 목록 개수 -amdin/actorList.jsp
	public int count_admin() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql= "select count(*) from actor ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();
		
		return count;
	}
	
	
	
//배우 검색 개수 - amdin/actorList.jsp	
	public int count_admin(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USER, PASS);

		String sql = "select count(*) from actor where instr(#1 , ?) >0 ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();

		return count;
	}

//배우 상세보기+ 작품 추가 -admin/actorDatil.jsp
	public List<MovieDtoVO> actor_admin(int actor_no, String actor_role)throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select actor_no, A.actor_name,  M.movie_name from actor A " + 
					"    left outer join actor_con AC  on A.actor_no = AC.con_actor_no " + 
					"    left outer join movie M on M.movie_no = AC.con_movie_no " + 
					"     where actor_no= ? and con_actor_role= ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, actor_no);
		ps.setString(2, actor_role);
		ResultSet rs = ps.executeQuery();
		
		List<MovieDtoVO> actorList = new ArrayList<>();
		while(rs.next()) {
			MovieDtoVO actorDto =new MovieDtoVO();
			actorDto.setMovie_name(rs.getString("movie_name"));
			actorList.add(actorDto);
		}
		con.close();
		
		return actorList;
	}

	
//	
}
