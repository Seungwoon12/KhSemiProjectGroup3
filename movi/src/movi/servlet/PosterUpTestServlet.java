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

import movi.beans.PosterTestDao;

@WebServlet(urlPatterns = "/admin/poster-up.do")
public class PosterUpTestServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//파일이 저장될 경로
			String path = "C:/movi/image/poster";
			
			//파일 최댓값 / 이름 안깨지게 / 이름이 중복될 경우 처리할 방식
			int max = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			//만약에 경로가 없으면 경로 생성
			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
			PosterTestDao posterDao = new PosterTestDao();
			
			System.out.println("이름 " + mRequest.getOriginalFileName("poster").split("\\.").length);
			
			String name_part = mRequest.getOriginalFileName("poster").split("\\.")[0];
			
			posterDao.update(Integer.parseInt(name_part), //영화 번호 파일이름을와 매칭
					mRequest.getFilesystemName("poster")); //시스템에 저장되는 파일 이름
			
			resp.sendRedirect("posterUpTest.jsp");//이거는 다시 돌아갈 주소로 지정
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
