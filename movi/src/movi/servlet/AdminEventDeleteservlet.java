package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.EventAdminDao;

@WebServlet(urlPatterns = "/admin/eventDelete.do")
public class AdminEventDeleteservlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:이벤트 번호
			int event_no = Integer.parseInt(req.getParameter("event_no"));
			
//			처리:결과값 boolean
			EventAdminDao eventDao = new EventAdminDao();
			boolean result = eventDao.delete_admin(event_no);
			
//			출력:
			if(result) {
				resp.sendRedirect("eventList.jsp");
			}else {
				resp.sendError(404);//이벤트 정보가 없음
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
