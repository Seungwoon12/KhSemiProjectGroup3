package movi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import movi.beans.MemberDao;
import movi.beans.MemberDto;
import movi.beans.ReviewDao;
import movi.beans.ReviewDto;

@WebFilter(urlPatterns= {
		"/review/edit.jsp", "/review/edit.do", "/review/delete.do"
})
public class ReviewFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//HttpServletRequest, HttpServletResponse로 다운캐스팅
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		
		try {
			req.setCharacterEncoding("UTF-8");
			
			//관리자인지 먼저 검사해서 관리자라면 통과
			String auth = (String)req.getSession().getAttribute("auth");
			if(auth != null && auth.equals("관리자")) {
				chain.doFilter(request, response);
				return;
			}
			
			//리뷰 작성자인지 검사해서 통과여부 결정
			int review_no = Integer.parseInt(req.getParameter("review_no"));
			ReviewDao reviewDao = new ReviewDao();
			ReviewDto reviewDto = reviewDao.find(review_no);
			
			int member_no = (int)req.getSession().getAttribute("check");
			MemberDao memberDao = new MemberDao();
			MemberDto memberDto = memberDao.find(member_no);
			
			if(reviewDto.getReview_writer_no() == memberDto.getMember_no()) {
				chain.doFilter(request, response);
				return;
			}
			
			resp.sendError(403);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}