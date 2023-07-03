package transaction;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;

import config.ServerInfo;

public class TransactionTest2 {

	public static void main(String[] args) {

		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
			Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
			System.out.println("DB Connetion...");
			
			
			
			PreparedStatement st = conn.prepareStatement("SELECT * FROM bank");
			ResultSet rs = st.executeQuery();
			System.out.println("==========은행 조회===========");
			
			while(rs.next()) {
				System.out.println(rs.getString("name")+" / "+rs.getString("bankname") + " / " +rs.getInt("balance"));
				
			}
			System.out.println("============================");
			
			/*
			 * 민소 -> 도경 : 50만원씩 이체
			 * 이 관련 모든 쿼리를 하나로 묶는다... 하나의 단일 크랙잭션
			 * setAutocommit(), commit(),rollback().. 등등
			 * 사용해서 민소님의 잔액이 마이너스가 되면 이체 취소가 되어야 함!
			 * */
			
			conn.setAutoCommit(false);
			PreparedStatement st1 = conn.prepareStatement("UPDATE bank SET balance = 500000 + balance WHERE name = ?");
			st1.setString(1, "김도경");

			PreparedStatement st2 = conn.prepareStatement("UPDATE bank SET balance = balance - 500000 WHERE name = ?");
			st2.setString(1, "김민소");
			
			PreparedStatement st3 = conn.prepareStatement("SELECT BALANCE FROM BANK WHERE NAME = ?");
			st3.setString(1, "김민소");
			ResultSet rs1 = st3.executeQuery();
			
			if(rs1.next()) {
				
				if(rs1.getInt("balance") < 0) {
					conn.rollback();
				}else {
					conn.commit();
				}
			}
			
			

			conn.close();
			rs.close();
			rs1.close();
			st.close();
			st1.close();
			st2.close();
			st3.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
