package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReplyDao;

@WebServlet(urlPatterns="/review/reply_delete.do")
public class ReplyDeleteServlet extends HttpServlet {
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				req.setCharacterEncoding("UTF-8");
				
				//게시글번호, 페이지번호, 댓글번호받기
				int review_no = Integer.parseInt(req.getParameter("review_no"));
				int p = Integer.parseInt(req.getParameter("p"));
				int reply_no = Integer.parseInt(req.getParameter("reply_no"));
				
				//댓글삭제 메소드
				ReplyDao replyDao = new ReplyDao();
				replyDao.deleteReply(reply_no);
				
				resp.sendRedirect("detail.jsp?review_no="+review_no+"&p="+p);
				
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		
		}
}
