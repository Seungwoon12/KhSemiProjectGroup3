package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class ReviewDao {
	
	//게시글 작성
	public void ReviewWrite(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtil.getConnection();
		String sql = "insert into review values(review_seq.nextval, ?, ?, ?, ?, sysdate, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReview_movie_no());
		ps.setInt(2, reviewDto.getReview_writer_no());
		ps.setString(3, reviewDto.getReview_title());
		ps.setString(4, reviewDto.getReview_content());
		ps.execute();
		
		con.close();
		
	}
	
	//게시판 리스트
	public List<ReviewDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection();
		
		String sql = "select * from review order by review_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewDto> list = new ArrayList<>();
		while(rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_movie_no(rs.getInt("review_movie_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_content(rs.getString("review_content"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
			list.add(reviewDto);
		}
		
		con.close();
		
		return list;
	}
	
	//게시글 상세페이지 정보 
	
	
	
//	public List<ReviewDto> select(String type, String key) throws Exception{
//		Connection con = JdbcUtil.getConnection();
//		String sql = "select * from review where instr(#1, ?) > 0 order by review_no desc";
//		sql.replace("#1", type);
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setString(1, key);
//		ResultSet rs = ps.executeQuery();
//		
//		List<ReviewDto> list = new ArrayList<>();
//		while(rs.next()) {
//			ReviewDto reviewDto = new ReviewDto();
//			reviewDto.setReview_no(rs.getInt("review_no"));
//			reviewDto.setReview_movie_no(rs.getInt("review_movie_no"));
//			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
//			reviewDto.setReview_title(rs.getString("review_title"));
//			reviewDto.setReview_content(rs.getString("review_content"));
//			reviewDto.setReview_date(rs.getDate("review_date"));
//			reviewDto.setReview_read(rs.getInt("review_read"));
//			
//			list.add(reviewDto);
//		}
//		
//		con.close();
//		
//		return list;
//	}
	
	
//	페이징 + 댓글개수까지 불러오는 목록 메소드
//	public List<ReviewReplyCountVO> pagingReplyCountList(int startRow, int endRow) throws Exception {
//		Connection con = JdbcUtil.getConnection();
//		
//		String sql = "select * from ("
//						+ "select rownum rn, TMP.* from ("
//							+ "select "
//								+ "REV.review_no, REV.review_movie_no, REV.review_writer_no, REV.review_title, REV.review_content, "
//								+ "REV.review_date, REV.review_read, "
//								+ "count(REP.reply_no) reply_count "
//							+ "from "
//							+ "review REV left outer join reply REP on REV.review_no = REP.reply_origin "
//							+ "group by "
//								+ "REV.review_no, REV.review_movie_no, REV.review_writer_no, REV.review_title, REV.review_content, "
//								+ "REV.review_date, REV.review_read "
//							+ "order by REV.review_no desc "
//						+ ")TMP "
//					+ ") where rn between ? and ?";
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, startRow);
//		ps.setInt(2, endRow);
//		ResultSet rs = ps.executeQuery();
//		
//		List<ReviewReplyCountVO> list = new ArrayList<>();
//		while(rs.next()) {
//			ReviewReplyCountVO vo = new ReviewReplyCountVO();
//			vo.setReview_no(rs.getInt("review_no"));
//			vo.setReview_movie_no(rs.getInt("review_movie_no"));
//			vo.setReview_writer_no(rs.getInt("review_writer_no"));
//			vo.setReview_title(rs.getString("review_title"));
//			vo.setReview_content(rs.getString("review_content"));
//			vo.setReview_date(rs.getDate("review_date"));
//			vo.setReview_read(rs.getInt("review_read"));
//			vo.setReply_count(rs.getInt("reply_count"));
//			list.add(vo);
//		}
//		
//		con.close();
//		
//		return list;
//	}
	
}
