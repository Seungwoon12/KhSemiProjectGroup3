<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상세보기 영화 정보 -->
<%
//영화 상세정보
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
	MovieAdminDao movieDao = new MovieAdminDao();
	MovieDto movieDto = movieDao.select_admin(movie_no);
	
//배우 정보
	List<MovieDtoVO> main_actor = movieDao.actor_admin(movie_no, "주연");
	List<MovieDtoVO> sub_actor = movieDao.actor_admin(movie_no, "조연");

//장르 정보	
 	List<MovieDtoVO> genre_name = movieDao.genre_admin(movie_no);

//좋아요 수 정보 
	List<MovieDtoVO> mlike = movieDao.mlike_amdin(movie_no);
%>
    
<jsp:include page="/adminTemplate/header.jsp"></jsp:include> 

<!-- 각종 기능 -->
<script>
//영화 삭제시 alert확인
	window.onload= function(){
		document.querySelector(".movie_delete").addEventListener("click", function(){
			
			var check = window.confirm("영화를 삭제하시겠습니까?");
			if(check){
				location.href="<%=request.getContextPath()%>/admin/movieDelete.do?movie_no=<%=movieDto.getMovie_no()%>" ;
			}else{
				location.href= "<%=request.getContextPath()%>/admin/movieList.jsp" ;
			}
		});
	}; 
	

</script>

<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">영화 관리</h2>
		</div>
		<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="#"> 배우 등록 </a><br><br>
			<a href="#"> 3조 추천 영화 리스트 </a><br><br>
			<a href="#"> 3조 추천 영화 등록 </a><br><br> 
		</div>
	</aside>

	<article>

		<div>
			<h1>영화 상세보기</h1>
		</div>

		<!--영화 리스트 테이블  -->
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
							 <!-- <img src="https://placehold.it/300x400?text=IMAGE"> -->
							 <img src="../image/movie/<%=movieDto.getMovie_poster() %>">
						</td>
					</tr>
					<tr>
						<th style="width:10%">평점</th>
						<td><%=movieDto.getMovie_rate() %></td>
					</tr>
					<tr>
						<th>장르</th>
						<td><%for(MovieDtoVO genre : genre_name){ %>
								<%=genre.getGenre_name() %>
							<%} %>
						</td>
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
						<td>
						주연: <%for(MovieDtoVO actor : main_actor) { %>
								<%=actor.getActor_name() %>
							 <%} %>
						/	 
						조연: <%for(MovieDtoVO actor : sub_actor) {%>
								<%=actor.getActor_name() %>
							 <%} %>		 	
						</td>
					</tr>
					<tr>
						<th>좋아요 수</th>
						<td>
							<%for(MovieDtoVO like : mlike){ %>
								<%=like.getMlike() %>
							<%} %>	
						</td>
					</tr>
					<tr>
						<th>관객 수</th>
						<td><%=movieDto.getMovie_audience() %></td>
					</tr>
					<tr >
						<th colspan="3">
						<h4 class="left">줄거리</h4>
						<p class="left">
							<%=movieDto.getMovie_content() %>
						</p>
						</th>
					</tr>
					<tr>
						<th colspan="3">
							<input type="button" value="수정" id="movieEdit" onclick="location.href=' movieEdit.jsp?movie_no=<%=movieDto.getMovie_no()%>' ">
							<input type="button" value="삭제" class="movie_delete">
						</th>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 영화리스트로 돌아가기 -->
		<div class="right">
			<a href="movieList.jsp">영화리스트로 돌아가기</a>
		</div>
		


	</article>
</div>




<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>    