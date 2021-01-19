<%@page import="movi.beans.LoveDao"%>
<%@page import="movi.beans.MovieDtoVO"%>
<%@page import="movi.beans.RecommendDto"%>
<%@page import="movi.beans.RecommendDao"%>
<%@page import="java.util.List"%>
<%@page import="movi.beans.MovieDao"%>
<%@page import="movi.beans.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	//3조추천
	RecommendDao recomDao = new RecommendDao();
	List<RecommendDto> recomList = recomDao.select();
	
	//좋아요순
	MovieDao movieDao = new MovieDao();
	List<MovieDtoVO> movieLoveList = movieDao.select_love();
	
	//관객순
	List<MovieDto> movieAudList = movieDao.select_aud();

%>
<!-- 이거 jquery css로 만들기! -->
<style>
	.hov{
		border: 1px solid red;
	}
	
	.hov:hover{
		opacity: 0.5;
	}
	
	.hov:hover +.hov1{
		display:block;
	 	z-index: 999;
	    position: absolute;
	    top:200px;
	    width:200px;
	    left: 230px;
	}
	.hov:hover +.hov2{
		display:block;
	 	z-index: 999;
	    position: absolute;
	    top:500px;
	    width:200px;
	}
	.hov:hover +.hov3{
		display:block;
	 	z-index: 999;
	    position: absolute;
	    top:700px;
	    width:200px;
	}
	
	.hov1, .hov2, .hov3{
	   display:none;
	}
	
	.unit.slot.id{
            background-image: url(./img/search.jpg);
            background-size: contain;
            background-repeat: no-repeat; 
        }
        
   .name{
   	float:left;
   }
	
</style>
<div class="outbox" style="width:800px">
	<div class="name">
		<div>	
			<input class="input input-hint unit slot id" placeholder="아이디(이메일)" type="text" style="width:200px">
		</div>
		<div class="center" style="width:200px">
			<h1>MOVI</h1>
			<h5>모두의 비디오, 모비</h5>
		</div>
		<div class="right" style="width:200px">
			<   >
		</div>
	</div>
	
	<div>
		<div>
			<img class="hov" src="http://placeimg.com/150/200/any">
			<%for(RecommendDto dto : recomList){ %>
			<h1 class="hov1">
					<%=dto.getRecom_title()%>
			</h1>
			<%} %>
		</div>	
	</div>
</div>


<!-- @@@@@@@@@@ 좋아요 순위 -->

<div class="outbox" style="width:640px">
	<div class="row left">
		모비 좋아요 순위
	</div>
	<div class="row left hov">
		<div>
			<%for(MovieDtoVO dto : movieLoveList){ %>
			<img class="hov" src="http://placeimg.com/100/200/any">
			<h1 class="hov2">
					<%=dto.getMovie_name()%>
			</h1>
			<%} %>
		</div>
	</div>
</div>

<!-- @@@@@@@@@@ 관객수 순위 -->

<div class="outbox" style="width:640px">
	<div class="row left">
		모비 관객수 순위
	</div>
	<div class="row left hov">
		<div>
			<%for(MovieDto dto : movieAudList){ %>
			<img class="hov" src="http://placeimg.com/100/200/any">
			<h1 class="hov3">
					<%=dto.getMovie_name()%>
			</h1>
			<%} %>
		</div>
	</div>
</div>

<!-- @@@@@@@@@@ 맞춤 추천 -->
<div class="outbox" style="width:640px">
	<div class="row left">
		맞춤 영화
	</div>
	<div class="row left hov">
		<div>
			<img src="https://placehold.it/300X200?text=IMAGE">
		</div>
	</div>
</div>

