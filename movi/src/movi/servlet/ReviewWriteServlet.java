package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MovieDto;
import movi.beans.ReviewDao;
import movi.beans.ReviewDto;

@WebServlet(urlPatterns="/review/write.do")
public class ReviewWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//임시로 해보는거,, 영화명으로 영화번호 구하기
//			MovieDao movieDao = new MovieDao();
//			MovieDto movieDto = movieDao.find(req.getParameter("movie_name"));
			
			
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_title(req.getParameter("review_title"));
			reviewDto.setReview_content(req.getParameter("review_content"));
			reviewDto.setReview_movie_no(2);
//			reviewDto.setReview_writer_no(2); // 회원번호
			
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.ReviewWrite(reviewDto);
			
			resp.sendRedirect("list.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
	
}
