package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ActorAdminDao;
import movi.beans.ActorDto;

@WebServlet(urlPatterns = "/admin/actorEdit.do")
public class AdminActorEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: actor 데이터 
			req.setCharacterEncoding("UTF-8");
			ActorDto actorDto = new ActorDto();
			actorDto.setActor_name(req.getParameter("actor_name"));
			actorDto.setActor_no(Integer.parseInt(req.getParameter("actor_no")));
//			처리: 데이터 수정
			ActorAdminDao actorDao = new ActorAdminDao();
			boolean result = actorDao.edit_admin(actorDto);
			
//			출력 : 배우 상세 페이지로 이동
			if(result) {
				resp.sendRedirect("actorDetail.jsp?actor_no="+actorDto.getActor_no());
			}else {
				resp.sendError(400);//잘못된 요청 구문입니다.
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
