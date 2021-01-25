package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieDaoSW;
import movi.beans.MovieDto;
import movi.beans.ReviewDao;
import movi.beans.ReviewDto;

@WebServlet(urlPatterns = "/review/edit.do")
public class ReviewEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			MovieDaoSW movieDao = new MovieDaoSW();
			MovieDto movieDto = movieDao.find(req.getParameter("movie_name"));
			
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_no(Integer.parseInt(req.getParameter("review_no")));
			reviewDto.setReview_movie_no(movieDto.getMovie_no());
			reviewDto.setReview_title(req.getParameter("review_title"));
			reviewDto.setReview_content(req.getParameter("review_content"));
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.reviewEdit(reviewDto);
			
			
			//수정 후 상세페이지로 리다이렉트
			int p = Integer.parseInt(req.getParameter("p"));
			resp.sendRedirect("detail.jsp?review_no="+reviewDto.getReview_no()+"&p="+p);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
			
	
	}
}
