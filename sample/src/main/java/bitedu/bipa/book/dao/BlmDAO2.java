package bitedu.bipa.book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bitedu.bipa.book.utils.ConnectionManager;
import bitedu.bipa.book.vo.BookCopy;

@Repository("blmDAO2")
public class BlmDAO2 {

	
	@Autowired
	private DataSource dataSource;
	
	public boolean insertBook(BookCopy copy){
		boolean flag = false;
		String sql1 = "insert into book_info(book_isbn,book_title,book_author,book_published_date) values (?,?,?,?)";
		String sql2 = "insert into book_copy(book_isbn) values (?)";
		Connection con =null;
		PreparedStatement pstmt =null;
		
		System.out.print("regist isbn : ");
		System.out.println(copy.getIsbn());
		System.out.println(copy.getTitle());
		System.out.println(copy.getAuthor());
		System.out.println(copy.getPublishDate());
		
		try {
			con =dataSource.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, copy.getIsbn());
			pstmt.setString(2, copy.getTitle());
			pstmt.setString(3, copy.getAuthor());
			pstmt.setTimestamp(4, copy.getPublishDate());
			
			int affectedCount = pstmt.executeUpdate();
			
			if(affectedCount>0) {
				pstmt = con.prepareStatement(sql2);
				pstmt.setString(1, copy.getIsbn());
				affectedCount = pstmt.executeUpdate();
				if(affectedCount>0) {
					flag = true;
					con.commit();
					System.out.println("commit");
				}
			} else {
				con.rollback();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				con.rollback();
				System.out.println("rollback");
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			try {
				con.setAutoCommit(true);
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return flag;
	}
	
	public ArrayList<BookCopy> selectBookAll(){
		ArrayList<BookCopy> list = null;
		list = new ArrayList<BookCopy>();
		BookCopy copy = null;
		StringBuilder sb = new StringBuilder("select a.*, b.* from book_info a ");
		sb.append("inner join book_copy b on a.book_isbn=b.book_isbn");
		String sql = sb.toString();
		Connection con =null;
		PreparedStatement pstmt =null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				copy = new BookCopy();
				copy.setIsbn(rs.getString(1));
				copy.setTitle(rs.getString(2));
				copy.setAuthor(rs.getString(3));
				copy.setPublisher(rs.getString(4));
				copy.setPublishDate(rs.getTimestamp(5));
				copy.setBookSeq(rs.getInt(6));
				copy.setBookPosition(rs.getString(7));
				copy.setBookStaus(rs.getString(8));
				list.add(copy);
				System.out.print("list : ");
				System.out.println(list);
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	public boolean deleteBook(int parseInt) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "delete from book_copy where book_seq = ?";
		Connection con =null;
		PreparedStatement pstmt =null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, parseInt);
			int affectedCount = pstmt.executeUpdate();
			if(affectedCount>0) {
				flag = true;
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
	}
	public BookCopy selectBook(int parseInt) {
		// TODO Auto-generated method stub
		BookCopy copy = null;
		StringBuilder sb = new StringBuilder("select a.*, b.* from book_info a ");
		sb.append("inner join book_copy b on a.book_isbn=b.book_isbn ");
		sb.append("where b.book_seq = ?");
		String sql = sb.toString();
		Connection con =null;
		PreparedStatement pstmt =null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, parseInt);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				copy = new BookCopy();
				copy.setIsbn(rs.getString("book_isbn"));
				copy.setTitle(rs.getString("book_title"));
				copy.setAuthor(rs.getString("book_author"));
				copy.setPublishDate(rs.getTimestamp("book_published_date"));
				copy.setBookSeq(rs.getInt("book_seq"));
				copy.setBookPosition(rs.getString("book_position"));
				copy.setBookStaus(rs.getString("book_status"));
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return copy;
	}
	public boolean updateBook(BookCopy copy) {
		// TODO Auto-generated method stub
		boolean flag = false;
		String sql = "update book_info set book_title = ?, book_author=?, book_published_date = ? where book_isbn = ?";
		Connection con =null;
		PreparedStatement pstmt =null;
		
		try {
			dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, copy.getTitle());
			pstmt.setString(2, copy.getAuthor());
			pstmt.setTimestamp(3, copy.getPublishDate());
			//pstmt.setInt(4, copy.getBookSeq());
			pstmt.setString(4, copy.getIsbn());
			int affectedCount = pstmt.executeUpdate();
			if(affectedCount>0) {
				flag = true;
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return flag;
	}
}







