package com.youtube.model.vo;

import java.util.Date;

public class VideoLike {
   private int vlikeCode;
   private Date vlikeDate;
   private Video video;
   private Member member;
   
  public VideoLike() {
	
   }

public VideoLike(int vlikeCode, Date vlikeDate, Video video, Member member) {
	super();
	this.vlikeCode = vlikeCode;
	this.vlikeDate = vlikeDate;
	this.video = video;
	this.member = member;
}
  
  
   
   
	
}
