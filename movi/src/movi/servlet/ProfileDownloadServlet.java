package movi.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.ProfileDao;
import movi.beans.ProfileDto;

@WebServlet(urlPatterns = "/member/profile-download.do")
public class ProfileDownloadServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int member_no = (int)req.getSession().getAttribute("check");
			
			ProfileDao profileDao = new ProfileDao();
			ProfileDto profileDto = profileDao.select(member_no);
			
			String path = "C:/movi/image/profile";
			
			File target = new File(path, profileDto.getProfile_save_name());
			byte[] data = new byte[(int)target.length()];
			FileInputStream in = new FileInputStream(target);
			in.read(data);
			in.close();
			
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(profileDto.getProfile_size()));
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(profileDto.getProfile_save_name(), "UTF-8")+"\"");
			
			resp.getOutputStream().write(data);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
