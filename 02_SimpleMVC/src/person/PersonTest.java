package person;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	 
	
	
	
	public void removePerson(int id) {
		Properties p = new Properties();
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			
			
			// 2. 디비 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
		
			
			// 3. Statement 객체 생성 - DELETE
			String query = p.getProperty("jdbc.sql.delete");
			PreparedStatement st = conn.prepareStatement(query);
			
			//4. 쿼리문 실행
			st.setInt(1, 2); //?
			
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	
	
	public void updatePerson(int id, String address) {
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			
			
			// 2. 디비 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
			System.out.println("DB Connection..!");
			
			// 3. Statement 객체 생성 - UPDATE
			String query = "UPDATE person SET address = ? WHERE id = ?";
			PreparedStatement st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			st.setInt(1, id);
			st.setString(2, address);
			

			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	
	
	public void searchAllPerson() {
		
		Properties p = new Properties();
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			
            PreparedStatement st1= conn.prepareStatement(query1);
			
			ResultSet rs = st1.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id");
				String deptTitle = rs.getString("dept_title");
				String empName = rs.getString("emp_name");
				String hireDate = rs.getString("hire_date");
			
				System.out.println(empId + "/" + deptTitle + "/" + empName +"/" + hireDate);
			}
			
			
			
			
			
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
	
	
	
	
	
	public void viewPerson(int id) {
		
	}
	
	
	
	
	public static void main(String[] args) {

		PersonTest pt = new PersonTest();
		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("Driver Loading..");
			
			pt.addPerson("김강우", "서울");
			pt.addPerson("고아라","제주도");
			pt.addPerson("강태주","경기도");
			
			pt.searchAllPerson();
			pt.removePerson(3); //강태주 삭제
			pt.updatePerson(1, "제주도");
			pt.viewPerson(1);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	

}
