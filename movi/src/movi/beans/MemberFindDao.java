package movi.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import movi.util.JdbcUtil;
public class MemberFindDao {
//  연결만 처리해서 반환하는 메소드
  public Connection getConnection() throws Exception {
      Class.forName("oracle.jdbc.OracleDriver");
      Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "home", "home");
      return con;
  }
  
  //아이디 찾기
  public String Id_find(MemberDto dto) throws Exception {
	  Connection con = getConnection();
	    String member_id = null;

	  String sql = "select * from member where member_nick=?";
		PreparedStatement ps = con.prepareStatement(sql);
		  ps.setString(1, dto.getMember_nick());
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()) {
			
			member_id = rs.getString("member_id");
	
		}
		
		con.close();
	    return member_id;
  }




//비밀번호 찾기 --->임시비밀번호
public String Pw_find(MemberDto dto) throws Exception {
    Connection con = getConnection();

    String sql = "select * from member where member_id=? and member_phone=?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, dto.getMember_id());
    ps.setString(2, dto.getMember_phone());
    ResultSet rs = ps.executeQuery();


    String member_pw = null;
    if (rs.next()) {
  	  member_pw = rs.getString("member_pw");
    }
    con.close();
    
    return member_pw;
}
}
