package movi.beans;

import java.sql.Date;

public class MemberDto {
	private int member_no;
	private String member_id;
	private String member_pw;
	private String member_nick;
	private String member_phone;
	private Date member_date;
	private String member_auth;
	private String member_email;
	
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
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
	public boolean is(String member_auth) {
		return this.member_auth != null & this.member_auth.equals(member_auth);
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	@Override
	public String toString() {
		return "Member [member_no=" + member_no + ", member_id=" + member_id + ", member_nick=" + member_nick + ", member_phone="
				+ member_phone + ", member_date=" + member_date + ", member_auth=" + member_auth + ", member_email="
				+ member_email + "]";
	}

	public MemberDto() {
		super();
	}
}