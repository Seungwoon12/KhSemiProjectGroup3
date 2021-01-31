package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

// 게시판 페이지당 표시될 목록 
public List<ReviewVO> list(int startRow, int endRow) throws Exception {
	Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	String sql = "select * from(" + 
			"select rownum rn, TMP.* from(" + 
			"select "
			+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name, count(REP.reply_origin) reply_count "
			+ "from review R inner join member M on R.review_writer_no = M.member_no "
			+ "left outer join Reply REP on R.review_no = REP.reply_origin and REP.reply_parent >= 0 "
			+ "inner join Movie MO on R.review_movie_no = MO.movie_no "
			+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name "
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
		reviewVO.setMovie_name(rs.getString("movie_name"));
		reviewVO.setReply_count(rs.getInt("reply_count"));
		
		list.add(reviewVO);
	}
	
	con.close();
	return list;
}


//검색 일 경우 게시판 페이지당 표시될 목록 
public List<ReviewVO> list(String type, String key, int startRow, int endRow) throws Exception {
	Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	String sql = "select * from(" + 
			"select rownum rn, TMP.* from(" + 
			"select "
			+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name, count(REP.reply_origin) reply_count "
			+ "from review R inner join member M on R.review_writer_no = M.member_no "
			+ "left outer join Reply REP on R.review_no = REP.reply_origin and REP.reply_parent >= 0 "
			+ "inner join movie MO on R.review_movie_no = MO.movie_no "
			+ "where instr(#1, ?) > 0 "
			+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name "
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
		reviewVO.setMovie_name(rs.getString("movie_name"));
		reviewVO.setReply_count(rs.getInt("reply_count"));
		
		list.add(reviewVO);
	}
	
	con.close();
	return list;
}

//검색 일 경우 게시판 페이지당 표시될 목록 *** type이 reply_writer_no일때 사용*** (목록 출력시 제목옆에 댓글 개수가 검색한 댓글작성자가 작성한 개수만 표시됨)
	public List<ReviewVO> list(String type, int reply_writer_no, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(" + 
				"select rownum rn, TMP.* from(" + 
				"select "
				+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name, count(REP.reply_origin) reply_count "
				+ "from review R inner join member M on R.review_writer_no = M.member_no "
				+ "left outer join Reply REP on R.review_no = REP.reply_origin and REP.reply_parent >= 0 "
				+ "inner join movie MO on R.review_movie_no = MO.movie_no "
				+ "where #1 = ? "
				+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name "
				+ "order by review_no desc" + 
				")TMP" + 
				") where rn between ? and ?";
		
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reply_writer_no);
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
			reviewVO.setMovie_name(rs.getString("movie_name"));
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

//리뷰게시글 총 개수 구하기(검색일때) -> 제목, 내용, 글작성자
public int count(String type, String key) throws Exception {
	Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	String sql = "select count(*) from review R inner join member M on R.review_writer_no = M.member_no and instr(#1, ?) > 0";
	sql = sql.replace("#1", type);
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, key);
	ResultSet rs = ps.executeQuery();
	rs.next();
	
	int count = rs.getInt(1);
	
	con.close();
	return count;
	
}	

//리뷰게시글 총 개수 구하기(검색일때) -> 댓글내용
public int countForReply(String type, String key) throws Exception {
	Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	String sql = "select count(*) from review R inner join reply REP on R.review_no = REP.reply_origin and instr(#1, ?) > 0";
	sql = sql.replace("#1", type);
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, key);
	ResultSet rs = ps.executeQuery();
	rs.next();
	
	int count = rs.getInt(1);
	
	con.close();
	return count;
	
}	

//리뷰게시글 총 개수 구하기(검색일때) -> **댓글작성자라서 distinct로 중복 없애줘야함
	public int countForReplyWriter(int reply_writer_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(distinct reply_origin) from review R inner join reply REP on R.review_no = REP.reply_origin and reply_writer_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reply_writer_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
	}	

//리뷰게시글 총 개수 구하기(검색일때) -> 영화명
	public int countForMovie(String type, String key) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from review R inner join movie M on R.review_movie_no = M.movie_no and instr(#1, ?) > 0";
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






// 카테고리 영화상세에서 들어올때게시판 페이지당 표시될 목록 
	public List<ReviewVO> detailList(int movie_no, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from(" + 
				"select rownum rn, TMP.* from(" + 
				"select "
				+ "R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name, count(REP.reply_origin) reply_count "
				+ "from review R inner join member M on R.review_writer_no = M.member_no "
				+ "left outer join Reply REP on R.review_no = REP.reply_origin and REP.reply_parent >= 0 "
				+ "inner join Movie MO on R.review_movie_no = MO.movie_no and MO.movie_no= ? "
				+ "group by R.review_no, R.review_movie_no, R.review_writer_no, R.review_title, R.review_content, R.review_date, R.review_read, M.member_nick, MO.movie_name "
				+ "order by review_no desc" + 
				")TMP" + 
				") where rn between ? and ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
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
			reviewVO.setMovie_name(rs.getString("movie_name"));
			reviewVO.setReply_count(rs.getInt("reply_count"));
			
			list.add(reviewVO);
		}
		
		con.close();
		return list;
	}
	
	
	//카테고리 영화 상세페이지에서 넘어올때 리뷰 총 개수 구하기
	public int detailCount(int movie_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from review where review_movie_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, movie_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
		
	}
	
	//사용자가 "댓글작성자"를 타입으로 검색했을때 reply_writer_no를 구하기위한 메소드
	public int getWriterNo(String member_nick) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select member_no from member where member_nick = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_nick);
		ResultSet rs = ps.executeQuery();
		
		int reply_writer_no = 0;
		if(rs.next()) {
			reply_writer_no = rs.getInt(1); //member_no라 무조건 1개나옴
		}
		
		con.close();
		return reply_writer_no;
	}
	
	
	
	
//////////////////////// 관리자가 공지 및 필독 게시글 CRUD///////////////////////////////
	
	//관리자 공지 리스트 목록
	public List<NoticeVO> selectNotice() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select N.*, M.member_nick admin_nick, count(reply_origin) reply_count "
				+ "from notice N "
				+ "inner join member M on N.notice_auth_no = M.member_no "
				+ "left outer join notice_Reply NR on N.notice_no = NR.reply_origin "
				+ "group by N.notice_no, N.notice_header, N.notice_title, N.notice_content, N.notice_date, N.notice_read, N.notice_auth_no, M.member_nick "
				+ "order by notice_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<NoticeVO> list = new ArrayList<>();
		while(rs.next()) {
			NoticeVO noticeVO = new NoticeVO();
			noticeVO.setNotice_no(rs.getInt("notice_no"));
			noticeVO.setNotice_header(rs.getString("notice_header"));
			noticeVO.setNotice_title(rs.getString("notice_title"));
			noticeVO.setNotice_content(rs.getString("notice_content"));
			noticeVO.setNotice_date(rs.getDate("notice_date"));
			noticeVO.setNotice_read(rs.getInt("notice_read"));
			noticeVO.setNotice_auth_no(rs.getInt("notice_auth_no"));
			noticeVO.setAdmin_nick(rs.getString("admin_nick"));
			noticeVO.setReply_count(rs.getInt("reply_count"));
			list.add(noticeVO);
		}
		
		con.close();
		return list;
	}
	
	//게시글 생성시 review_no에 들어 갈 시퀀스 생성
	public int noticeSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select notice_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	
	//게시글 작성
	public void noticeWrite(NoticeVO noticeVO) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into notice values(?, ?, ?, ?, sysdate, 0, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, noticeVO.getNotice_no());
		ps.setString(2, noticeVO.getNotice_header());
		ps.setString(3, noticeVO.getNotice_title());
		ps.setString(4, noticeVO.getNotice_content());
		ps.setInt(5, noticeVO.getNotice_auth_no());
		ps.execute();
		
		con.close();
		
	}
	
	//조회수 증가(관리자 공지사항용)
	public void noticePlusRead(int notice_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update notice set notice_read = notice_read+1 where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ps.execute();
		
		con.close();
	
	}
			
	//어드민 게시글 상세페이지
	public NoticeDto noticeFind(int notice_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from notice where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ResultSet rs = ps.executeQuery();
		
		NoticeDto noticeDto;
		if(rs.next()) {
			noticeDto = new NoticeDto();
			noticeDto.setNotice_no(rs.getInt("notice_no"));
			noticeDto.setNotice_header(rs.getString("notice_header"));
			noticeDto.setNotice_title(rs.getString("notice_title"));
			noticeDto.setNotice_content(rs.getString("notice_content"));
			noticeDto.setNotice_date(rs.getDate("notice_date"));
			noticeDto.setNotice_read(rs.getInt("notice_read"));
			noticeDto.setNotice_auth_no(rs.getInt("notice_auth_no"));
		}
		else {
			noticeDto = null;
		}
		
		con.close();
		
		return noticeDto;
		
	}
			
	//공지사항 수정
	public void noticeEdit(NoticeDto noticeDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "update notice set notice_header=?, notice_title=?, notice_content=? where notice_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, noticeDto.getNotice_header());
		ps.setString(2, noticeDto.getNotice_title());
		ps.setString(3, noticeDto.getNotice_content());
		ps.setInt(4, noticeDto.getNotice_no());
		ps.execute();
		
		con.close();
		
	}
	
	//공지사항 삭제
	public void noticeDelete(int notice_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "delete notice where notice_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, notice_no);
		ps.execute();
		
		con.close();
		
	}
		
		
		
		
			
	


}

	

