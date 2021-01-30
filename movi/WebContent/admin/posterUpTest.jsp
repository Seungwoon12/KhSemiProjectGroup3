<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 영화 포스터 정보 등록하기 -->


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

<style>
        .row1 {
            width: 90%;
            margin:3px;
            border: solid 2px gray;
            border-radius: 8px;
            font-size:15px;
            padding:0.5rem;
            padding-left: 1.5rem;
        }
		
		.table2{
			border-radius: 10px;
			border-color: lightblue;
			padding:1rem;
            font-size:18px;			
		}
		
		th{
    		text-align: left !important;
    		padding:1rem;
		}

</style>





	<div class="outbox" style="width: 100%">
		<aside>
			<div class="row center">
				<h2 style="color: deepskyblue;">영화 관리</h2>
			</div>
			<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br>
			<a href="actorList.jsp"> 배우 리스트 </a><br><br>
			<a href="actorInsert.jsp"> 배우 등록 </a><br><br>
			<a href="recomList.jsp"> 3조 추천 영화 리스트 </a><br><br>
			<a href="recomInsert.jsp"> 3조 추천 영화 등록 </a><br><br>
			</div>
		</aside>

		<article>
		
		<div>
			<h1>입력된 정보 확인</h1>		
		</div>

			<div class="row center">
			<table class="table table2" style="width:80%; margin-left:10%">
				<tbody>
					<tr>
						<th colspan="2">
						<h1 class="left">
							<%=movieDto.getMovie_name() %>
						</h1>
						</th>
					</tr>
					<tr>
						<th style="width:20%">평점</th>
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
						<th class="left">배우</th>
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
						<th class="left">좋아요 수</th>
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
						<hr>
						<h4 class="left">줄거리</h4>
						<p class="left" style="font-size: medium;">
							<%=movieDto.getMovie_content() %>
						</p>
						</th>
					</tr>
				</tbody>
			</table>
		</div>
	
	
	
	
	
						
			<!-- 영화 포스터 먼저 업로드 하기 -->
			<h1>영화 포스터 업로드</h1>
		<form action="poster-up.do" method="post" enctype="multipart/form-data">
		<div class="row">
			<input type="hidden" name="movie_no" value="<%=movie_no%>">
			<%=movie_no%>
			<table class="table table2" style="width:800px ;  margin-left:10%">
				<tbody>
					<tr>
						<td>
							<input type="file" name="movie_poster" required accept=".jpg, .png, .gif">
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" class="adbtn green" value="이미지 등록">
							<input type="button" class="adbtn yellow" value="취소" onclick="location.href='movieList.jsp'">
						</td>
					</tr>
				</tbody>
			</table>
		</div>	
		</form>

		
		
		</article>
	</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>		
		
		
		