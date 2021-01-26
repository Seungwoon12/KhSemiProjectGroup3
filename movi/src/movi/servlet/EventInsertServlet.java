package movi.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.CouponDao;
import movi.beans.CouponDto;
import movi.beans.MemberCouponDao;
import movi.beans.MemberCouponDto;

@WebServlet("/event/event.do")
public class EventInsertServlet extends HttpServlet{
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
	req.setCharacterEncoding("utf-8");
	
	MemberCouponDto dto = new MemberCouponDto();
	int coupon_no = Integer.parseInt(req.getParameter("coupon_no"));
	dto.setEvent_member_no((int)req.getSession().getAttribute("check"));
	dto.setMember_coupon_no(coupon_no);
	dto.setMember_event_no(Integer.parseInt(req.getParameter("event_no")));
	
	MemberCouponDao mcDao = new MemberCouponDao();
	mcDao.insert(dto);
	
	CouponDao cDao  = new CouponDao();
	CouponDto cDto = cDao.find(coupon_no);
	
	String PageUrl = "/movi/event/detail.jsp?event_no="+dto.getMember_event_no();
	resp.setContentType("text/html; charset=UTF-8"); 
	PrintWriter writer = resp.getWriter(); 
	writer.println("<script>alert('"+cDto.getCoupon_name()+"'); location.href='"+PageUrl+"';</script>"); writer.close();
	}
	catch(Exception e) {
		resp.setContentType("text/html; charset=UTF-8"); 
		PrintWriter writer = resp.getWriter(); 
		writer.println("<script>alert('이미 참여하셨습니다!'); location.href='/movi/event/main.jsp';</script>"); writer.close();

		//resp.sendRedirect("/movi/event/event_fail.jsp");
	}
}
}
