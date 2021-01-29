package movi.servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieAdminDao;
import movi.beans.MovieDto;

@WebServlet(urlPatterns = "/admin/movieInsert.do")
public class AdminMovieInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: 영화 데이터 받아오기
			req.setCharacterEncoding("UTF-8");
			MovieDto movieDto = new MovieDto();
			movieDto.setMovie_genre_no(Integer.parseInt(req.getParameter("movie_genre_no")));
			movieDto.setMovie_name(req.getParameter("movie_name"));
			movieDto.setMovie_rate(Integer.parseInt(req.getParameter("movie_rate")));
			movieDto.setMovie_time(Integer.parseInt(req.getParameter("movie_time")));
			movieDto.setMovie_age(req.getParameter("movie_age"));
			movieDto.setMovie_country(req.getParameter("movie_country"));
			movieDto.setMovie_date(Date.valueOf(req.getParameter("movie_date")));
			movieDto.setMovie_director(req.getParameter("movie_director"));
			movieDto.setMovie_content(req.getParameter("movie_content"));
			movieDto.setMovie_audience(Integer.parseInt(req.getParameter("movie_audience")));
			
			
//			처리:
			MovieAdminDao movieDao = new MovieAdminDao();
			movieDao.insert_admin(movieDto); 
			
//			출력 : 
				resp.sendRedirect("posterUpTest.jsp?movie_no= "+ movieDto.getMovie_no());	

			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
