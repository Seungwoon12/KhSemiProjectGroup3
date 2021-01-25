package movi.beans;

import java.sql.Date;

public class LoveDto {
	private int love_movie_no;
	private int love_member_no;
	private Date love_date;
	public LoveDto() {
		super();
	}
	public Date getLove_date() {
		return love_date;
	}
	public void setLove_date(Date love_date) {
		this.love_date = love_date;
	}
	public int getLove_movie_no() {
		return love_movie_no;
	}
	public void setLove_movie_no(int love_movie_no) {
		this.love_movie_no = love_movie_no;
	}
	public int getLove_member_no() {
		return love_member_no;
	}
	public void setLove_member_no(int love_member_no) {
		this.love_member_no = love_member_no;
	}
}
