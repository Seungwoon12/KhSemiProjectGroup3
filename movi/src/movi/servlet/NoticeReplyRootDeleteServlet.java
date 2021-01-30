package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.NoticeReplyDao;

@WebServlet(urlPatterns="/review/notice_reply_root_delete.do")
public class NoticeReplyRootDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//게시글번호, 페이지번호, 댓글번호받기
			int notice_no = Integer.parseInt(req.getParameter("notice_no"));
			int p = Integer.parseInt(req.getParameter("p"));
			int reply_no = Integer.parseInt(req.getParameter("reply_no"));
			
			//댓글삭제 메소드
			NoticeReplyDao replyDao = new NoticeReplyDao();
			replyDao.deleteRootReply(reply_no); 
			
			resp.sendRedirect("noticeDetail.jsp?notice_no="+notice_no+"&p="+p);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
