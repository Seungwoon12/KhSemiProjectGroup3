package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import movi.util.JdbcUtil;

public class MygenreDao {
	
	public static final String USERNAME="movi";
	public static final String PASSWORD="movi";
	
	public List<MygenreDtoVO> find(int mygenre_member_no) throws Exception{
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		String sql ="select g.genre_name, m.mygenre_member_no " + 
					"from genre G right outer join mygenre M on g.genre_no=m.mygenre_no " + 
					"where m.mygenre_member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, mygenre_member_no);
		ResultSet rs = ps.executeQuery();
		
		List<MygenreDtoVO> list = new ArrayList<>();
		while(rs.next()) {
			MygenreDtoVO dto = new MygenreDtoVO();
			dto.setGenre_name(rs.getString("genre_name"));
			
			list.add(dto);
		}
		con.close();
		return list;
	}

	
	//회원의 선호 장르를 초기화 하는 구문
	public void clearGenre(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete mygenre where mygenre_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ps.execute(); //단순히 모든 선호 장르를 초기화 하므로 알려줄 필요 없음
		
		con.close();
	}
		
	//회원 선호 장르 선택 및 변경
	public void selectGenre(int member_no, int genre_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into mygenre values(mygenre_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		ps.setInt(2, genre_no);
		
		ps.execute();
		
		con.close();
	}
		
	//회원 선호 장르 불러오기 
	/*
	public List<Integer> searchGenre(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select MG.mygenre_no from member M "
				+ "left outer join mygenre MG "
				+ "on M.member_no = MG.mygenre_member_no "
				+ "where M.member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
	} */
}
