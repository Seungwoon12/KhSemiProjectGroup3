package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ActorAdminDao;
import movi.beans.ActorDto;

@WebServlet(urlPatterns = "/admin/actorInsert.do")
public class AdminActorInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 배우 데이터 받아오기
			req.setCharacterEncoding("UTF-8");
			ActorDto actorDto = new ActorDto();
			actorDto.setActor_name(req.getParameter("actor_name"));
			
//			처리 : 입력
			ActorAdminDao actorDao = new ActorAdminDao();
			actorDao.insert_admin(actorDto);
			
//			출력 : 배우 리스트
			resp.sendRedirect("actorList.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
