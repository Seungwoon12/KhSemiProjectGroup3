package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReplyDao;
import movi.beans.ReplyDto;

@WebServlet(urlPatterns="/review/reply_write.do")
public class ReplyWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReply_origin(Integer.parseInt(req.getParameter("reply_origin")));
			replyDto.setReply_writer_no(Integer.parseInt(req.getParameter("reply_writer_no")));
			replyDto.setReply_content(req.getParameter("reply_content"));
			
			
			//댓글번호 시퀀스 생성 후 댓글 등록
			ReplyDao replyDao = new ReplyDao();
			int reply_no = replyDao.getSequence();
			replyDto.setReply_no(reply_no);
			replyDto.setReply_root(reply_no); //댓글 등록시에는 reply_no와 reply_root값이 동일하다.
			
			replyDao.writeReply(replyDto); // 댓글등록
			
			//댓글을 작성한 게시글 상세페이지로 이동
			int p = Integer.parseInt(req.getParameter("p"));
			resp.sendRedirect("detail.jsp?review_no="+replyDto.getReply_origin()+"&p="+p);
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
			
		}
		
		
	
	}
}
