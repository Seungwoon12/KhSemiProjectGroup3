package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieDao;

@WebServlet(urlPatterns = "/admin/movieDelete.do")
public class AdminMovieDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: 영화 번호
			int movie_no = Integer.parseInt(req.getParameter("movie_no"));
			
//			처리 : 결과값 boolean
			MovieDao movieDao = new MovieDao();
			boolean result = movieDao.delete_admin(movie_no);
			
//			출력 : 영화리스트로 이동
			if(result) {
				resp.sendRedirect("movieList.jsp");
			}else {
				resp.sendError(404);//영화 정보가 없음
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
