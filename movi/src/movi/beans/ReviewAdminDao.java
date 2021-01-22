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

//리뷰 삭제하기- /admin/reviewDelete.do

//리뷰 페이징 리뷰 목록(검색x)- admin/reviewList.jsp
//	public List<ReviewDto> page_admin(String type, String key, int startRow, int endRow) throws Exception {
//		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
//
//		String sql = " select * from( "
//							+ "select rownum rn, TMP.* from( "
//								+ "select * from review order by review_no desc "
//							+ " )TMP " 
//						+ ")where rn between ? and ? ";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, startRow);
//		ps.setInt(2, endRow);
//		ResultSet rs = ps.executeQuery();
//		
//		List<ReviewDto> reviewList = new ArrayList<>();
//		while(rs.next()) {
//			ReviewDto reviewDto = new ReviewDto();
//			reviewDto.setReview_no(rs.getInt("review_no"));
//			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
//			
//		}
//		
//
//	}

//리뷰 페이징+리뷰 검색: 제목+ 번호+ 아이디 - /admin/reviewlist.jsp

}
