package movi.servlet;

import java.io.Console;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/member/mygenre.do")
public class MemberMyGenreServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String[] genre = req.getParameterValues("genre");
			
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			for(String genrevalue : genre) {
				resp.getWriter().println("genre String[] : " + genrevalue);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
