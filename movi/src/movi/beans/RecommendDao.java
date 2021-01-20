package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class RecommendDao {
	
	public static final String USER="movi";
	public static final String PASS="movi";
	
	//3조 추천 영화
	
	//삽입
	public void insert(RecommendDto recomDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		String sql = "insert into Rocommend values(recom_seq.nextval , ?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recomDto.getRecom_movie_no());
		ps.setString(2,recomDto.getRecom_title());
		ps.execute();
		con.close();
		
	}
	
	//보기
	public List<RecommendDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection(USER, PASS);
		
		String sql = "select recom_title from recommend group by recom_title"; 
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<RecommendDto> list = new ArrayList<>();
		while(rs.next()) {
			RecommendDto dto = new RecommendDto();
			dto.setRecom_title(rs.getString("recom_title"));
			list.add(dto);
		}
		con.close();
		return list;
	}
}
