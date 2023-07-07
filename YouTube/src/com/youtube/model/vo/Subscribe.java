package com.youtube.model.vo;

import java.util.Date;

public class Subscribe {

	private int subsCode;
	private Date subsDate;
	private Member memebr;
	private Channel channel;
	public Subscribe() {
		
	}
	public Subscribe(int subsCode, Date subsDate, Member memebr, Channel channel) {
		super();
		this.subsCode = subsCode;
		this.subsDate = subsDate;
		this.memebr = memebr;
		this.channel = channel;
	}
	public int getSubsCode() {
		return subsCode;
	}
	public void setSubsCode(int subsCode) {
		this.subsCode = subsCode;
	}
	public Date getSubsDate() {
		return subsDate;
	}
	public void setSubsDate(Date subsDate) {
		this.subsDate = subsDate;
	}
	public Member getMemebr() {
		return memebr;
	}
	public void setMemebr(Member memebr) {
		this.memebr = memebr;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	@Override
	public String toString() {
		return "Subscribe [subsCode=" + subsCode + ", subsDate=" + subsDate + ", memebr=" + memebr + ", channel="
				+ channel + "]";
	}
	
	
	
	
}
