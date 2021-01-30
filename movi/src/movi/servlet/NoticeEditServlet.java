package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.NoticeDto;
import movi.beans.ReviewDao;

@WebServlet(urlPatterns="/review/notice_edit.do")
public class NoticeEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			NoticeDto noticeDto = new NoticeDto();
			//파라미터 값 담기
			noticeDto.setNotice_header(req.getParameter("notice_header"));
			noticeDto.setNotice_title(req.getParameter("notice_title"));
			noticeDto.setNotice_content(req.getParameter("notice_content"));
			noticeDto.setNotice_no(Integer.parseInt(req.getParameter("notice_no")));
			//수정실행
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.noticeEdit(noticeDto);
			
			//수정 후 해당글 상세 페이지로
			resp.sendRedirect("noticeDetail.jsp?notice_no="+noticeDto.getNotice_no());
			
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
