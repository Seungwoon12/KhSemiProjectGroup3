package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;

   @WebServlet(urlPatterns = "/member/login.do")
public class MemberLoginServlet extends HttpServlet{
      @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      try {
            req.setCharacterEncoding("UTF-8");
            
            MemberDto dto = new MemberDto();      
            dto.setMember_id(req.getParameter("member_id"));
            dto.setMember_pw(req.getParameter("member_pw"));
            
            //조회
            MemberDao dao = new MemberDao();
            boolean login = dao.login(dto);
   
            
            
            //로그인 성공 실패 리다이렉트
            if(login) {      //로그인성공
               MemberDto m = dao.find(dto.getMember_id());
               req.getSession().setAttribute("check", m.getMember_no()); // 로그인유지
               req.getSession().setAttribute("auth", m.getMember_auth());
         
               resp.sendRedirect("loginfinal.jsp");
         
            }
            else { //로그인 실패
               resp.sendRedirect("loginpage.jsp?error");//에러화면      
            
         }
      }
         catch(Exception e) {
            e.printStackTrace();
            resp.sendError(500);
         }
      }
      
   }
