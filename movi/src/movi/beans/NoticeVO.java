package movi.beans;

import java.sql.Date;

public class NoticeVO {
	//공지 및 필독 등록용VO
	private int notice_no;
	private String notice_header;
	private String notice_title;
	private String notice_content;
	private Date notice_date;
	private int notice_read;
	private int notice_auth_no;
	private String admin_nick;
	private int reply_count;
	public NoticeVO() {
		super();
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_header() {
		return notice_header;
	}
	public void setNotice_header(String notice_header) {
		this.notice_header = notice_header;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public int getNotice_read() {
		return notice_read;
	}
	public void setNotice_read(int notice_read) {
		this.notice_read = notice_read;
	}
	public int getNotice_auth_no() {
		return notice_auth_no;
	}
	public void setNotice_auth_no(int notice_auth_no) {
		this.notice_auth_no = notice_auth_no;
	}
	public String getAdmin_nick() {
		return admin_nick;
	}
	public void setAdmin_nick(String admin_nick) {
		this.admin_nick = admin_nick;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
	
	
}
