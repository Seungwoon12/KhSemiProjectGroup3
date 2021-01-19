package movi.beans;

public class LoveDto {
	private int love_no;
	private int love_movie_no;
	private int love_member_no;
	public LoveDto() {
		super();
	}
	public int getLove_no() {
		return love_no;
	}
	public void setLove_no(int love_no) {
		this.love_no = love_no;
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