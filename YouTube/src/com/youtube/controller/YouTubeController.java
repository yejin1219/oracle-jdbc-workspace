package com.youtube.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.youtube.model.dao.ChannelDAO;
import com.youtube.model.dao.MemberDAO;
import com.youtube.model.dao.VideoDAO;
import com.youtube.model.vo.Category;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;
import com.youtube.model.vo.Video;

public class YouTubeController {

	private Member member = new Member();
	private Channel channel = new Channel();
	
	
	private MemberDAO memberDao = new MemberDAO();
	private ChannelDAO channelDao = new ChannelDAO();
	private VideoDAO videoDao = new VideoDAO();
	
	
	public boolean register(Member member) {
		
		try {
			if(memberDao.register(member)==1) return true;
		} catch (SQLException e) {
			return false;
		}
		return false;
	}
	
	public Member login(String id, String password) {
		
		try {
			member = memberDao.login(id, password);
			if(member!= null) return member;
			else return null;
		} catch (SQLException e) {
			System.out.println("아이디 또는 비밀번호가 틀렸습니다.");
		}
		return member;
	}
	
	public boolean addChannel(Channel channel) {
		channel.setMember(member);
		try {
			if(channelDao.addChannel(channel) ==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} return false;
	}
	
	
	public boolean updateChannel(Channel channel) {
	
		myChannel();
		try {
			channel.setChannelCode(this.channel.getChannelCode());
			if(channelDao.updateChannel(channel) ==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} return false;
	}
	
	public boolean deleteChannel() {
		myChannel();
		try {
			if(channelDao.deleteChannel(channel.getChannelCode())==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} return false;
		
		
	}
	
	public Channel myChannel() {
		
		try {
			System.out.println(member);
			channel = channelDao.myChannel(member.getMemberId());
			return channel;
		} catch (SQLException e) {
			e.printStackTrace();
		} return null;
		
			
	}
	
	public ArrayList<Category> categoryList(){
		try {
			return videoDao.categoryList();
		} catch (SQLException e) {
			e.printStackTrace();
		} return null;
		
	}
	
	public boolean addVideo(Video video) {
		   myChannel();
			video.setChannel(this.channel);
			video.setMember(this.member);
			
			try {
				if(videoDao.addVideo(video) == 1) return true;
			} catch (SQLException e) {
				e.printStackTrace();
			} return false;
			
		}

	
	public ArrayList<Video> videoAllList() {
		try {
			return videoDao.videoAllList();
		} catch (SQLException e) {
			e.printStackTrace();
		} return null;
	}
	
	
	
	
	
	
	
	public boolean updateVideo(Video video) {//
		myChannel();
		video.setChannel(this.channel);
		video.setMember(this.member);
		try {
			if(videoDao.updateVideo(video) == 1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} return false;
	}
	
	
	
}




