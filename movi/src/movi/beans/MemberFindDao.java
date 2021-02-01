package movi.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import movi.util.JdbcUtil;
import movi.util.PwUtil;
public class MemberFindDao {

//계정 정보를 상수로 저장
		public static final String USERNAME = "kh43";
		public static final String PASSWORD = "kh43";
	
  //아이디 찾기(nick, phone)
		public String Id_find(MemberDto dto) throws Exception {


			  Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);

			  String sql = "select * from member where member_nick=? and member_phone=?";

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
		

//id, email---- 임시비밀번호 발급

 // public int changePw(String pw, String member_id, String member_phone) throws Exception {
		public String changePw(String member_id, String member_phone) throws Exception {
			  Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
			  	  

			 String pw = PwUtil.generaterandonString(10);
			
		     String sql = "update member set member_pw = ? where member_id =? and member_phone= ? ";

		    PreparedStatement ps = con.prepareStatement(sql);
		    ps.setString(1, pw);
		    ps.setString(2, member_id);
		    ps.setString(3, member_phone);
		    
		    ps.execute();
	//		int result = ps.executeUpdate();
			con.close();
			return pw;

		}
		  

//비번 찾기(id, phone)


public boolean Pw_find(String member_id, String member_phone)throws Exception {
	Connection con = JdbcUtil.getConnection(USERNAME, PASSWORD);
	
	String sql = "select * from member where member_id=? and member_phone=?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, member_id);
    ps.setString(2, member_phone);
	ResultSet rs = ps.executeQuery();

boolean result=rs.next();


	con.close();
	
	return result;
	
}


//    PreparedStatement ps = con.prepareStatement(sql);
 //   ps.setString(1, dto.getMember_id());
 //   ps.setString(2, dto.getMember_phone());
 // rs = ps.executeQuery();


 //   String member_pw ;
    
 //if (rs.next()) {
    	
 // 	  member_pw = rs.getString("member_pw");
 //   }
 //   else {
 //   	 member_pw = null;
  //  }
  //con.close();
    
 //   return member_pw;
//
//}




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





