package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;

@WebServlet(urlPatterns = "/member/delete.do")
public class MemberDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 - member를 특정할 수 있는 정보 -> 세션에서 받아옴
			int member_no = (int)req.getSession().getAttribute("check"); //로그인 세션 정보
			
			//처리 - 멤버 테이블에서 멤버 삭제
			MemberDao memberDao = new MemberDao();
			memberDao.delete(member_no);
			
			req.getSession().removeAttribute("loginInfo");// 세션 만료 -> 로그아웃
			
			resp.sendRedirect("goodbye.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}