<%@page import="movi.beans.MovieDtoVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="movi.beans.MovieDto"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
	MovieDao movieDao = new MovieDao();
	List<MovieDtoVO> moviegenreList = movieDao.select_movie_detail(movie_no);
			
	List<MovieDtoVO> main_actor = movieDao.find_actor(movie_no, "주연");
	List<MovieDtoVO> sub_actor = movieDao.find_actor(movie_no, "조연");
%>

<style>
	.top{
		display:inline-block;
	}
</style>
<div class="outbox">
	<%for(MovieDtoVO dto : moviegenreList){ %>
	<div >
		<div class="top">
			<img src ="https://placehold.it/200X300?text=IMAGE">
		</div>
		<div class="top">
			<div>
			<% String a = String.format("%,d", dto.getMovie_audience());%>
			누적 관객수 · <%=a %>명
			</div>
			<div>
			<h1><%=dto.getMovie_name()%></h1>
			</div>	
			
			<%
				SimpleDateFormat f = new SimpleDateFormat("yyyy");
				String date = f.format(dto.getMovie_date());
			%>
			
<!-- 장르 번호로 장르 이름 불러오자!!! -->
			<div>
			<%=date%> ・ <%=dto.getGenre_name()%> ・ <%=dto.getMovie_country()%> ・ <%=dto.getMovie_age() %>
			</div>
			<div>
			<h4>평점 ★(<%=dto.getMovie_rate()%>/5.0)</h4>
			</div>
		</div>
	</div>
	
	<hr>

	<div class="row">
		<h3>상세 정보</h3>
	<hr>
		<p><%=dto.getMovie_name()%></p>
		<p><%=dto.getMovie_date()%> ・ <%=dto.getMovie_time()%>분 ・ <%=dto.getMovie_director()%></p>
		<br>
		[줄거리]
		<p><%=dto.getMovie_content()%></p>
	</div>
	
	<hr>

<%} %>
	
<!-- 출연배우 불러오자 !!! -->	
	<div>
		<h3>출연배우</h3>
	<hr>
	<h4>주연</h4>
	<p>
		<%for(MovieDtoVO vo : main_actor) {%>
			<%=vo.getActor_name()%>&nbsp;   
		<%}%>
	</p>
	<h4>조연</h4>
	<p>
		<%for(MovieDtoVO vo : sub_actor) {%>
			<%=vo.getActor_name()%>&nbsp;     
		<%}%>
	</p>
	<hr>
	
	<div class="right">
	<!-- 클릭하면 해당 영화의 movie_no가 검색된 리뷰 테이블로 이동하기 -->
	<a href="/movi/review/list.jsp">영화 리뷰 보러가기</a>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>