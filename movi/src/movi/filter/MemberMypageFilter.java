package movi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
      "/member/my.jsp", "/member/edit.jsp", "/member/editpw.jsp",
      "/member/mygenre.jsp", "/member/mylovemovielist.jsp",
      "/review/detail.jsp", "/review/write.jsp", "/review/detailForDetail.jsp", "/review/noticeDetail.jsp"
})
public class MemberMypageFilter implements Filter {
   @Override
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
         throws IOException, ServletException {
      HttpServletRequest req = (HttpServletRequest)request;
      HttpServletResponse resp = (HttpServletResponse)response;
      
      req.setCharacterEncoding("UTF-8");
         
      boolean isLogin = req.getSession().getAttribute("check") != null;
         
      if(isLogin) {
         chain.doFilter(request, response);
      }
      else {
         resp.sendRedirect(req.getContextPath()+"/member/loginpage.jsp");
      }
   }
}
