package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import movi.beans.MemberDao;
import movi.beans.MemberDto;

@WebServlet(urlPatterns="/member/idfind.do")
public class Idfindservlet extends HttpServlet {
	    @Override
	    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        // TODO Auto-generated method stub
	        
	   //    입력 : nick ,phone
	        
	        try {
	        req.setCharacterEncoding("UTF-8");
	        MemberDto dto = new MemberDto();
	        
	        String name = req.getParameter("member_nick");
            String phone = req.getParameter("member_phone");
            String birth = req.getParameter("birth");
            
   
         
	        
	    //처리 
	        System.out.println(dto);
	        
	        MemberDao dao = new MemberDao();
	         dao.Memberfind(dto);   
	         
	        }catch (Exception e) {
	            resp.sendError(500);
	            e.printStackTrace();
	        }
	        
	 
	    }
	    }
