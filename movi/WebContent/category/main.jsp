<%@page import="movi.beans.MovieDto"%>
<%@page import="movi.beans.MovieDao"%>
<%@page import="movi.beans.GenreDao"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.GenreDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	GenreDao genreDao = new GenreDao();
	List<GenreDto> genreList = genreDao.view();
	
	int movie_genre_no = Integer.parseInt(request.getParameter("movie_genre_no"));
	MovieDao movieDao = new MovieDao();
	List<MovieDto> moviegenreList = movieDao.select_genre(movie_genre_no);
%>
<style>
 .menu,
        .menu ul{
            list-style: none;
            margin: 0;
            padding: 30px;
        }
        .menu{
        	width :25%;
            border : 1px solid black;
        }
        .menu>li{
            width: 100%;
            display: inline-block;
            position: relative;
        }
        .menu a{
            color: black;
            text-decoration: none;
        }
</style>

<ul class="menu">
       <li>
		<%for(GenreDto dto : genreList){ %>
			<a href="main.jsp?movie_genre_no=<%=dto.getGenre_no()%>">
				<%=dto.getGenre_name() %>
			</a>
		<%}%>
       </li>
</ul>

<ul class="menu">
       <li>
		<%for(MovieDto dto : moviegenreList){ %>
			<a href="detail.jsp?movie_name=<%=dto.getMovie_name()%>">
				<%=dto.getMovie_name() %>
			</a>
		<%}%>
       </li>
</ul>



<jsp:include page="/template/footer.jsp"></jsp:include>