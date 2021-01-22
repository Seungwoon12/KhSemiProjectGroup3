package movi.beans;

import java.sql.Date;

public class MovieDto {
	private int movie_no;
	private int movie_genre_no;
	private String movie_name;
	private Double movie_rate;
	private int movie_time;
	private String movie_age;
	private String movie_country;
	private Date movie_date;
	private String movie_director;
	private String movie_content;
	public MovieDto() {
		super();
	}
	public int getMovie_no() {
		return movie_no;
	}
	public void setMovie_no(int movie_no) {
		this.movie_no = movie_no;
	}
	public int getMovie_genre_no() {
		return movie_genre_no;
	}
	public void setMovie_genre_no(int movie_genre_no) {
		this.movie_genre_no = movie_genre_no;
	}
	public String getMovie_name() {
		return movie_name;
	}
	public void setMovie_name(String movie_name) {
		this.movie_name = movie_name;
	}
	public double getMovie_rate() {
		return movie_rate;
	}
	public void setMovie_rate(double d) {
		this.movie_rate = d;
	}
	public int getMovie_time() {
		return movie_time;
	}
	public void setMovie_time(int movie_time) {
		this.movie_time = movie_time;
	}
	public String getMovie_age() {
		return movie_age;
	}
	public void setMovie_age(String movie_age) {
		this.movie_age = movie_age;
	}
	public String getMovie_country() {
		return movie_country;
	}
	public void setMovie_country(String movie_country) {
		this.movie_country = movie_country;
	}
	public Date getMovie_date() {
		return movie_date;
	}
	public void setMovie_date(Date movie_date) {
		this.movie_date = movie_date;
	}
	public String getMovie_director() {
		return movie_director;
	}
	public void setMovie_director(String movie_director) {
		this.movie_director = movie_director;
	}
	public String getMovie_content() {
		return movie_content;
	}
	public void setMovie_content(String movie_content) {
		this.movie_content = movie_content;
	}
	public int getMovie_audience() {
		return movie_audience;
	}
	public void setMovie_audience(int movie_audience) {
		this.movie_audience = movie_audience;
	}
	private int movie_audience;
	
	//객체의 권한 검사
	//-연령조건
	public boolean age(String movie_age) {
		return this.movie_age != null && this.movie_age.equals(movie_age);
	}
	//-국가조건
	public boolean country(String movie_country) {
		return this.movie_country != null && this.movie_country.equals(movie_country);
	}
	
	
}
