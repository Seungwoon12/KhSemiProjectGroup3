package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReplyDao;
import movi.beans.ReplyDto;

@WebServlet(urlPatterns="/review/reply_write2.do")
public class ReplyWriteServlet2 extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 대댓글 서블릿
			
			req.setCharacterEncoding("UTF-8");
			
			ReplyDto replyDto = new ReplyDto();
			replyDto.setReply_origin(Integer.parseInt(req.getParameter("reply_origin")));
			replyDto.setReply_writer_no(Integer.parseInt(req.getParameter("reply_writer_no")));
			replyDto.setReply_content(req.getParameter("reply_content"));
			
			// 대댓글의 root와 parent에는 댓글의 reply_no 값이 들어가야한다. 여기서 댓글의 reply_no는 reply_root라는
			// 파라미터명으로 받아옴
			int reply_root = Integer.parseInt(req.getParameter("reply_root"));
			replyDto.setReply_root(reply_root); 
			//대댓글의 부모댓글은 댓글임
			replyDto.setReply_parent(reply_root);
			
			//댓글번호 시퀀스 생성 후 댓글 등록
			ReplyDao replyDao = new ReplyDao();
			int reply_no = replyDao.getSequence();
			replyDto.setReply_no(reply_no);
			
			replyDao.writeReply2(replyDto); // 대댓글등록
			
			//댓글을 작성한 게시글 상세페이지로 이동
			resp.sendRedirect("detail.jsp?review_no="+replyDto.getReply_origin());
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
