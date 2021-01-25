package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

@WebServlet(urlPatterns = "/member/editpw.do")
public class MemberEditPwServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 세션(회원번호), 파라미터(현재 비밀번호, 바꿀 비밀번호) - 비밀번호 확인은 같지 않으면 아예 넘어오지 않기 때문에 필요 없다
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_no((int)req.getSession().getAttribute("check")); //로그인 정보 세션 -> 현재 없는 것이므로 나중에 수정 필요
			memberDto.setMember_pw(req.getParameter("original_pw"));
			String member_pw = req.getParameter("member_pw");
			
			//처리 : 
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.editPassword(memberDto, member_pw);
			
			//결과
			if(result) {
				resp.sendRedirect("my.jsp");
			}
			else {
				resp.sendRedirect("editpw.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}