package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieAdminDao;
import movi.beans.MovieDto;

@WebServlet(urlPatterns = "/admin/movieEdit.do")
public class AdminMovieEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비 : movieDto 데이터 
			req.setCharacterEncoding("UTF-8");
			MovieDto movieDto = new MovieDto();
			movieDto.setMovie_genre_no(Integer.parseInt(req.getParameter("movie_genre_no")));
			movieDto.setMovie_name(req.getParameter("movie_name"));
			movieDto.setMovie_rate(Integer.parseInt(req.getParameter("movie_rate")));
			movieDto.setMovie_time(Integer.parseInt(req.getParameter("movie_time")));
			movieDto.setMovie_age(req.getParameter("movie_age"));
			movieDto.setMovie_country(req.getParameter("movie_country"));
			movieDto.setMovie_director(req.getParameter("movie_director"));
			movieDto.setMovie_content(req.getParameter("movie_content"));
			movieDto.setMovie_audience(Integer.parseInt(req.getParameter("movie_audience")));
			movieDto.setMovie_no(Integer.parseInt(req.getParameter("movie_no")));
			
//			처리 : 데이터 수정
			MovieAdminDao movieDao = new MovieAdminDao();
			boolean result = movieDao.edit_admin(movieDto);
			
//			출력 : 영화 상세 페이지로 이동
			if(result) {
				resp.sendRedirect("movieDetail.jsp?movie_no="+movieDto.getMovie_no());
			}else {
				resp.sendError(400);//잘못된 요청 구문입니다.
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	
	}
}
