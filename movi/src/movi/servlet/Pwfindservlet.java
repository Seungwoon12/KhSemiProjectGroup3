package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import movi.beans.MemberDto;
import movi.beans.MemberFindDao;

@WebServlet(urlPatterns="/member/pw_find.do")
public class Pwfindservlet extends HttpServlet {
	    @Override
	    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	       
	   //    입력 : id, phone	        
	        try {
	        req.setCharacterEncoding("UTF-8");
	        MemberDto dto = new MemberDto(); 
	        
			dto.setMember_nick(req.getParameter("member_id"));
			dto.setMember_phone(req.getParameter("member_phone"));

           // 처리
            MemberFindDao dao = new MemberFindDao();
            
            String member_pw= dao.Pw_find(dto);
            
            //불러오기 
            
            if(member_pw != null) {//결과가 있으면
                resp.sendRedirect("Pw_findresult.jsp?member_pw="+member_pw);

                req.getSession().setAttribute("member_pw", member_pw);
             }
             else {//결과가 없으면
                resp.sendRedirect("Pw_findresult.jsp");
             }
        } catch (Exception e) {
            resp.sendError(500);
            e.printStackTrace();
        } 
    }
}
