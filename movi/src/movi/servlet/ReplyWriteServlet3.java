package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReplyDao;
import movi.beans.ReplyDto;

@WebServlet(urlPatterns="/review/reply3_write.do")
public class ReplyWriteServlet3 extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//대대댓글 서블릿

			req.setCharacterEncoding("UTF-8");
			
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReply_writer_no(Integer.parseInt(req.getParameter("reply_writer_no")));
			replyDto.setReply_origin(Integer.parseInt(req.getParameter("reply_origin")));
			replyDto.setReply_root(Integer.parseInt(req.getParameter("reply_root")));
			replyDto.setReply_parent(Integer.parseInt(req.getParameter("reply_parent")));
			replyDto.setReply_content(req.getParameter("reply_content"));
			
			
			//댓글번호 시퀀스 생성후 대대댓글 등록
			ReplyDao replyDao = new ReplyDao();
			int reply_no = replyDao.getSequence();
			replyDto.setReply_no(reply_no);
			
			//대대댓글 등록
			replyDao.writeReply3(replyDto);
			
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