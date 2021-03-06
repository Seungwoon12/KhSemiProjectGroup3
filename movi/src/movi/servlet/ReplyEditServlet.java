package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReplyDao;
import movi.beans.ReplyDto;

@WebServlet(urlPatterns="/review/reply_edit.do")
public class ReplyEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//댓글수정내용, 댓글번호 파라미터로 받기,,
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReply_content(req.getParameter("reply_content"));
			replyDto.setReply_no(Integer.parseInt(req.getParameter("reply_no")));
			
			//댓글 수정작업
			ReplyDao replyDao = new ReplyDao();
			replyDao.editReply(replyDto);
			
			//상세페이지로 리다이렉트시 게시글번호와 페이지번호 필요
			int review_no = Integer.parseInt(req.getParameter("review_no"));
			int p = Integer.parseInt(req.getParameter("p"));
			
			resp.sendRedirect("detail.jsp?review_no="+review_no+"&p="+p);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
