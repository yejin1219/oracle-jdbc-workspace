package com.youtube.model.vo;

import java.util.Date;

public class CommentLike {

	private int commlikeCode;
	private Date commlikeDate;
	private int commentCode;
	private Member member;
	public CommentLike() {
		// TODO Auto-generated constructor stub
	}
	public CommentLike(int commlikeCode, Date commlikeDate, int commentCode, Member member) {
		super();
		this.commlikeCode = commlikeCode;
		this.commlikeDate = commlikeDate;
		this.commentCode = commentCode;
		this.member = member;
	}
	public int getCommlikeCode() {
		return commlikeCode;
	}
	public void setCommlikeCode(int commlikeCode) {
		this.commlikeCode = commlikeCode;
	}
	public Date getCommlikeDate() {
		return commlikeDate;
	}
	public void setCommlikeDate(Date commlikeDate) {
		this.commlikeDate = commlikeDate;
	}
	public int getCommentCode() {
		return commentCode;
	}
	public void setCommentCode(int commentCode) {
		this.commentCode = commentCode;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "CommentLike [commlikeCode=" + commlikeCode + ", commlikeDate=" + commlikeDate + ", commentCode="
				+ commentCode + ", member=" + member + "]";
	}
	
	
	
	
}
