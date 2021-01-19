package movi.beans;

import java.sql.Date;

public class EventDto {
	private int event_no;
	private int event_member_no;
	private String event_name;
	private Date event_start;
	private Date event_end;
	private String event_content;
	private String event_coupon;
	public EventDto() {
		super();
	}
	public int getEvent_no() {
		return event_no;
	}
	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}
	public int getEvent_member_no() {
		return event_member_no;
	}
	public void setEvent_member_no(int event_member_no) {
		this.event_member_no = event_member_no;
	}
	public String getEvent_name() {
		return event_name;
	}
	public void setEvent_name(String event_name) {
		this.event_name = event_name;
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
	public String getEvent_content() {
		return event_content;
	}
	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}
	public String getEvent_coupon() {
		return event_coupon;
	}
	public void setEvent_coupon(String event_coupon) {
		this.event_coupon = event_coupon;
	}
}
