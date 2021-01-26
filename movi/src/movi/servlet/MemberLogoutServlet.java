package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = "/member/logout.do")
public class MemberLogoutServlet extends HttpServlet{
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.getSession().removeAttribute("check");
         req.getSession().removeAttribute("auth");
         req.getSession().invalidate();
         
           resp.sendRedirect("../index.jsp");
   
      }
      catch(Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}