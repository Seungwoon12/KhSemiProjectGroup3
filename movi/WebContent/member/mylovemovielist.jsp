<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int member_no = (int)session.getAttribute("check");
	LoveDao loveDao = new LoveDao();
	
	int p = Integer.parseInt(request.getParameter("p"));
	int start = 1 + ((p-1) * 16), end = 16 * p; 
	List<LoveDto> member_love_list = loveDao.select_love_movie(member_no, start, end);
	MovieAdminDao movieDao = new MovieAdminDao();
	int count = 0;
%>

<div class="outbox">
	<%for(LoveDto loveDto : member_love_list) {
		MovieDto movieDto = movieDao.select_admin(loveDto.getLove_movie_no());%>
		<a href="<%=request.getContextPath()%>/category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
			<img alt="movie_img" src="<%=request.getContextPath()%>/image/movie/<%=movieDto.getMovie_no()%>.jpg" 
			onerror="this.src='/movi/image/movie/dummy.jpg'">
			<%=movieDto.getMovie_name() %>
		</a>
		<%count++;
		if(count % 4 == 0) {
		%>
		<hr>
	<%} }%>
	
	<%if(p > 1) {%>
		<a href="mylovemovielist.jsp?p=<%=p-1%>">이전</a>
	<%} %>
	
	<%List<LoveDto> next_check = loveDao.select_love_movie(member_no, end+1, end+1); 
	if(!next_check.isEmpty()){%>
		<a href="mylovemovielist.jsp?p=<%=p+1%>">다음</a>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>