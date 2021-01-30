package movi.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.RecomAdminDao;
import movi.beans.RecommendDtoVO;

@WebServlet(urlPatterns = "/admin/recomEdit.do")
public class AdminRecomEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
//			준비: recom데이터 수신
			req.setCharacterEncoding("UTF-8");
			RecommendDtoVO recomDto = new RecommendDtoVO();
			recomDto.setRecom_title(req.getParameter("recom_title"));
			recomDto.setRecom_title(req.getParameter("recom_title"));
			
//			처리
			RecomAdminDao recomDao = new RecomAdminDao();
			boolean result = recomDao.edit_admin(recomDto);
			
//			출력: 
			if(result) {
				resp.sendRedirect("recomList.jsp");
			}else {
				resp.sendError(400);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
