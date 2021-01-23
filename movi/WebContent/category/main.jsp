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
 		.main,
        .main ul{
            list-style: none;
            margin: 0;
            padding: 30px;
        }
        .main{
        	width :100%;
        }
        .top{
            display: inline-block;
            width: 89px;
            padding: 0.4rem;
        }
        .top:hover,
        .top:active,
        .top:visited{
            text-decoration: underline;
            font-weight: bolder;
        }
        .main a{
            color: black;
            text-decoration: none;
        }
        .menu{
   	 		width: 530px;
   			margin-bottom: 35px;
        }
        .list{
        	width:215px;
        	padding :0.5rem;
        	display: none;
        }
</style>

<script>

	$(document).ready(function(){
		$(".a<%=movie_genre_no%>").css("text-decoration","underline");
		$(".a<%=movie_genre_no%>").css("font-weight","bolder");
	
		$(".list").slideDown(500);
		$(".list").css("display","inline-block");
	});
</script>

<ul class="main menu">
		<%for(GenreDto dto : genreList){ %>
       <li class="top">
			<a class="a<%=dto.getGenre_no()%>" href="main.jsp?movie_genre_no=<%=dto.getGenre_no()%>">
				<%=dto.getGenre_name()%>
			</a>
       </li>
		<%}%>
</ul>

<ul class="main movie_list">
		<%for(MovieDto dto : moviegenreList){ %>
       <li class="list">
			<a href="detail.jsp?movie_name=<%=dto.getMovie_name()%>">
			<img src ="https://placehold.it/200X300?text=IMAGE">
				<%=dto.getMovie_name() %>
			</a>
       </li>
		<%}%>
</ul>



<jsp:include page="/template/footer.jsp"></jsp:include>