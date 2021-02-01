package movi.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import movi.util.JdbcUtil;

public class ProfileDao {
	public static final String USERNAME="kh43";
	public static final String PASSWORD="kh43";
	
	public void delete(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "delete profile where profile_member_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ps.execute(); //단순히 이미 올려진 프로필 정보를 초기화 하므로 알려줄 필요 없음
		
		con.close();
	}
	
	public void insert(ProfileDto profileDto) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "insert into profile values(profile_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, profileDto.getProfile_upload_name());
		ps.setString(2, profileDto.getProfile_save_name());
		ps.setLong(3, profileDto.getProfile_size());
		ps.setString(4, profileDto.getProfile_type());
		ps.setInt(5, profileDto.getProfile_member_no());
		ps.execute();
		
		con.close();
	}
	
	public ProfileDto select(int member_no) throws Exception {
		Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
		
		String sql = "select * from profile where profile_member_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		ProfileDto profileDto;
		if (rs.next()) {
			profileDto = new ProfileDto();
			profileDto.setProfile_no(rs.getInt("profile_no"));
			profileDto.setProfile_upload_name(rs.getString("profile_upload_name"));
			profileDto.setProfile_save_name(rs.getString("profile_save_name"));
			profileDto.setProfile_size(rs.getLong("profile_size"));
			profileDto.setProfile_type(rs.getString("profile_type"));
			profileDto.setProfile_member_no(rs.getInt("profile_member_no"));
		} else {
			profileDto = null;
		}
		con.close();

		return profileDto;
	}
}
