package movi.servlet;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

@WebServlet(urlPatterns = "/admin/memberEdit.do")
public class AdminMemberEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:memberDto 데이터 수신
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMember_nick(req.getParameter("member_nick"));
			memberDto.setMember_auth(req.getParameter("member_auth"));
			memberDto.setMember_no(Integer.parseInt(req.getParameter("member_no")));
			
			
//			처리: 데이터 수정 지시
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.edit_admin(memberDto);
			
			
//			출력: 해당 회원의 상세페이지로 이동
			if(result) {
			resp.sendRedirect("memberDetail.jsp?member_no="+memberDto.getMember_no());
			}else {
				resp.sendError(400);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		
		}
	
	}
}
