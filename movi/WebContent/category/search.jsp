<%@page import="movi.beans.MovieDtoVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="movi.beans.MovieDto"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	String movie_name = request.getParameter("movie_name");
	MovieDao movieDao = new MovieDao();
	List<MovieDto> movieList = movieDao.select_movie(movie_name);
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
        img{
			width:200px;
			height:300px;
		}
</style>

<script>
	$(document).ready(function(){
	
		$(".list").slideDown(500);
		$(".list").css("display","inline-block");
	});
</script>

<ul class="main movie_list">
		<%for(MovieDto dto : movieList){ %>
       <li class="list">
			<a href="detail.jsp?movie_no=<%=dto.getMovie_no()%>">
			<img src="../poster-down.do?movie_no=<%=dto.getMovie_no()%>">
				<%=dto.getMovie_name() %>
			</a>
       </li>
		<%}%>
</ul>



<jsp:include page="/template/footer.jsp"></jsp:include>