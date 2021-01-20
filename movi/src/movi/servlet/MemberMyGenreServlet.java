package movi.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MygenreDao;

@WebServlet(urlPatterns = "/member/mygenre.do")
public class MemberMyGenreServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 
			//1. genre를 String 배열로 받아오기
			//2. member_no를 세션에서 받아오기
			req.setCharacterEncoding("UTF-8");
			String[] genre = req.getParameterValues("genre");
			int member_no = (int)req.getSession().getAttribute("loginInfo");//현재는 없는 정보 - 로그인 세션 정보
			//int member_no = 22;
			List<Integer> member_genre = new ArrayList<>();
			for(String genrevalue : genre) {
				member_genre.add(Integer.parseInt(genrevalue));
			}
			
			//처리 : 일단 반복문으로 처리 - 질문해보고 나중에 더 좋은 방법을 알게 되면 수정
			// 1. 선택되었던 선호 장르들을 전부 초기화 시킴
			// 2. 새로 선택된 장르들을 반복문으로 insert 함
			
			MygenreDao mygenreDao = new MygenreDao();
			mygenreDao.clearGenre(member_no);
			for(int i : member_genre) {
				mygenreDao.selectGenre(member_no, i);
			}
			
			//결과 :
			resp.sendRedirect("my.jsp");
			
			/* 확인하기 위해 만들어 둔것 개발 끝나면 지우기
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			for(String genrevalue : genre) {
				resp.getWriter().println("genre String[] : " + genrevalue);
			}
			*/
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
