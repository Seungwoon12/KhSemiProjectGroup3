package movi.beans;

import java.sql.Date;

public class ReviewVO {
	private int review_no;
	private int review_movie_no;
	private int review_writer_no;
	private String review_title;
	private String review_content;
	private Date review_date;
	private int review_read;
	private String member_nick;
	private int reply_count;
	public ReviewVO() {
		super();
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public int getReview_movie_no() {
		return review_movie_no;
	}
	public void setReview_movie_no(int review_movie_no) {
		this.review_movie_no = review_movie_no;
	}
	public int getReview_writer_no() {
		return review_writer_no;
	}
	public void setReview_writer_no(int review_writer_no) {
		this.review_writer_no = review_writer_no;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	public int getReview_read() {
		return review_read;
	}
	public void setReview_read(int review_read) {
		this.review_read = review_read;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
	

}
