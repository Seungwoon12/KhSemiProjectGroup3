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
        	width :25%;
            border : 1px solid black;
        }
        .main>li{
            display: inline-block;
            width: 89px;
            padding: 0.4rem;
        }
        .main>li:hover,
        .main>li:active,
        .main>li:visited{
            text-decoration: underline;
            background-color: gray;
        }
        .main a{
            color: black;
            text-decoration: none;
        }
        .menu{
   	 		width: 530px;
   			margin-bottom: 35px;
        }
</style>

<script>
	$(function(){
		//클릭시 색칠 되는 스타일이 계속 적용되도록.. 페이지가 이동해도 가능한가?
		$("li>a").click(function(){
			//$(this).addClass('active');
			//$(this).css("background-color","yellow");
		});
	});
</script>

<ul class="main menu">
		<%for(GenreDto dto : genreList){ %>
       <li>
			<a class="aa" href="main.jsp?movie_genre_no=<%=dto.getGenre_no()%>">
				<%=dto.getGenre_name()%>
			</a>
       </li>
		<%}%>
</ul>

<ul class="main movie_list">
       <li>
		<%for(MovieDto dto : moviegenreList){ %>
			<a href="detail.jsp?movie_name=<%=dto.getMovie_name()%>">
				<%=dto.getMovie_name() %>
			</a>
		<%}%>
       </li>
</ul>



<jsp:include page="/template/footer.jsp"></jsp:include>