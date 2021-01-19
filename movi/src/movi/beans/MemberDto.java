package movi.beans;

import java.sql.Date;

public class MemberDto {
	private int member_no;
	private int member_genre_no;
	private int member_event_no;
	private String member_id;
	private String member_pw;
	private String member_nick;
	private String member_phone;
	private Date member_date;
	private String member_auth;
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getMember_genre_no() {
		return member_genre_no;
	}
	public void setMember_genre_no(int member_genre_no) {
		this.member_genre_no = member_genre_no;
	}
	public int getMember_event_no() {
		return member_event_no;
	}
	public void setMember_event_no(int member_event_no) {
		this.member_event_no = member_event_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public Date getMember_date() {
		return member_date;
	}
	public void setMember_date(Date member_date) {
		this.member_date = member_date;
	}
	public String getMember_auth() {
		return member_auth;
	}
	public void setMember_auth(String member_auth) {
		this.member_auth = member_auth;
	}
	public MemberDto() {
		super();
	}
}