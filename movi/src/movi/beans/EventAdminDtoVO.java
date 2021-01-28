package movi.beans;

import java.sql.Date;

public class EventAdminDtoVO {
	private int event_no;
	private int event_member_no;
	private String event_name;
	private Date event_start;
	private Date event_end;
	private String event_content;
	private int coupon_no;
	private int coupon_event_no;
	private String coupon_name;
	private Date coupon_start;
	private Date coupon_end;
	
	private int member_coupon_no;
	private int member_event_no;
	private int member_no;
	private String member_id;
	public EventAdminDtoVO() {
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
	public int getCoupon_no() {
		return coupon_no;
	}
	public void setCoupon_no(int coupon_no) {
		this.coupon_no = coupon_no;
	}
	public int getCoupon_event_no() {
		return coupon_event_no;
	}
	public void setCoupon_event_no(int coupon_event_no) {
		this.coupon_event_no = coupon_event_no;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public Date getCoupon_start() {
		return coupon_start;
	}
	public void setCoupon_start(Date coupon_start) {
		this.coupon_start = coupon_start;
	}
	public Date getCoupon_end() {
		return coupon_end;
	}
	public void setCoupon_end(Date coupon_end) {
		this.coupon_end = coupon_end;
	}
	public int getMember_coupon_no() {
		return member_coupon_no;
	}
	public void setMember_coupon_no(int member_coupon_no) {
		this.member_coupon_no = member_coupon_no;
	}
	public int getMember_event_no() {
		return member_event_no;
	}
	public void setMember_event_no(int member_event_no) {
		this.member_event_no = member_event_no;
	}
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

}
