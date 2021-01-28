package movi.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.EventAdminDao;
import movi.beans.EventAdminDtoVO;

@WebServlet(urlPatterns = "/admin/couponInsert.do")
public class AdminCouInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
////			준비:이벤트 데이터 받아오기
//			req.setCharacterEncoding("UTF-8");
//			resp.setCharacterEncoding("UTF-8");
//			EventAdminDtoVO eventDto = new EventAdminDtoVO();
//			eventDto.setEvent_member_no(Integer.parseInt(req.getParameter("event_member_no")));
//			eventDto.setEvent_name(req.getParameter("event_name"));
//			eventDto.setEvent_start(Date.valueOf(req.getParameter("event_start")));
//			eventDto.setEvent_end(Date.valueOf(req.getParameter("event_end")));
//			eventDto.setEvent_content(req.getParameter("event_content"));
//			eventDto.setEvent_coupon(req.getParameter("event_coupon"));
//			
////			처리:
//			EventAdminDao eventDao = new EventAdminDao();
//			eventDao.insert_admin(eventDto);
//			
////			출력: 
//			resp.sendRedirect("memberCouponList.jsp");
//			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
