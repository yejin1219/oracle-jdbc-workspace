package com.youtube.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import config.ServerInfo;
import com.youtube.model.vo.Member;
import com.youtube.model.vo.Subscribe;

public class MemberDAO implements MemberDAOTemplate{

	private Properties p= new Properties();
	 
    public MemberDAO() {
    	try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
     
	@Override
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		closeAll(st,conn);
		rs.close();
		
	}

	@Override
	public int register(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("register"));
		
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPassword());
		st.setString(3, member.getMemberNickname());
		
		int result = st.executeUpdate();
		closeAll(st,conn);
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		st.setString(1, id);
		st.setString(2, password);
		ResultSet re = st.executeQuery();
		
		Member member = null;
		while(re.next()) {
			member = new Member();
			member.setMemberId(re.getString("member_id"));
			member.setMemberPassword(re.getString("member_password"));
			member.setMemberNickname(re.getString("member_nickname"));
		}
		closeAll(st,conn);
		
        return member;
	}

	@Override
	public int addSubscribe(Subscribe subscribe) throws SQLException {
		return 0;
	}

	@Override
	public int deleteSubscribe(int subsCode) throws SQLException {
		return 0;
	}

	@Override
	public ArrayList<Subscribe> mySubscribeList(String memberId) throws SQLException {
		return null;
	}

}
