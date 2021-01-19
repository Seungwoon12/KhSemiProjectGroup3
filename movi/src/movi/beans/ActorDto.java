package movi.beans;

public class ActorDto {
	private int actor_no;
	private int actor_movie_no;
	private String actor_name;
	private String actor_role;
	public ActorDto() {
		super();
	}
	public int getActor_no() {
		return actor_no;
	}
	public void setActor_no(int actor_no) {
		this.actor_no = actor_no;
	}
	public int getActor_movie_no() {
		return actor_movie_no;
	}
	public void setActor_movie_no(int actor_movie_no) {
		this.actor_movie_no = actor_movie_no;
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
}
