package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.RecomAdminDao;

@WebServlet(urlPatterns = "/admin/recMoDelete.do")
public class AdminRecMoDelServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int recom_movie_no = Integer.parseInt(req.getParameter("recom_movie_no"));
			String recom_title = req.getParameter("recom_title");
			
			RecomAdminDao recomDao = new RecomAdminDao();
			boolean result = recomDao.delete_movie(recom_movie_no, recom_title);
			
			if(result) {
				resp.sendRedirect("recomList.jsp");
			}else {
				resp.sendError(404);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
