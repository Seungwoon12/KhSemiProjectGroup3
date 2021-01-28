<%@page import="movi.beans.LoveDao"%>
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
		text-align:left;
		margin: 10px;
	}
	.outbox{
		text-align:center;
		margin-top: 7%;
		margin-bottom: 7%;
	}
	.detail{
		border: 1px solid lightgray;
	    text-align: left;
	    width: 68%;
	    margin-left: 16%;
	    padding: 2rem;
	}
	.icon{
		width:20px;
	}
	.heart {
		height: 35px;
		width: 35px;
		vertical-align: middle;
	}
	.love-btn {
		background-color: white;
		border: none;
		padding-left: 0px;
	}
	.reviewgo{
		text-align: right;	
	}
	.reviewgo:hover{
		font-weight: bolder;
	}
</style>
<script>
	$(function(){
		$(".cancel_love").click(function(){
			location.href="love_cancel.do?movie_no=<%=movie_no%>";
		});
		$(".plus_love").click(function(){
			location.href="love.do?movie_no=<%=movie_no%>";
		});
	});
</script>
<div class="outbox">
	<%for(MovieDtoVO dto : moviegenreList){ %>
	<div>
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

<div class="detail">
	<div class="row">
		<h2><img class="icon" src="../img/check.png">상세 정보</h2>
		<p><%=dto.getMovie_name()%></p>
		<p><%=dto.getMovie_date()%> ・ <%=dto.getMovie_time()%>분 ・ <%=dto.getMovie_director()%></p>
		<h4>[줄거리]</h4>
		<p><%=dto.getMovie_content()%></p>
	</div>

<%} %>
	
<hr>
<!-- 출연배우 불러오자 !!! -->	
	<div>
		<h2><img class="icon" src="../img/check.png">출연배우</h2>
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
	</div>
	<div class="love_box">
	<%
	LoveDao loveDao = new LoveDao();
	boolean loginCheck = session.getAttribute("check") != null;
	
	if(loginCheck) {
		int member_no = (int)session.getAttribute("check");
		boolean love_check = loveDao.love_search(member_no, movie_no);
		if(love_check){
		%>
		<button class="love-btn cancel_love">
			<img class="heart" alt="cancel_love" src="<%=request.getContextPath()%>/img/heart_red.png">
		<%=loveDao.love_count(movie_no) %>
		</button>
		<%} else{ %>
		<button class="love-btn plus_love">
			<img class="heart" alt="plus_love" src="<%=request.getContextPath()%>/img/heart_white.png">
		<%=loveDao.love_count(movie_no) %>
		</button>
		<%} %>
	<%} %>
	<div class="reviewgo">
	<!-- 클릭하면 해당 영화의 movie_no가 검색된 리뷰 테이블로 이동하기 -->
	<a href="/movi/review/list.jsp">영화 리뷰 보러가기</a>
	</div>
	</div>
</div>	
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>