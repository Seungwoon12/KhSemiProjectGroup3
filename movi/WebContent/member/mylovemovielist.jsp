<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="movi.beans.*"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mypage.css">

<%
	int member_no = (int)session.getAttribute("check");
	LoveDao loveDao = new LoveDao();
	
	int p = Integer.parseInt(request.getParameter("p"));
	int start = 1 + ((p-1) * 12), end = 12 * p; 
	List<LoveDto> member_love_list = loveDao.select_love_movie(member_no, start, end);
	MovieAdminDao movieDao = new MovieAdminDao();
	int count = 0;
	GenreDao genreDao = new GenreDao();
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(member_no);
%>

<div class="outbox center">
	<div class="lovelistTitle">
		<span style="font-size: 25px;"><%=memberDto.getMember_nick() %></span> 
		<span style="font-size: 18px;">님이 좋아요 한 영화 목록</span>
		
	</div>
	<br>
	<%for(LoveDto loveDto : member_love_list) {
		MovieDto movieDto = movieDao.select_admin(loveDto.getLove_movie_no());%>
		<div class="movie_box dotbox">
	            		<table>
	            		<tbody>
	            			<tr>
	            				<td rowspan="4">
	            					<a href="../category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
										<img class="movie_img" alt="movie_img" src="../image/movie/<%=movieDto.getMovie_no()%>.jpg" 
										onerror="this.src='/movi/image/movie/dummy.jpg'">
									</a>
								</td>
								<th style="min-width: 100px; max-width:150px">
									<a href="../category/detail.jsp?movie_no=<%=movieDto.getMovie_no()%>">
	            						<%=movieDto.getMovie_name()%>
	            					</a>
								</th>
							</tr>
	            			<tr>
	            				<td>
	            					<a href="../category/main.jsp?movie_genre_no=<%=movieDto.getMovie_genre_no()%>">
	            					장르 : <%=genreDao.find(movieDto.getMovie_genre_no())%>
	            					</a>
	            				</td>
	            			</tr>
	            			<tr>
	            				<td>
	            					평점 : <%=movieDto.getMovie_rate()%>
	            				</td>
	            			</tr>
	            			<tr>
	            				<td>
	            					좋아요 : <%=loveDao.love_count(movieDto.getMovie_no())%>
	            				</td>
	            			</tr>
	            		</tbody>
	            	</table>
	            	</div>
		<%count++;
		if(count % 3 == 0) {
		%>
		<hr>
	<%} }%>
	<br>
	<%if(p > 1) {%>
		<a href="mylovemovielist.jsp?p=<%=p-1%>">이전</a>
	<%} %>
	
	<div style="display: inline-block; width: 700px"></div>
	
	<%List<LoveDto> next_check = loveDao.select_love_movie(member_no, end+1, end+1); 
	if(!next_check.isEmpty()){%>
		<a href="mylovemovielist.jsp?p=<%=p+1%>">다음</a>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>