package movi.beans;

import java.sql.Date;

public class MemberAdminDtoVO {
	private int member_no;
	private int member_event_no;
	private String member_id;
	private String member_pw;
	private String member_nick;
	private String member_phone;
	private Date member_date;
	private String member_auth;
	private int mygenre_mygenre_no;
	private int mygenre_no;
	private int genre_no;
	private String genre_name;
	private String event_name;
	private String event_coupon;
	private Date event_start;
	private Date event_end;
	public MemberAdminDtoVO() {
		super();
	}
	
	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
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

	public int getMygenre_mygenre_no() {
		return mygenre_mygenre_no;
	}

	public void setMygenre_mygenre_no(int mygenre_mygenre_no) {
		this.mygenre_mygenre_no = mygenre_mygenre_no;
	}

	public int getMygenre_no() {
		return mygenre_no;
	}

	public void setMygenre_no(int mygenre_no) {
		this.mygenre_no = mygenre_no;
	}

	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public String getGenre_name() {
		return genre_name;
	}

	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public String getEvent_coupon() {
		return event_coupon;
	}

	public void setEvent_coupon(String event_coupon) {
		this.event_coupon = event_coupon;
	}

	public Date getEvent_start() {
		return event_start;
	}

	public void setEvent_start(Date event_start) {
		this.event_start = event_start;
	}

	public Date getEvent_end() {
		return event_end;
	}

	public void setEvent_end(Date event_end) {
		this.event_end = event_end;
	}

	public boolean is(String member_auth) {
		return this.member_auth != null & this.member_auth.equals(member_auth);
	}
	
}
