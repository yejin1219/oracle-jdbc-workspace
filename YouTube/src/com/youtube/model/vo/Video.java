package com.youtube.model.vo;

import java.util.Date;

public class Video {

	private int videoCode;
	private String videoTitle;
	private String videoPhoto;
	private String videoDesc;
	private Date videoDate;
	private int videoViews;
	private String videoUrl;
	private int categoryCode;
	
	private Category category;
	private Channel channel;
	private Member member;
	public Video() {
		
	}
	public Video(int videoCode, String videoTitle, String videoPhoto, String videoDesc, Date videoDate, int videoViews,
			String videoUrl, int categoryCode, Category category, Channel channel, Member member) {
		super();
		this.videoCode = videoCode;
		this.videoTitle = videoTitle;
		this.videoPhoto = videoPhoto;
		this.videoDesc = videoDesc;
		this.videoDate = videoDate;
		this.videoViews = videoViews;
		this.videoUrl = videoUrl;
		this.categoryCode = categoryCode;
		this.category = category;
		this.channel = channel;
		this.member = member;
	}
	public int getVideoCode() {
		return videoCode;
	}
	public void setVideoCode(int videoCode) {
		this.videoCode = videoCode;
	}
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public String getVideoPhoto() {
		return videoPhoto;
	}
	public void setVideoPhoto(String videoPhoto) {
		this.videoPhoto = videoPhoto;
	}
	public String getVideoDesc() {
		return videoDesc;
	}
	public void setVideoDesc(String videoDesc) {
		this.videoDesc = videoDesc;
	}
	public Date getVideoDate() {
		return videoDate;
	}
	public void setVideoDate(Date videoDate) {
		this.videoDate = videoDate;
	}
	public int getVideoViews() {
		return videoViews;
	}
	public void setVideoViews(int videoViews) {
		this.videoViews = videoViews;
	}
	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	public int getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "Video [videoCode=" + videoCode + ", videoTitle=" + videoTitle + ", videoPhoto=" + videoPhoto
				+ ", videoDesc=" + videoDesc + ", videoDate=" + videoDate + ", videoViews=" + videoViews + ", videoUrl="
				+ videoUrl + ", categoryCode=" + categoryCode + ", category=" + category + ", channel=" + channel
				+ ", member=" + member + "]";
	}
	
	
	
	
}
