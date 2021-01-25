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

import movi.beans.ProfileDao;
import movi.beans.ProfileDto;

@WebServlet(urlPatterns = "/member/profile-enroll.do")
public class ProfileUploadServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String path = req.getContextPath() + "/image/profile";
			
			int max = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			File dir = new File(path);
			dir.mkdirs();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, max, encoding, policy);
			
//			일단 기존의 프로필이 존재한다면 그 프로필 파일을 지워준다
			ProfileDao profileDao = new ProfileDao();
			profileDao.delete((int)req.getSession().getAttribute("check"));
			
//			profileDto를 생성해서 DB에 담을 정보를 지정
			ProfileDto profileDto = new ProfileDto();
			
			profileDto.setProfile_save_name(mRequest.getFilesystemName("profile"));
			profileDto.setProfile_upload_name(mRequest.getOriginalFileName("profile"));
			
			File target = mRequest.getFile("profile");
			profileDto.setProfile_size(target.length());
			profileDto.setProfile_type(mRequest.getContentType("profile"));
			
			profileDto.setProfile_member_no((int)req.getSession().getAttribute("check"));
			
			profileDao.insert(profileDto);

			resp.sendRedirect(req.getContextPath()+"/member/my.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
