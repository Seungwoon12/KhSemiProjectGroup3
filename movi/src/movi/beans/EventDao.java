package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class EventDao {

	public static final String USERNAME = "kh43";
	public static final String PASSWORD = "kh43";
	
	public List<EventDto> select() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from event";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		while(rs.next()) {
			EventDto dto = new EventDto();
			dto.setEvent_no(rs.getInt("event_no"));
			dto.setEvent_name(rs.getString("event_name"));
			dto.setEvent_content(rs.getString("event_content"));
			dto.setEvent_start(rs.getDate("event_start"));
			dto.setEvent_end(rs.getDate("event_end"));
			list.add(dto);
		}
		con.close();
		return list;
		}
	
	public List<EventDto> find(int event_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql = "select * from event where event_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		while(rs.next()) {
			EventDto dto = new EventDto();
			dto.setEvent_name(rs.getString("event_name"));
			dto.setEvent_content(rs.getString("event_content"));
			dto.setEvent_start(rs.getDate("event_start"));
			dto.setEvent_end(rs.getDate("event_end"));
			list.add(dto);
		}
		con.close();
		return list;
		}
	}
	
//////////////////////////////////////////////////////////////////////////////////////////	
	// 관리자 모드	
	
	//쿠폰 발급하기 - /admin/couInsert.jsp
	
	//쿠폰 목록- /admin/couList.jsp
	
	//쿠폰 상세보기 - /admin/couDetail.jsp
	
	//쿠폰 삭제하기 - /admin/CouDelete.do
	
	//진행중인 이벤트 목록보기- /admin/EventList.jsp
	
	
///////////////////////////////////////////////////////////////////////////////////	

