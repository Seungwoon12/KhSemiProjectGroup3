package movi.beans;

import java.sql.Date;

public class MovieDtoVO {
	private int movie_no;
	private int movie_genre_no;
	private String movie_name;
	private Double movie_rate;
	private String movie_age;
	private int movie_time;
	private String movie_country;
	private Date movie_date;
	private String movie_director;
	private String movie_content;
	private int movie_audience;
	private int rank;
	
	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public MovieDtoVO() {
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
	public Double getMovie_rate() {
		return movie_rate;
	}
	public void setMovie_rate(Double movie_rate) {
		this.movie_rate = movie_rate;
	}
	public String getMovie_age() {
		return movie_age;
	}
	public void setMovie_age(String movie_age) {
		this.movie_age = movie_age;
	}
	public int getMovie_time() {
		return movie_time;
	}
	public void setMovie_time(int movie_time) {
		this.movie_time = movie_time;
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
	public int getMlike() {
		return mlike;
	}
	public void setMlike(int mlike) {
		this.mlike = mlike;
	}
	public String getGenre_name() {
		return genre_name;
	}
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	public String getActor_name() {
		return actor_name;
	}
	public void setActor_name(String actor_name) {
		this.actor_name = actor_name;
	}
	public String getActor_role() {
		return actor_role;
	}
	public void setActor_role(String actor_role) {
		this.actor_role = actor_role;
	}
	private int mlike;
	private String genre_name;
	private String actor_name;
	private String actor_role;
	private String movie_poster;

	public String getMovie_poster() {
		return movie_poster;
	}

	public void setMovie_poster(String movie_poster) {
		this.movie_poster = movie_poster;
	}
	private int actor_no;

	public int getActor_no() {
		return actor_no;
	}

	public void setActor_no(int actor_no) {
		this.actor_no = actor_no;
	}
	
	
}