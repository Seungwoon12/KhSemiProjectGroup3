<%@page import="movi.beans.MygenreDtoVO"%>
<%@page import="movi.beans.MygenreDto"%>
<%@page import="movi.beans.MygenreDao"%>
<%@page import="movi.beans.MemberDto"%>
<%@page import="movi.beans.MemberDao"%>
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
	MovieDto dto = new MovieDto();

	//3조추천
	RecommendDao recomDao = new RecommendDao();
	List<RecommendDto> recomList = recomDao.select();
	
	//좋아요순
	MovieDao movieDao = new MovieDao();
	List<MovieDtoVO> movieLoveList = movieDao.select_love();
	
	//관객순
	List<MovieDto> movieAudList = movieDao.select_aud();
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(1);
	
	//세션 회원 맞춤순
	request.getSession().setAttribute("check", memberDto.getMember_no());
	int genre = (int)session.getAttribute("check");
	
	int a = 2;
	//장르별
	MygenreDao mygenreDao = new MygenreDao();
	List<MygenreDtoVO> mygenreList = mygenreDao.find(a);
	
%>
<!-- 이거 jquery css로 만들기! -->
<style>
	.hov{
		border: 1px solid red;
	}
	
	.hov:hover{
		opacity: 0.5;
	}
	
	.hov:hover +.h{
		display:block;
	 	z-index: 999;
	    position: absolute;
	    width:150px;
	}
	.hov:hover +.hov1{
	    top:250px;
	}
	.hov:hover +.hov2{
	    top:600px;
	}
	.hov:hover +.hov3{
	    top:850px;
	}
	
	.hov:hover +.hov4{
	    top:1100px;
	}
	
	.h{
	   display:none;
	}
	
	.unit.slot.id{
            background-image: url(./img/search.jpg);
            background-size: contain;
            background-repeat: no-repeat; 
        }
        
   .name{
   float: left;
   width:27%;
   }
   .recom{
   float:right;
   width:70%;
   display: flex;
   }
   .name,.recom{
   	height:300px;
   	padding: 0.5rem;
   }
	
	.main{
		width:100%;
		height: 500px;
	}
	.row{
		display:flex;
		}
	.movie{
		padding: 0.2rem;
	}
</style>

<script>
	$(function(){
		$(".hov").click(function(){
			//영화 클릭하면 상세보기 가도록 해보자~
			location.href="/movi/category/detail.jsp?movie_no="+<%=28%>;
		});
	});
</script>


<div class="outbox" style="width:800px">

<div class="main" style="height:295px">
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
<!-- @@@@@@@@@@ 3조 추천 영화 -->	
	<div>
		<div class="recom">
			<%for(RecommendDto recomdto : recomList){ %>
			<div style="padding: 0.2rem">
			<img class="hov" src="http://placeimg.com/150/200/any">
			<h1 class="h hov1">
					<%=recomdto.getRecom_title()%>
			</h1>
			</div>
			<%} %>
			
		</div>	
	</div>
</div>

<hr>
<!-- @@@@@@@@@@ 좋아요 순위 -->

<div class="outbox" style="width:640px">
	<div class="row left">
		모비 좋아요 순위
	</div>
		<div class="row">
			<%for(MovieDtoVO lovedto : movieLoveList){ %>
			<div class="movie">
			<img class="hov" src="http://placeimg.com/100/200/any">
			<h1 class="h hov2">
					<%=lovedto.getMovie_name()%>
			</h1>
			</div>
			<%} %>
	</div>
</div>

<!-- @@@@@@@@@@ 관객수 순위 -->

<div class="outbox" style="width:640px">
	<div class="row left">
		모비 관객수 순위
	</div>
		<div class="row">
			<%for(MovieDto moviedto : movieAudList){ %>
			<div class="movie">
			<img class="hov" src="http://placeimg.com/100/200/any">
			<h1 class="h hov3">
					<%=moviedto.getMovie_name()%>
			</h1>
			</div>
			<%} %>
	</div>
</div>

<!-- @@@@@@@@@@ 맞춤 추천 -->
<div class="outbox" style="width:640px">
	<div class="row left">
		맞춤 영화
	</div>
		<div class="row">
			<%for(MygenreDtoVO mydto : mygenreList){ %>
			<div class="movie">
			<img class="hov" src="http://placeimg.com/100/200/any">
			<h1 class="h hov4">
					<%=mydto.getGenre_name()%>
			</h1>
			</div>
			<%} %>
	</div>
</div>

</div>

