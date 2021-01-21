package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.util.PwUtil;

@WebServlet(urlPatterns = "/admin/memberPw.do")
public class AdminPwServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: 회원번호
			int member_no = Integer.parseInt(req.getParameter("member_no"));
			
			//랜덤 문자열 비밀번호 생성
			String pw = PwUtil.generaterandonString(10);
			
//			처리 : 비밀번호 변경
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.editPw_admin(member_no, pw);
			
//			출력 : 포워드로 출력
			if(result) {
				req.setAttribute("pw", pw);
				req.getRequestDispatcher("memberPw.jsp").forward(req, resp);
			}else {
				resp.sendError(404); //요청한 페이지를 찾을 수 없을 때!
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
