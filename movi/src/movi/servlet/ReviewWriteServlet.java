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

@WebServlet(urlPatterns="/review/write.do")
public class ReviewWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//임시로 해보는거,, 영화명으로 영화번호 구하기
			MovieDaoSW movieDao = new MovieDaoSW();
			MovieDto movieDto = movieDao.find(req.getParameter("movie_name"));
			
			
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReview_writer_no((int)req.getSession().getAttribute("check")); // 회원번호 가져오기
			reviewDto.setReview_movie_no(movieDto.getMovie_no()); //영화번호 가져오기
			reviewDto.setReview_title(req.getParameter("review_title"));
			reviewDto.setReview_content(req.getParameter("review_content"));
			
			//시퀀스 생성 후 게시글 등록
			ReviewDao reviewDao = new ReviewDao();
			
			int review_no = reviewDao.getSequence();
			reviewDto.setReview_no(review_no);
				
			reviewDao.reviewWrite(reviewDto);
			
			resp.sendRedirect("detail.jsp?review_no="+review_no+"&p=1");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}