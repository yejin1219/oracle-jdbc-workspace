package com.youtube;



import java.util.Scanner;

import com.youtube.controller.YouTubeController;
import com.youtube.model.vo.Category;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;
import com.youtube.model.vo.Video;

public class Application {

	private  Scanner sc = new Scanner(System.in);
	private YouTubeController yc = new YouTubeController();
	public static void main(String[] args) {
        
		Application app = new Application();
//		app.register();
		//app.login();
		//app.addChannel();
		//app.updateChannel();
		
		//app.deleteChannel();
		//app.myChannel();
		app.addVideo();
		
	}
	
	//회원가입
	public void register() {
		
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비밀번호 입력 : ");
		String password = sc.nextLine();
		System.out.print("닉네임 입력 : ");
		String nickname = sc.nextLine();
		
		Member member = new Member();
		member.setMemberId(id);
		member.setMemberPassword(password);
		member.setMemberNickname(nickname);
		
		if(yc.register(member)) {
			System.out.println("회원가입에 성공하셨습니다.");
		}else {
			System.out.println("회원가입에 실패하였습니다.");
		}
	}
	
	///로그인
	public void login() {
		
		System.out.print("아이디 입력 : ");
		String id = sc.nextLine();
		System.out.print("비밀번호 입력 : ");
		String password = sc.nextLine();
		
		
		Member member = yc.login(id, password);
		if(member != null) {
			System.out.println("로그인 성공!");
		}else {
			System.out.println("로그인 실패 ㅜㅜ");
		}
		
	}
	
	public void addChannel() {
		yc.login("111", "1111");
		System.out.print("채널명 : ");
		String title = sc.nextLine();
		Channel channel = new Channel();
		channel.setChanelName(title);
		if(yc.addChannel(channel)) {
			System.out.println("채널이 추가되었습니다.");
		}else {
			System.out.println("채널 추가 실패 ㅜㅜㅜ");
		}
		
		
	}
	
	public void updateChannel() { //UPDATE CHANNEL SET CHANNEL_NAME = ? WHERE CHANNEL_CODE = ?
		yc.login("user1", "1234");
		System.out.print("변경할 채널명 : ");
		String title = sc.nextLine();
	    Channel channel = new Channel();
	    channel.setChanelName(title);
	    if(yc.updateChannel(channel)) {
	    	System.out.println("채널이 변경되었습니다.");
	    }else {
	    	System.out.println("채널이 변경되지 않았습니다.");
	    }
		
		
	}
	
	public void deleteChannel() {
		yc.login("111", "1111");
	
		if(yc.deleteChannel()) {
			System.out.println("채널 삭제 완료!");
		}else {
			System.out.println("채널 삭제 실패");
		}
	}
	
	public void myChannel() {
		yc.login("111", "1111");
		
		Channel channel = yc.myChannel();
		System.out.println(channel.getChannelCode() + "/" +  channel.getMember().getMemberNickname() +"/" + channel.getChanelName() );
	}
	
	
	//비디오 추가

	public void addVideo() {
		yc.login("111", "1111");
		System.out.print("비디오 제목 : ");
		String title = sc.nextLine();
		System.out.print("비디오 URL : ");
		String url = sc.nextLine();
		System.out.print("비디오 썸네일 : ");
		String image = sc.nextLine();
		for(Category category : yc.categoryList()) {
			System.out.println(category);
		}
			
			int categoryNo = 2; // 이건 프론트,, 화면에 보이면 클릭하는 것,, 일단 카테고리2번을 넣어놓음 
			Video video = new Video();
			video.setVideoTitle(title);
			video.setVideoUrl(url);
			video.setVideoPhoto(image);
			Category category = new Category();
			category.setCategoryCode(categoryNo);
			video.setCategory(category);
			
			if(yc.addVideo(video)) {
				System.out.println("비디오 추가 성공!");
			}else {
				System.out.println("비디오 추가 실패ㅜㅜ");
			}
				
	}
}
