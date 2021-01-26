package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReviewAdminDao;

@WebServlet(urlPatterns = "/admin/reviewDelete.do")
public class AdminReviewDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: 리뷰 번호
			int review_no = Integer.parseInt(req.getParameter("review_no"));
			
//			처리 : 결과값 boolean
			ReviewAdminDao reviewDao = new ReviewAdminDao();
			boolean result = reviewDao.delete_admin(review_no);
			
//			출력 : 
			if(result) {
				resp.sendRedirect("reviewList.jsp");
			}else {
				resp.sendError(400);//리뷰 정보가 없음
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
