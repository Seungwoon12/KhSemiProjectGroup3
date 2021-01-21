package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

	@WebServlet(urlPatterns = "/member/loginaction.jsp")
public class MemberLoginServlet extends HttpServlet{
		@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
				req.setCharacterEncoding("UTF-8");
				MemberDto dto = new MemberDto();
				MemberDao dao = new MemberDao();
				dao.insert(dto);
						
				dto.setMember_id(req.getParameter("member_id"));
				dto.setMember_pw(req.getParameter("member_pw"));
	
				MemberDto result = dao.find(dto.getMember_id());
				boolean login = dao.login(dto);
			
				if(result != null) {
					if(dto.getMember_pw().equals(result.getMember_pw())) {
						login = true;
					}
					else {
						login = false;
					}
				}
				else {
					login = false;
				}
				if(login) {			
					MemberDto m = dao.find(dto.getMember_id());
					req.getSession().setAttribute("check", m.getMember_no());
					req.getSession().setAttribute("auth", m.getMember_auth());					
					resp.sendRedirect("../index.jsp");
			
				}
				else { 
					resp.sendRedirect("login.jsp?error");			
				}
			}
			catch(Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		}
	}

