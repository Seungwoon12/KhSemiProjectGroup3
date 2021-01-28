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

@WebServlet(urlPatterns = "/admin/eventEdit.do")
public class AdminEventEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:event데이터 5개
			req.setCharacterEncoding("UTF-8");
			EventAdminDtoVO eventDto = new EventAdminDtoVO();
			eventDto.setEvent_name(req.getParameter("event_name"));
			eventDto.setEvent_start(Date.valueOf(req.getParameter("event_start")));
			eventDto.setEvent_end(Date.valueOf(req.getParameter("event_end")));
			eventDto.setEvent_content(req.getParameter("event_content"));
			eventDto.setEvent_no(Integer.parseInt(req.getParameter("event_no")));
			
//			처리: 데이터 수정 Dao
			EventAdminDao eventDao = new EventAdminDao();
			boolean result = eventDao.edit_admin(eventDto);
			
//			출력:이벤트 상세 페이지로 이동
			if(result) {
				resp.sendRedirect("eventList.jsp");
			}else {
				resp.sendError(400);//잘못된 요청 구문이다.
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
