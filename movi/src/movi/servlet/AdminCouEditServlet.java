package movi.servlet;

import java.io.IOException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javafx.scene.chart.PieChart.Data;
import movi.beans.EventAdminDao;
import movi.beans.MemberAdminDao;
import movi.beans.MemberAdminDtoVO;

@WebServlet(urlPatterns = "/admin/couponEdit.do")
public class AdminCouEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:
			req.setCharacterEncoding("UTF-8");
			MemberAdminDtoVO memberDto = new MemberAdminDtoVO();
			memberDto.setEvent_name(req.getParameter("event_name"));
			memberDto.setEvent_coupon(req.getParameter("event_coupon"));
			//Date.valueOf();로 수정하기
			Date start= new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("event_start"));
			Date end= new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("event_end"));
			memberDto.setEvent_start(start);
			memberDto.setEvent_end(end);
			memberDto.setEvent_member_no(Integer.parseInt(req.getParameter("even_member_no")));
			
//			처리:
			EventAdminDao memberDao = new EventAdminDao();
			boolean result =memberDao.couedit_admin(memberDto);
			
//			출력:
			if(result) {
				resp.sendRedirect("memberCouponList.jsp");
			}else {
				resp.sendError(400);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
