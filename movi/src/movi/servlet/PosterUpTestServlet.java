package movi.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import movi.beans.MovieDtoVO;
import movi.beans.PosterTestDao;

@WebServlet(urlPatterns = "/admin/poster-up.do")
public class PosterUpTestServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//파일이 저장될 경로
			String path = "D:/upload/kh43/image/poster";
			
			//파일 최댓값 / 이름 안깨지게 / 이름이 중복될 경우 처리할 방식
			int max = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			//만약에 경로가 없으면 경로 생성
			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			PosterTestDao posterDao = new PosterTestDao();
			//update movie set movie_poster = '87.jpg' where movie_no =87  ;
			MovieDtoVO movieDto = new MovieDtoVO();
			//movieDto.setMovie_poster(req.getParameter("movie_poster")); //이렇게 하면 안올라감
			//movieDto.setMovie_no(Integer.parseInt(req.getParameter("movie_no")));
			
			//System.out.println(mRequest.getParameter("movie_no"));
			//System.out.println(mRequest.getFilesystemName("movie_poster"));
			
			posterDao.update(Integer.parseInt(mRequest.getParameter("movie_no")),
					mRequest.getFilesystemName("movie_poster")); //시스템에 저장되는 파일 이름
			
			
			resp.sendRedirect(req.getContextPath()+"/admin/movieList.jsp");//이거는 다시 돌아갈 주소로 지정
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
