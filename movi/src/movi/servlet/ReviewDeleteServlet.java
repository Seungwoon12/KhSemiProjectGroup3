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
			req.setCharacterEncoding("UTF-8");
			
			int review_no = Integer.parseInt(req.getParameter("review_no"));
			
			//삭제 진행
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.reviewDelete(review_no);
			
			resp.sendRedirect("list.jsp");
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
