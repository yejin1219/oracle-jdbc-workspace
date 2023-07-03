package transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import config.ServerInfo;

public class TransactionTest {

	public static void main(String[] args) {

		
		try {
			// 1. 드라이버 로딩
			Class.forName(ServerInfo.DRIVER_NAME);
			
			//2. 데이터베이스 연결
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER,ServerInfo.PASSWORD);
			
			System.out.println("DB Connection..");
			
			// 트랜잭션 시작...!
			conn.setAutoCommit(false); // insert는 되나 커밋은 되지 않음 
			
			//3. PreparedStatement
			String query1 = "INSERT INTO customer(name,age,address) VALUES(?,?,?)";
			PreparedStatement st = conn.prepareStatement(query1);
			
			//4. 쿼리문 실행
			st.setString(1, "김경미");
			st.setInt(2, 16);
			st.setString(3, "서울 강남구");
			
			int result = st.executeUpdate();
			Savepoint savepoint = conn.setSavepoint("A");
			
			String query2 = "SELECT * FROM customer WHERE name =?";
			PreparedStatement st2 = conn.prepareStatement(query2);
			st2.setString(1, "홍수민");
			
			
			ResultSet rs = st2.executeQuery();
			
			if(rs.next()) {
				conn.rollback(savepoint);
				System.out.println("회원정보가 있으므로 rollback!!");
			}else {
				conn.commit();
				System.out.println("회원정보가 없으므로 commit!");
			}
			
			// 트랜잭션 처리를 다시 원래대로 돌려 놓음1
		//	conn.setAutoCommit(true);
			
			//System.out.println(result+ "명 추가!");
			
			if(result ==1) {
				conn.commit(); // 커밋시켜주면 sql에 업데이트 됨
			}else {
				conn.rollback();
			}
			
			st.close();
			conn.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
