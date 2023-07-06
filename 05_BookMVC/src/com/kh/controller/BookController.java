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
			member = dao.login(id, password);
		} catch (SQLException e1) {
			e1.printStackTrace();
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

		
		try {
			if(dao.rentBook(new Rent(new Member(member.getMemberNo()), new Book(no)))==1) {
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
			
				return dao.printRentBook(member.getMemberId());
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
}
