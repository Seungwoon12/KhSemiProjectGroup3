package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ActorAdminDao;

@WebServlet(urlPatterns = "/admin/actorDelete.do")
public class AdminActordeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 
			int actor_no = Integer.parseInt(req.getParameter("actor_no"));
			
//			처리 : 
			ActorAdminDao actorDao = new ActorAdminDao();
			boolean result = actorDao.delete_admin(actor_no);
			
//			출력 : 
			if(result) {
				resp.sendRedirect("actorList.jsp");
			}else {
				resp.sendError(404);//배우 정보가 없음
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
