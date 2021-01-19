package movi.beans;

public class RecommendDto {
	private int recom_no;
	private int recom_movie_no;
	public RecommendDto() {
		super();
	}
	public int getRecom_no() {
		return recom_no;
	}
	public void setRecom_no(int recom_no) {
		this.recom_no = recom_no;
	}
	public int getRecom_movie_no() {
		return recom_movie_no;
	}
	public void setRecom_movie_no(int recom_movie_no) {
		this.recom_movie_no = recom_movie_no;
	}
	public String getRecom_title() {
		return recom_title;
	}
	public void setRecom_title(String recom_title) {
		this.recom_title = recom_title;
	}
	private String recom_title;
}