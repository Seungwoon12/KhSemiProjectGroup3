package movi.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcUtil {
	
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "movi", "movi");
		return con;
	}
	
}