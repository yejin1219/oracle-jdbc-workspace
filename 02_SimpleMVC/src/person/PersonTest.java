package person;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import config.ServerInfo;

public class PersonTest {

	private Properties p = new Properties();
	 
	
	public PersonTest() { // 공통적인 부분 빈 생성자에 넣기, 여러 메서드에 쓸 수 있음
	    try {
		   p.load(new FileInputStream("src/config/jdbc.properties"));  
	   } catch (IOException e) {
	  	e.printStackTrace();
	   }	
    }
	
	// 고정적인 반복 메서드 만들어서 따로 빼기 --디비연결 부분 , 자원반납
	public Connection getConnect() throws SQLException {
		
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
			return conn;
		
	}
	
	//자원반납 부분 2가지 반납 할 경우
	public void closeAll(Connection conn, PreparedStatement st) throws SQLException {
		if(st !=null) st.close();
		if(conn!=null) conn.close();
	}
	
	//자원반납 부분 3가지 반납 할 경우
	public void closeAll(Connection conn, PreparedStatement st, ResultSet rs) throws SQLException {
		if(rs!=null) rs.close();
		closeAll(conn,st);
		
	}
	
	
	// 변동적인 반복.. = 비즈니스 로직 ...DAO(Database Access Object)
	public void addPerson( String name, String address) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("addPerson"));
		st.setString(1,name);
		st.setString(2, address);
		
		int result = st.executeUpdate();
		if(result == 1) {
			System.out.println(name + "님, 추가!");
		}
		
		closeAll(conn,st);
	}
	
	 
	
	
	
	public void removePerson(int id) throws SQLException {
		
			Connection conn = getConnect();
			PreparedStatement st = conn.prepareStatement(p.getProperty("removePerson"));
			st.setInt(1,id);
			
			int result = st.executeUpdate();
			if(result ==1) {
				System.out.println("id" + id +"인 사람 삭제!");
			}
			closeAll(conn,st);
	
	}
	
	
	
	public void updatePerson(int id, String address) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePerson"));
		st.setString(1, address);
		st.setInt(2,id);
		
		int result = st.executeUpdate();
		
		System.out.println("id" + id +"인 사람 주소 변경!");
		
       closeAll(conn,st);
	}
	
	
	
	public void searchAllPerson() throws SQLException {
		
		Connection conn = getConnect();
	    PreparedStatement st = conn.prepareStatement(p.getProperty("searchAllPerson"));
	
	   
	   ResultSet rs = st.executeQuery(); 
	    
	    	  
	 		while(rs.next()) {
	 			String personId = rs.getString("id");
	 			String personName = rs.getString("name");
	 			String personAddress = rs.getString("address");
	 			
	 			
	 		
	 			System.out.println(personId + "/" + personName + "/" + personAddress );
	    	    
	   
	   }
	 		
	 		
	 		closeAll(conn,st,rs);
	 		
	}
	
	public void viewPerson(int id) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("viewPerson"));
		st.setInt(1, id);
		
		 ResultSet rs = st.executeQuery(); // select문에서는 executeQuery(); , 그 외에 것에선 executeUpdate(); 쓰면됨
		                                   // 위에서 setInt를 썼다고 executeUpdate(); 쓰는 것은 아님 
		    
   	  
	 		while(rs.next()) {
	         System.out.println(rs.getString("name") + "/" + rs.getString("address") );
	    	    
	   
	   }
	 		closeAll(conn,st,rs);
	}
	
	
	
	
	public static void main(String[] args) {

		PersonTest pt = new PersonTest();
		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("Driver Loading..");
			
			//pt.addPerson("김강우", "서울");
			//pt.addPerson("고아라","제주도");
			//pt.addPerson("강태주","경기도");
			
			
			//pt.searchAllPerson();
			//pt.removePerson(3); //강태주 삭제
			//pt.updatePerson(1, "제주도");
			pt.viewPerson(1);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	

}
