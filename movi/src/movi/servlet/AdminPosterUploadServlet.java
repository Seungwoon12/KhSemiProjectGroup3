package movi.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet(urlPatterns = "/admin/poster_upload.do")
public class AdminPosterUploadServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		ServletContext context = getServletContext();
		
		String path = context.getRealPath("upload/profile");
	
		int max = 5 * 1024 * 1024;
		String encoding = "UTF-8";
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		File dir = new File(path);
		dir.mkdirs();
		
		MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
		
		
		
	}
}
