package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class EventAdminDao {
	public static final String USERNAME = "kh43";
	public static final String PASSWORD = "kh43";
	
	//이벤트 목록 개수 -/admin/coupontList.jsp
		public int count_admin() throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = "select count(*) from event ";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			con.close();

			return count;
		}

	//이벤트 검색 개수 -/admin/eventList.jsp
		public int count_admin(String type, String key) throws Exception {
			Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			String sql = " select count(*) from event where instr(#1, ?) >0 ";
			sql = sql.replace("#1", type);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, key);

			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);

			con.close();

			return count;

		}
	
	//진행중인 이벤트 목록보기- /admin/EventList.jsp
	public List<EventAdminDtoVO> Select_admin() throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql ="select event_no, event_name, event_start, event_end from event ";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs= ps.executeQuery();
		
		List<EventAdminDtoVO> eventList = new ArrayList<>();
		while(rs.next()) {
			EventAdminDtoVO eventDto = new EventAdminDtoVO();
			eventDto.setEvent_no(rs.getInt("event_no"));
			eventDto.setEvent_name(rs.getString("event_name"));
			eventDto.setEvent_start(rs.getDate("event_start"));
			eventDto.setEvent_end(rs.getDate("event_end"));
			eventList.add(eventDto);
		}
		con.close();
		
		return eventList;
	}
	
	//페이징+이벤트 검색 : 이벤트 번호 or 이벤트 이름 - /admin/eventList.jsp
	public List<EventAdminDtoVO> page_admin(String type, String key, int startRow, int endRow)throws Exception{
		 Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from ( " + 
						"    select rownum rn, TMP.* from ( " + 
						"        select * from event where instr(#1,?)>0 order by event_no asc " + 
						"    ) TMP " + 
						")where rn between ? and ? ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1 , key);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<EventAdminDtoVO> eventList = new ArrayList<>();
		while(rs.next()) {
			EventAdminDtoVO eventDto = new EventAdminDtoVO();
			eventDto.setEvent_no(rs.getInt("event_no"));
			eventDto.setEvent_name(rs.getString("event_name"));
			eventDto.setEvent_start(rs.getDate("event_start"));
			eventDto.setEvent_end(rs.getDate("event_end"));
			eventList.add(eventDto);
		}
		con.close();
	
		return eventList;
	}
	
	//페이징+ 이벤트 검색 X -/admin/eventList.jsp
	public List<EventAdminDtoVO> page_admin(int startRow, int endRow)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from ( " + 
						"    select rownum rn, TMP.* from ( " + 
						"        select * from event order by event_no asc " + 
						"    )TMP " + 
						")where rn between ? and ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
	
		List<EventAdminDtoVO> eventList = new ArrayList<>();
		while(rs.next()) {
			EventAdminDtoVO eventDto = new EventAdminDtoVO();
			eventDto.setEvent_no(rs.getInt("event_no"));
			eventDto.setEvent_name(rs.getString("event_name"));
			eventDto.setEvent_start(rs.getDate("event_start"));
			eventDto.setEvent_end(rs.getDate("event_end"));
			eventList.add(eventDto);
		}
		con.close();
		
		return eventList;
	}
		
	//진행중인 이벤트 상세보기- /admin/EventDetail.jsp
	public EventAdminDtoVO SelectAll_admin(int event_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select E.* from event E where event_no =? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		ResultSet rs = ps.executeQuery();
		
		EventAdminDtoVO eventDto;
		if(rs.next()) {
			eventDto = new EventAdminDtoVO();
			eventDto.setEvent_no(rs.getInt("event_no"));
			eventDto.setEvent_name(rs.getString("event_name"));
			eventDto.setEvent_start(rs.getDate("event_start"));
			eventDto.setEvent_end(rs.getDate("event_end"));
			eventDto.setEvent_content(rs.getString("event_content"));
		}else {
			eventDto = null;
		}
		con.close();
		
		return eventDto;
	}
	
	//진행중인 이벤트 삭제- /admin/EventDelete.do
	public boolean delete_admin(int event_no)throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete event where event_no =? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, event_no);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ;
		
	}
	
	//진행중인 이벤트 수정 - /admin/EventEdit.jsp
	public boolean edit_admin(EventAdminDtoVO eventDto) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "update event " + 
					"    set event_name=? , event_start = ? , event_end = ? , event_content= ? " + 
					"where event_no = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, eventDto.getEvent_name());
		ps.setDate(2, eventDto.getEvent_start());
		ps.setDate(3, eventDto.getEvent_end());
		ps.setString(4, eventDto.getEvent_content());
		ps.setInt(5, eventDto.getEvent_no());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0 ; 
	}
	
	
	
}
