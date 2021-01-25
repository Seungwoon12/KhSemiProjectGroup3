package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import movi.beans.MemberDto;
import movi.beans.MemberFindDao;

@WebServlet(urlPatterns="/member/Id_find.do")
public class IdFindServlet extends HttpServlet {
	    @Override
	    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    req.setCharacterEncoding("UTF-8");

	   //    입력 : nick ,phone
	    try {
	        req.setCharacterEncoding("UTF-8");
	        MemberDto dto = new MemberDto(); 
	        
			dto.setMember_nick(req.getParameter("member_nick"));

           
            MemberFindDao dao = new MemberFindDao();
            String member_id= dao.Id_find(dto);
            
            if (!member_id.isEmpty()) {
                resp.sendRedirect("Id_findresult.jsp");
            } else {
                resp.sendRedirect("Id_findresult.jsp?Id=");
            }
        } catch (Exception e) {
            resp.sendError(500);
            e.printStackTrace();
        } 
	    }
}
	
