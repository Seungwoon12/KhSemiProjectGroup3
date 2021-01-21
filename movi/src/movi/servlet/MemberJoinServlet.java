package movi.servlet;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

@WebServlet(urlPatterns = "/member/join.do")
public class MemberJoinServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			MemberDto dto = new MemberDto();
			dto.setMember_id(req.getParameter("member_id"));
			dto.setMember_pw(req.getParameter("member_pw"));
			dto.setMember_nick(req.getParameter("member_nick"));
			dto.setMember_phone(req.getParameter("member_phone"));
	

			MemberDao dao = new MemberDao();
			dao.insert(dto);
			
			resp.sendRedirect("loginsuccess.jsp");
		}
//		아이디/닉네임이 중복 예외 --> 실패 페이지로 이동
		catch(SQLIntegrityConstraintViolationException e) {
			resp.sendRedirect("loginfail.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}