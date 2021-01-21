package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReviewDao;

@WebServlet(urlPatterns="/review/delete.do")
public class ReviewDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//리뷰 게시글 삭제를 위해 review_no(리뷰번호)가 필요
			int review_no = Integer.parseInt(req.getParameter("review_no"));
			
			//리뷰 게시글 삭제 메소드 실행
			ReviewDao reviewDao = new ReviewDao();	
			reviewDao.reviewDelete(review_no);
			
			
			//삭제 후 사용자를 리뷰 게시판 목록페이지로 보내라
			resp.sendRedirect(req.getContextPath()+"/review/list.jsp");
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
