
package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;


import movi.beans.MemberAdminDao;

@WebServlet(urlPatterns = "/admin/memberDelete.do")
public class AdminMemberDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비:
			int member_no = Integer.parseInt(req.getParameter("member_no"));
			
//			처리:
			MemberAdminDao memberDao = new MemberAdminDao();
			boolean result = memberDao.delete_admin(member_no);
			
//			출력:
			if(result) {
				resp.sendRedirect("memberList.jsp");
			}else {
				resp.sendError(404);//회원 정보가 없음
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	

}
}