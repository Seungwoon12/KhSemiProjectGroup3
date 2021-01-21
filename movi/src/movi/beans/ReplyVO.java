package movi.beans;

import java.sql.Date;

public class ReplyVO {
	private int reply_no;
	private int reply_origin;
	private int reply_writer_no;
	private int reply_root;
	private int reply_parent;
	private int reply_depth;
	private String reply_content;
	private Date reply_time;
	private String member_nick;
	public ReplyVO() {
		super();
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getReply_origin() {
		return reply_origin;
	}
	public void setReply_origin(int reply_origin) {
		this.reply_origin = reply_origin;
	}
	public int getReply_writer_no() {
		return reply_writer_no;
	}
	public void setReply_writer_no(int reply_writer_no) {
		this.reply_writer_no = reply_writer_no;
	}
	public int getReply_root() {
		return reply_root;
	}
	public void setReply_root(int reply_root) {
		this.reply_root = reply_root;
	}
	public int getReply_parent() {
		return reply_parent;
	}
	public void setReply_parent(int reply_parent) {
		this.reply_parent = reply_parent;
	}
	public int getReply_depth() {
		return reply_depth;
	}
	public void setReply_depth(int reply_depth) {
		this.reply_depth = reply_depth;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public Date getReply_time() {
		return reply_time;
	}
	public void setReply_time(Date reply_time) {
		this.reply_time = reply_time;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
}
