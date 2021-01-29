package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.RecomAdminDao;
import movi.beans.RecommendDao;
import movi.beans.RecommendDto;

@WebServlet(urlPatterns = "/admin/recomInsert.do")
public class AdminRecomInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: 32조 추천 태그와 영화번호 입력
			req.setCharacterEncoding("UTF-8");
			resp.setCharacterEncoding("UTF-8");
			RecommendDto recomDto = new RecommendDto();
			recomDto.setRecom_movie_no(Integer.parseInt(req.getParameter("recom_movie_no")));
			recomDto.setRecom_title(req.getParameter("recom_title"));
			
//			처리: 
			RecomAdminDao recomDao = new RecomAdminDao();
			recomDao.insert_admin(recomDto);
			
//			출력:
			resp.sendRedirect("recomList.jsp");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
