<%@page import="movi.beans.MovieDto"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
	MovieDao movieDao = new MovieDao();
	List<MovieDto> moviegenreList = movieDao.select_movie(movie_no);
%>

<div>
	<%for(MovieDto dto : moviegenreList){ %>
	<p><%=dto.getMovie_name()%></p>
	<p><%=dto.getMovie_age() %></p>
	<p><%=dto.getMovie_audience()%></p>
	<p><%=dto.getMovie_country()%></p>
	<p><%=dto.getMovie_director()%></p>
	<p><%=dto.getMovie_rate()%></p>
	<p><%=dto.getMovie_time()%></p>
	<p><%=dto.getMovie_date()%></p>
	<p><%=dto.getMovie_content()%></p>
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>