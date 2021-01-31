package movi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ActorAdminDao;
import movi.beans.ActorConDto;
import movi.beans.ActorDto;

@WebServlet(urlPatterns = "/admin/actorConInsert1.do")
public class AdminActorInsertServlet2 extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : 배우 데이터 받아오기
			req.setCharacterEncoding("UTF-8");
			
			int movie_no = Integer.parseInt(req.getParameter("movie_no"));
			int main_actor[] = Arrays.stream(req.getParameterValues("main_actor")).mapToInt(Integer::parseInt).toArray();
			int sub_actor[] = Arrays.stream(req.getParameterValues("sub_actor")).mapToInt(Integer::parseInt).toArray();
			
//			처리 : 입력
			ActorAdminDao actorDao = new ActorAdminDao();
			for(int i=0; i<main_actor.length; i++) {
			actorDao.insert_main_actor(movie_no, main_actor[i]);
			}
			for(int i=0; i<sub_actor.length; i++) {
			actorDao.insert_sub_actor(movie_no, sub_actor[i]);
			}
//			출력 : 배우 리스트
			resp.sendRedirect("movieList.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
