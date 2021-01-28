package movi.beans;

import java.sql.Date;

public class CouponDto {
private int coupon_no;
private int coupon_event_no;
private String coupon_name;
private Date coupon_start;
private Date coupon_end;
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
public CouponDto() {
	super();
}


}
