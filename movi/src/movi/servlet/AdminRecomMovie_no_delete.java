package movi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieDao;
import movi.beans.RecomAdminDao;
import movi.beans.RecommendDto;

@WebServlet(urlPatterns = "/admin/movie_no_delete.do")
public class AdminRecomMovie_no_delete extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: recom데이터 수신
			req.setCharacterEncoding("UTF-8");
			
			
			int recom_movie_no = Integer.parseInt(req.getParameter("recom_movie_no"));
			int recom_no = Integer.parseInt(req.getParameter("recom_no"));
			
			RecomAdminDao dao = new RecomAdminDao();
			List<RecommendDto> dto = dao.find(recom_no);
			String title = dto.get(0).getRecom_title();
			java.net.URLDecoder.decode(title,"UTF-8");
//			처리
			RecomAdminDao recomDao = new RecomAdminDao();
			boolean result = recomDao.delete_no_admin(recom_movie_no);
			
//			출력: 
			if(result) {
				resp.sendRedirect("recomDetail.jsp?recom_title="+title);
			}else {
				resp.sendError(400);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
