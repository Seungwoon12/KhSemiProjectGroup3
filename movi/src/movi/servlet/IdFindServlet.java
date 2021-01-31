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
	    	
	   //    입력 : nick ,phone
	    try {
	        req.setCharacterEncoding("UTF-8");
	        resp.setCharacterEncoding("utf-8");

	        MemberDto dto = new MemberDto(); 

	        dto.setMember_nick(req.getParameter("member_nick"));
			dto.setMember_phone(req.getParameter("member_phone"));

      //처리

			System.out.println(dto);          
			MemberFindDao dao = new MemberFindDao();

            dao.Id_find(dto);


            String member_id= dao.Id_find(dto);

            //결과
            if(member_id != null) {//아이디확인
                resp.sendRedirect("Id_findresult.jsp?member_id="+member_id);

                req.getSession().setAttribute("member_id", member_id);
             }
             else {//아이디없음
                resp.sendRedirect("Id_findresult.jsp");
         
            }
        } catch (Exception e) {
            resp.sendError(500);
             }
          }
      

	    }






