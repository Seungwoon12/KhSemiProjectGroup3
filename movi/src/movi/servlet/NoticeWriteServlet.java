package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.NoticeVO;
import movi.beans.ReviewDao;

@WebServlet(urlPatterns="/review/notice_write.do")
public class NoticeWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//관리자의 게시판 공지사항 등록용 서블릿
			req.setCharacterEncoding("UTF-8");
			
			NoticeVO noticeVO = new NoticeVO();
			noticeVO.setNotice_header(req.getParameter("notice_header"));
			noticeVO.setNotice_title(req.getParameter("notice_title"));
			noticeVO.setNotice_content(req.getParameter("notice_content"));
			noticeVO.setNotice_auth_no((int)req.getSession().getAttribute("check"));
			
			ReviewDao reviewDao = new ReviewDao();
			int notice_no = reviewDao.noticeSequence();
			noticeVO.setNotice_no(notice_no);
			
			reviewDao.noticeWrite(noticeVO);
			
			resp.sendRedirect("noticeDetail.jsp?notice_no="+notice_no+"&p=1"); 
			
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
