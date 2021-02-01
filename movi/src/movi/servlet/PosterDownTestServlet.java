package movi.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.PosterTestDao;

@WebServlet(urlPatterns = "/poster-down.do")
public class PosterDownTestServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int movie_no = Integer.parseInt(req.getParameter("movie_no"));
			
			String path = "D:/upload/kh43/image/poster"; //다운 받아올 경로 지정
			
			PosterTestDao posterTestDao = new PosterTestDao();
			
			File target = new File(path, posterTestDao.find(movie_no)); //경로와 파일 이름 지정
			byte[] data = new byte[(int)target.length()];
			FileInputStream in = new FileInputStream(target);
			in.read(data);
			in.close();
			
			resp.getOutputStream().write(data); //파일 다운 받은 것 전송
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
