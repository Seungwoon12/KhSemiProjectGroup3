package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ReviewDao;

@WebServlet(urlPatterns="/review/notice_delete.do")
public class NoticeDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			//파라미터로 admin_no(관리자 게시글 번호) 받기
			int notice_no = Integer.parseInt(req.getParameter("notice_no"));
			
			//삭제실행
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.noticeDelete(notice_no);
			
			//게시판 1페이지로 이동
			resp.sendRedirect("list.jsp?p=1");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
