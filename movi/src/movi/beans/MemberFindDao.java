package movi.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import movi.util.JdbcUtil;
public class MemberFindDao {

//계정 정보를 상수로 저장
		public static final String USERNAME = "movi";
		public static final String PASSWORD = "movi";
	
  //아이디 찾기(nick, phone)
  public String Id_find(MemberDto dto) throws Exception {
	  Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	  
	  String sql = "select member_id from member where member_nick=? and member_phone=?";

      PreparedStatement ps = con.prepareStatement(sql);
      ps.setString(1, dto.getMember_nick());
      ps.setString(2, dto.getMember_phone());
      ResultSet rs = ps.executeQuery();

	String member_id ;
	
		if(rs.next()) {
			
			member_id = rs.getString("member_id");
	
		}
		else {
			 member_id =null;
		}
		con.close();
		
	    return member_id;
  }

//비밀번호 찾기 
public String Pw_find(MemberDto dto) throws Exception {
	  Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

    String sql = "select * from member where member_id=? and member_phone=?";
    
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, dto.getMember_id());
    ps.setString(2, dto.getMember_phone());
    ResultSet rs = ps.executeQuery();


    String member_pw ;
    
    if (rs.next()) {
    	
  	  member_pw = rs.getString("member_pw");
    }
    else {
    	 member_pw = null;
    }
    con.close();
    
    return member_pw;

}




//비밀번호 변경---임시비밀번호

public String changPw(MemberDto dto) throws Exception {
    
    Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
       
  
    String sql = "update member set member_pw = ? where member_id = ? and  member_phone = ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, dto.getMember_id());
    ps.setString(2, dto.getMember_phone());
    
    ResultSet rs = ps.executeQuery();
    
    String member_pw ;

  
		String pwString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*";
		StringBuffer buffer = new StringBuffer();
		Random r = new Random();
		
		for(int i=0; i<10; i++) {
			int index = r.nextInt(pwString.length());
			buffer.append(pwString.charAt(index));
		}
		
		String pw = buffer.toString();
		
con.close();

 return pw;
}
}




