package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
	public static Connection con;
	static {
		try {
			Class.forName ("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", 
					"shop", "pass");
			System.out.println("���Ӽ���");
		}catch(Exception e) {
			System.out.println("����:" + e.toString());
		}
	}	
}
