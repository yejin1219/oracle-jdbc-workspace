package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import config.ServerInfo;

public class DBConnectionTest3 {

	
	//public static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	//public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	//public static final String USER = "kh";
	//public static final String PASSWORD = "kh";
	/*
	 * 디비 서버에 대한 정보가 프로그램상에 하드코딩 되어져 있음!
	 * --> 해결책 : 별도의 모듈에 디비서버에 대한 정보를 뽑아내서 별도 처리
	 * 
	 * */
	
	
	
	
	public static void main(String[] args) {

		
		
		
		try {
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			System.out.println("Driver Loading...!");
			
			// 2. 디비 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL,ServerInfo.USER,ServerInfo.PASSWORD);
			System.out.println("DB Connection..!");
			
			// 3. Statement 객체 생성 - UPDATE
			String query = "UPDATE emp SET dept_title = ? WHERE emp_id = ?";
			PreparedStatement st = conn.prepareStatement(query);
			
			// 4. 쿼리문 실행
			st.setString(1, "디자인팀");
			st.setInt(2, 1);
			
			int result = st.executeUpdate();
			System.out.println(result + "명 수정!");
			
			// 결과가 잘 나오는지 확인 - SELECT
			String query1 = "SELECT * FROM emp";
			PreparedStatement st1= conn.prepareStatement(query1);
			
			ResultSet rs = st1.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id");
				String deptTitle = rs.getString("dept_title");
				String empName = rs.getString("emp_name");
				String hireDate = rs.getString("hire_date");
			
				System.out.println(empId + "/" + deptTitle + "/" + empName +"/" + hireDate);
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

}
