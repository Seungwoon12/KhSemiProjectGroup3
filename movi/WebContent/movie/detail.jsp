<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%@page import="movi.beans.*"%>

<style>
	.heart {
		height: 35px;
		width: 35px;
	}
</style>

<%
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
	MovieDao movieDao = new MovieDao();
	MovieDto movieDto = movieDao.select_admin(movie_no); /*이것도 나중에 수정*/
	
	LoveDao loveDao = new LoveDao();
	boolean loginCheck = session.getAttribute("check") != null;
%>

<div class="outbox">
	<div class="row center">
		<table class="table table-border" style="width:80%">
			<tbody>
				<tr>
					<th colspan="2">
						<h1 class="left">
							<%=movieDto.getMovie_name() %>
						</h1>
					</th>
					<td rowspan="11" class="center" style="width:300px; height:400px;">
							<img src="https://placehold.it/300x400?text=IMAGE">
					</td>
				</tr>
				<tr>
					<th style="width:10%">평점</th>
					<td><%=movieDto.getMovie_rate() %></td>
				</tr>
				<tr>
					<th>장르</th>
					<td><%=movieDto.getMovie_genre_no() %></td>
				</tr>
				<tr>
					<th>상영시간</th>
					<td><%=movieDto.getMovie_time() %></td>
				</tr>
				<tr>
					<th>등급</th>
					<td><%=movieDto.getMovie_age() %></td>
				</tr>
				<tr>
					<th>개봉일</th>
					<td><%=movieDto.getMovie_date() %></td>
				</tr>
				<tr>
					<th>국가</th>
					<td><%=movieDto.getMovie_country() %></td>
				</tr>
				<tr>
					<th>감독</th>
					<td><%=movieDto.getMovie_director() %></td>
				</tr>
					<tr>
					<th>배우</th>
					<td></td>
				</tr>
				<tr>
					<th>좋아요 수</th>
					<td><%=loveDao.love_count(movie_no) %></td>
				</tr>
				<tr>
					<th>관객 수</th>
					<td><%=movieDto.getMovie_audience() %></td>
				</tr>
				<tr>
					<th colspan="3">
					<h4 class="left">줄거리</h4>
					<p class="left">
						<%=movieDto.getMovie_content() %>
					</p>
					</th>
				</tr>
			</tbody>
		</table>
	</div>
	<%if(loginCheck) {
		int member_no = (int)session.getAttribute("check");
		boolean love_check = loveDao.love_search(member_no, movie_no);
		if(love_check){
		%>
		<a href="love_cancel.do?movie_no=<%=movieDto.getMovie_no()%>">
			<img class="heart" alt="cancel_love" src="<%=request.getContextPath()%>/img/heart_red.png">
		</a>
		<%} else{ %>
		<a href="love.do?movie_no=<%=movieDto.getMovie_no()%>">
			<img class="heart" alt="plus_love" src="<%=request.getContextPath()%>/img/heart_white.png">
		</a>
		<%} %>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>