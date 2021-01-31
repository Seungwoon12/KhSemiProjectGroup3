package movi.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import movi.beans.MemberDto;
import movi.beans.MemberFindDao;
import movi.util.PwUtil;

@WebServlet(urlPatterns="/member/pw_find.do")
public class Pwfindservlet2 extends HttpServlet {
	 protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			MemberFindDao dao = new MemberFindDao();	    				

		 try {
//				준비: 회원번호
				String member_id = req.getParameter("member_id");
				String member_phone= req.getParameter("member_phone"); 
		
			
				boolean result = dao.Pw_find(member_id,member_phone);
	    		System.out.println(result);

//			출력 : 임시비밀번호 
			 if(result) {
				 
//		              랜덤 문자열 생성
		//	 String pw = PwUtil.generaterandonString(10);
		//	int result1 = dao.changePw(pw,member_id,member_phone);
		//	System.out.println("result1 : " + result1);
		//	System.out.println(pw);
		// SendMail send = new SendMail();
	    //	send.sendMail(member_email, pw);
			req.setAttribute("result", result);
			req.getRequestDispatcher("pw_findresult.jsp").forward(req, resp);
				}
			 else {
				 resp.sendError(404);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		
		}
}
	      

	



