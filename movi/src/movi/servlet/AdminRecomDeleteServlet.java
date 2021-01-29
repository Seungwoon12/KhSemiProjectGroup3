package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.RecomAdminDao;

@WebServlet(urlPatterns = "/admin/recomDelete.do")
public class AdminRecomDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String recom_title = req.getParameter("recom_title");
			
			RecomAdminDao recomDao = new RecomAdminDao();
			boolean result = recomDao.delete_amdin(recom_title);
			
			if(result) {
				resp.sendRedirect("recomList.jsp");
			}else {
				resp.sendError(404);//태그가 없음
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
