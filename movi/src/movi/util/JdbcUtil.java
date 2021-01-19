package movi.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JdbcUtil {
	
	public static Connection getConnection(String username, String password) throws Exception{
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",username,password);
		return con;
	
		//밖에서 JdbcUtil.getConnection("","")으로 불러 올 수 있게하자!
	}
}