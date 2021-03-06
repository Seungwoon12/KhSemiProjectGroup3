package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class LoveDao {

	public static final String USERNAME="kh43";
	public static final String PASSWORD="kh43";
	
	//박동진 수정 구역 
	//유저 번호와 시작 / 끝 번호를 받아서 유저가 좋아요 누른 영화들을 최근에 좋아요한 순으로 정렬해서 보내주는 코드
	
	public List<LoveDto> select_love_movie (int member_no, int start, int end) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select * from ("
						+ "select rownum rn, L.* from("
							+ "select * from love where love_member_no=? order by love_date desc"
							+ ") L"
						+ ")where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ps.setInt(2, start);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		
		List<LoveDto> loveDto_list = new ArrayList<>();
		while(rs.next()) {
			LoveDto loveDto = new LoveDto();
			loveDto = new LoveDto();
			loveDto.setLove_date(rs.getDate("love_date"));
			loveDto.setLove_movie_no(rs.getInt("love_movie_no"));
			loveDto.setLove_member_no(rs.getInt("love_member_no"));
			
			loveDto_list.add(loveDto);
			}
		con.close();
		
		return loveDto_list;
	}
	
	//좋아요 추가하기
	public void love_plus(LoveDto loveDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into love values "
				+ "(?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, loveDto.getLove_movie_no());
		ps.setInt(2, loveDto.getLove_member_no());
		ps.execute();
		
		con.close();
	}
	
	//좋아요 삭제
	public void love_cancel(LoveDto loveDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete love where love_movie_no=? and love_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, loveDto.getLove_movie_no());
		ps.setInt(2, loveDto.getLove_member_no());
		ps.execute();
		
		con.close();
	}
	
	public boolean love_search(int member_no, int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from love where love_movie_no=? and love_member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ps.setInt(2, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		boolean result = false;
		if(rs.next()) {
			result = true;
		}
		con.close();
		
		return result;
	}
	
	public int love_count (int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select love_movie_no, count(*) love_num from love where love_movie_no=? group by love_movie_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		
		ResultSet rs = ps.executeQuery();
		
		int love_num = 0;
		if(rs.next()) {
			love_num = rs.getInt("love_num");
		}
		con.close();
		
		return love_num;
	}
}
