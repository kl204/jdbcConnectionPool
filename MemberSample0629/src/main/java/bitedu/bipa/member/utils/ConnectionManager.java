package bitedu.bipa.member.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionManager {
	private static ConnectionManager manager;
	private ConnectionManager() {
		
	}
	
	public static ConnectionManager getInstance() {
		if(manager==null) {
			manager = new ConnectionManager();
		}
		return manager;
	}
	
	// 커넥션 풀링의 getConnection 
	public Connection getConnection() {
		Connection con =null;
		//context는 환경정보다 라고 생각하면 된다
		Context ctx;
		try {
			ctx = (Context)new InitialContext();
			//자바에 있는 컴포넌트를 찾고 싶다.(정해저있는것)
			Context env = (Context) ctx.lookup("java:/comp/env");
			//env에서 아까 등록해놓은 book이라고 하는 키값으로 돼있는 데이터 소스를 달라
			DataSource ds = (DataSource)env.lookup("jdbc/book");
			con=ds.getConnection();
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return con;
	}
	
	public Connection getConnectionOld() {
		Connection con = null;
		String jdbcURL = "jdbc:mysql://localhost:3306/bitedu";
		String driver = "com.mysql.cj.jdbc.Driver";
		String id = "root";
		String pwd = "1234";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(jdbcURL,id,pwd);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
	
	public void closeConnection(ResultSet rs , Statement stmt, Connection con) {
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(con!=null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			con = null;
		}
	}
}
