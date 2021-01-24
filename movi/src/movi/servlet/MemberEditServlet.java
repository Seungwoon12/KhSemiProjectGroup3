package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

@WebServlet(urlPatterns = "/member/edit.do")
public class MemberEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 - member를 특정할 수 있는 정보 -> 세션에서 받아옴
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no((int)req.getSession().getAttribute("check"));//현재는 없는 정보 - 로그인 세션 정보
			memberDto.setMember_pw(req.getParameter("member_pw")); //확인용 비밀번호
			memberDto.setMember_nick(req.getParameter("member_nick"));
			memberDto.setMember_phone(req.getParameter("member_phone"));
			
			//처리 - 비밀번호를 확인하고 비밀번호가 일치하면 닉네임과 전화번호를 여기 있는 것으로 교체
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.edit(memberDto);
			
			if(result) {
				resp.sendRedirect("my.jsp");
			}
			else {
				resp.sendRedirect("edit.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}