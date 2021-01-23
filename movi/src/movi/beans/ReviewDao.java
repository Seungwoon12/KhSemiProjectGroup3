package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sun.org.apache.bcel.internal.generic.NEWARRAY;

import movi.util.JdbcUtil;

public class ReviewDao {
	
	//데이터베이스 계정정보
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
	//게시글 생성시 review_no에 들어 갈 시퀀스 생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select review_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	
	//게시글 작성
	public void reviewWrite(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into review values(?, ?, ?, ?, ?, sysdate, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReview_no());
		ps.setInt(2, reviewDto.getReview_movie_no());
		ps.setInt(3, reviewDto.getReview_writer_no());
		ps.setString(4, reviewDto.getReview_title());
		ps.setString(5, reviewDto.getReview_content());
		ps.execute();
		
		con.close();
		
	}
	
	
	//게시글 수정
	public boolean reviewEdit(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update review set review_movie_no = ?, review_title = ?, review_content = ? where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReview_movie_no());
		ps.setString(2, reviewDto.getReview_title());
		ps.setString(3, reviewDto.getReview_content());
		ps.setInt(4, reviewDto.getReview_no());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
		
	}
	
	//게시글 삭제
	public void reviewDelete(int review_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "delete review where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ps.execute();
		
		con.close();
	}
	
	
	
	//게시판 리스트
	public List<ReviewDto> select() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
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
	
	// 게시판 페이지당 표시될 목록 개수
	public List<ReviewVO> list(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(" + 
				"select rownum rn, TMP.* from(" + 
				"select "
				+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, count(REP.reply_origin) reply_count "
				+ "from review R inner join member M on R.review_writer_no = M.member_no "
				+ "left outer join Reply REP on R.review_no = REP.reply_origin "
				+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick  "
				+ "order by review_no desc" + 
				")TMP" + 
				") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewVO> list = new ArrayList<>();
		while(rs.next()) {
			ReviewVO reviewVO = new ReviewVO();
			reviewVO.setReview_no(rs.getInt("review_no"));
			reviewVO.setReview_movie_no(rs.getInt("review_movie_no"));
			reviewVO.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewVO.setReview_title(rs.getString("review_title"));
			reviewVO.setReview_content(rs.getString("review_content"));
			reviewVO.setReview_date(rs.getDate("review_date"));
			reviewVO.setReview_read(rs.getInt("review_read"));
			reviewVO.setMember_nick(rs.getString("member_nick"));
			reviewVO.setReply_count(rs.getInt("reply_count"));
			
			list.add(reviewVO);
		}
		
		con.close();
		return list;
	}
	
	
	//검색 일 경우 게시판 페이지당 표시될 목록 개수
	public List<ReviewVO> list(String type, String key, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(" + 
				"select rownum rn, TMP.* from(" + 
				"select "
				+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, count(REP.reply_origin) reply_count "
				+ "from review R inner join member M on R.review_writer_no = M.member_no "
				+ "left outer join Reply REP on R.review_no = REP.reply_origin where instr(#1, ?) > 0 "
				+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick  "
				+ "order by review_no desc" + 
				")TMP" + 
				") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewVO> list = new ArrayList<>();
		while(rs.next()) {
			ReviewVO reviewVO = new ReviewVO();
			reviewVO.setReview_no(rs.getInt("review_no"));
			reviewVO.setReview_movie_no(rs.getInt("review_movie_no"));
			reviewVO.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewVO.setReview_title(rs.getString("review_title"));
			reviewVO.setReview_content(rs.getString("review_content"));
			reviewVO.setReview_date(rs.getDate("review_date"));
			reviewVO.setReview_read(rs.getInt("review_read"));
			reviewVO.setMember_nick(rs.getString("member_nick"));
			reviewVO.setReply_count(rs.getInt("reply_count"));
			
			list.add(reviewVO);
		}
		
		con.close();
		return list;
	}
	
	
	
	
	
	
	//리뷰게시글 상세페이지 정보찾기
	public ReviewDto find(int review_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from review where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ResultSet rs = ps.executeQuery();
		
		ReviewDto reviewDto;
		if(rs.next()) {
			reviewDto = new ReviewDto();
			reviewDto.setReview_no(rs.getInt("review_no"));
			reviewDto.setReview_movie_no(rs.getInt("review_movie_no"));
			reviewDto.setReview_writer_no(rs.getInt("review_writer_no"));
			reviewDto.setReview_title(rs.getString("review_title"));
			reviewDto.setReview_content(rs.getString("review_content"));
			reviewDto.setReview_date(rs.getDate("review_date"));
			reviewDto.setReview_read(rs.getInt("review_read"));
		}
		else {
			reviewDto = null;
		}
		
		con.close();
		
		return reviewDto;
		
	}
	
	//리뷰게시글 총 개수 구하기 (목록일때)
	public int count() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from review";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
	}
	
	//리뷰게시글 총 개수 구하기(검색일때)
	public int count(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from review where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, key);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
	}	
	
	//조회수 증가
	public void plusRead(int review_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update review set review_read = review_read+1 where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ps.execute();
		
		con.close();
	
	}
	
	
	
	
	
	
	
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
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////
	//관리자 모드
	
	
	//리뷰 목록 - /admin/reviewList.jsp
	public List<ReviewDto> select_admin()throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql= "select review_no, review_writer_no, review_title, review_date, review_read " + 
						"from review order by review_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
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

//////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
}