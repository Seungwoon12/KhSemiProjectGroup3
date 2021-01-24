package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.EventAdminDao;

@WebServlet(urlPatterns = "/admin/couponDelete.do")
public class AdminCouDeleteservlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:쿠폰이 삭제될 회원번호 준비
			int event_member_no = Integer.parseInt(req.getParameter("member_no"));
			
//			처리:
			EventAdminDao eventDao = new EventAdminDao();
			boolean result = eventDao.delete_admin(event_member_no);
			
//			출력:삭제 완료하면 couponList.jsp로 이동
			if(result) {
				resp.sendRedirect("memberCouponList.jsp");
			}else {
				resp.sendError(404);//삭제될 쿠폰이 없음
			}
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
