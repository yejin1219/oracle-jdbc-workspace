package com.kh.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.model.dao.BookDAO;
import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

public class BookController {

	private BookDAO dao = new BookDAO();
	private Member member = new Member();
	
	public ArrayList<Book> printBookAll(){
	
		try {
			
			return dao.printBookAll();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean registerBook(Book book) {
		
		try {
			if(dao.registerBook(book)==1) {
				
				return true;
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return false;
	
	}
	
	public boolean sellBook(int no) {
		
		try {
			if(dao.sellBook(no) ==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean registerMember(Member member) {
		
		try {
			if(dao.registerMember(member) == 1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public Member login(String id, String password) {
		
		try {
			if(dao.login(id, password)!= null) {
				
				member.setMemberNo(dao.login(id, password).getMemberNo());
				member.setMemberId(dao.login(id, password).getMemberId());
				member.setMemberPwd(dao.login(id, password).getMemberPwd());
				member.setMemberName(dao.login(id, password).getMemberName());
				member.setStatus(dao.login(id, password).getStatus());
				member.setEnrollDate(dao.login(id, password).getEnrollDate());
			}
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	public boolean deleteMember() {
		//위에 member 변수 있잖아요
		// 로그인때 담아놓아서 매개변수 따로 안 받음
		 
			  try {
				  if(dao.deleteMember(member.getMemberId(), member.getMemberPwd()) == 1 )
				  return true;
				  }catch (SQLException e) { 
				e.printStackTrace();
			}
		  
           return false; // update 씀 n인경우
	}
	
	public boolean rentBook(int no) {
	  Rent rent = new Rent();
	  Book book = new Book();
	  book.setBkNo(no);
	  rent.setBook(book);
		
		
		try {
			if(dao.rentBook(rent)==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean deleteRent(int no) {
		 
		 try {
			if( dao.deleteRent(no)==1) {
				 return true;
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	public ArrayList<Rent> printRentBook(){
		
		try {
			if(dao.printRentBook(member.getMemberId()) != null) {
				return dao.printRentBook(member.getMemberId());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
}
