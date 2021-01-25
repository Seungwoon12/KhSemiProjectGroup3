package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class ReviewAdminDao {

	// 데이터베이스 계정정보
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";

//리뷰 목록 - /admin/reviewList.jsp
	public List<ReviewDto> select_admin() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = "select review_no, review_writer_no, review_title, review_date, review_read "
						+ "from review order by review_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<ReviewDto> reviewList = new ArrayList<>();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
			reviewList.add(reviewDto);
		}
		con.close();

		return reviewList;

	}

//리뷰 상세보기- /admin/reviewDetail.jsp
	public ReviewDto select_admin(int review_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = " select * from review where review_no=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ResultSet rs = ps.executeQuery();
		
		ReviewDto reviewDto;
		if(rs.next()) {
			reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_movie_no(rs.getInt("review_movie_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_content(rs.getString("review_content"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
		} else {
			reviewDto = null;
		}
		con.close();
		
		return reviewDto;
		
		
	}
	

//리뷰 삭제하기- /admin/reviewDelete.do
	public boolean delete_admin(int review_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
				
		String sql = "delete review where review_no = ? ";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		int count = ps. executeUpdate();
		
		con.close();
		
		return count >0 ; 
		
	}
	

//리뷰 페이징 리뷰 목록(검색x)- admin/reviewList.jsp
	public List<ReviewDto> page_admin( int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

		String sql = " select * from( "
							+ "select rownum rn, TMP.* from( "
								+ "select * from review order by review_no desc "
							+ " )TMP " 
						+ ")where rn between ? and ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewDto> reviewList = new ArrayList<>();
		while(rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
			reviewList.add(reviewDto);
		}
		con.close();

		return reviewList;
		
	}

//리뷰 페이징+리뷰 검색: 제목+ 번호+ 아이디 - /admin/reviewlist.jsp
	public List<ReviewDto> page_admin(String type, String key, int startRow, int endRow) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from( " + 
						"select rownum rn , TMP.* from( " + 
								"select * from review " + 
								"where instr( #1, ?) >0 " + 
								"order by review_no desc " + 
							")TMP   " + 
						") where rn between ? and ? ";
		sql = sql.replace("#1",type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewDto> reviewList = new ArrayList<>();
		while(rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
			reviewList.add(reviewDto);
		}
		con.close();

		return reviewList;
	}	
		
//리뷰 목록 개수 -/admin/reviewList.jsp
		public int count_admin() throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = "select count(*) from review ";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();

			return count;
		}

		
//리뷰 검색 개수 -/admin/reviewList.jsp
		public int count_admin(String type , String key) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = " select count(*) from review where instr(#1, ?) >0 ";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);

			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);

			con.close();

			return count;

		}		
		
		
	
}
