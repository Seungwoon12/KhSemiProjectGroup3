package movi.beans;

public class MygenreDtoVO {
	private int mygenre_no;
	private int mygenre_member_no;
	private int mygenre_genre_no;
	private String genre_name;
	
	public int getMygenre_no() {
		return mygenre_no;
	}
	public void setMygenre_no(int mygenre_no) {
		this.mygenre_no = mygenre_no;
	}
	public int getMygenre_member_no() {
		return mygenre_member_no;
	}
	public void setMygenre_member_no(int mygenre_member_no) {
		this.mygenre_member_no = mygenre_member_no;
	}
	public int getMygenre_genre_no() {
		return mygenre_genre_no;
	}
	public void setMygenre_genre_no(int mygenre_genre_no) {
		this.mygenre_genre_no = mygenre_genre_no;
	}
	public String getGenre_name() {
		return genre_name;
	}
	public void setGenre_name(String string) {
		this.genre_name = string;
	}
	public MygenreDtoVO() {
		super();
	}
	
}
