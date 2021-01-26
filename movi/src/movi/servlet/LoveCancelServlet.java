package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.LoveDao;
import movi.beans.LoveDto;

@WebServlet(urlPatterns = "/category/love_cancel.do")
public class LoveCancelServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			LoveDto loveDto = new LoveDto();
			loveDto.setLove_movie_no(Integer.parseInt(req.getParameter("movie_no")));
			loveDto.setLove_member_no((int)req.getSession().getAttribute("check"));
			
			LoveDao loveDao = new LoveDao();
			loveDao.love_cancel(loveDto);
			
			resp.sendRedirect(req.getContextPath()+"/category/detail.jsp?movie_no=" + req.getParameter("movie_no"));
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
