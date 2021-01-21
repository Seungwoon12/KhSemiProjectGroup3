package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class ReplyDao {
	public static final String USERNAME = "movi";
	public static final String PASSWORD = "movi";
	
	//시퀀스 메소드로 reply_no(댓글번호)에 들어 갈 번호를 생성해준다.
	public int getSequence() throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select reply_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	//댓글 등록 메소드 
	public void writeReply(ReplyDto replyDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "insert into reply values(?, ?, ?, ?, 0, 0, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, replyDto.getReply_no());
		ps.setInt(2, replyDto.getReply_origin());
		ps.setInt(3, replyDto.getReply_writer_no());
		ps.setInt(4, replyDto.getReply_root());
		ps.setString(5, replyDto.getReply_content());
		ps.execute();
		
		con.close();
	}
	
	
	//댓글개수
	public int getCount(int review_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select count(*) from reply where reply_origin = ?";
		PreparedStatement ps  = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	
	
	//댓글 목록 출력 메소드
	public List<ReplyVO> selectReply(int review_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select R.*, M.member_nick from reply R inner join member M on R.reply_writer_no = M.member_no where reply_origin = ? order by reply_no";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, review_no);
		ResultSet rs = ps.executeQuery();
		
		List<ReplyVO> list = new ArrayList<>();
		while(rs.next()) {
			ReplyVO replyVO = new ReplyVO();
			replyVO.setReply_no(rs.getInt("reply_no"));
			replyVO.setReply_origin(rs.getInt("reply_origin"));
			replyVO.setReply_writer_no(rs.getInt("reply_writer_no"));
			replyVO.setReply_root(rs.getInt("reply_root"));
			replyVO.setReply_parent(rs.getInt("reply_parent"));
			replyVO.setReply_depth(rs.getInt("reply_depth"));
			replyVO.setReply_content(rs.getString("reply_content"));
			replyVO.setReply_time(rs.getDate("reply_time"));
			replyVO.setMember_nick(rs.getString("member_nick"));
			
			list.add(replyVO);
		}
		
		con.close();
		
		return list;
	}
			
}
