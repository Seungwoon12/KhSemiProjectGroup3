<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 관리자 : 영화 정보 수정 -->  
 <%
 	//파라미터 받아서 출력
 	request.setCharacterEncoding("UTF-8");
 	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
 	MovieAdminDao movieDao = new MovieAdminDao();
 	MovieDto movieDto = movieDao.select_admin(movie_no);
 
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
		label{
			font-size: 15px;
			color:gray;
		}
</style>

    
<form action="movieEdit.do" method="post">
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
				<h1>영화 수정</h1>
			</div>

			<!--영화 추가 테이블  -->
			<div class="row center">
				<table class="table2  table" style="width: 80%; margin-left:10%">
					<thead>
						<h4 class="left">영화 정보 수정</h4>
					</thead>
					<tbody>
						<tr>
							<th>영화 번호</th>
							<td>
								<input type="hidden" name="movie_no" value="<%=movieDto.getMovie_no()%>">
								<%=movieDto.getMovie_no()%> 번
							</td>
						</tr>
					
						<tr>
							<th style="width:30%">제목</th>
							<td>
								<input type="text"  class="row1"  name="movie_name" placeholder="<%=movieDto.getMovie_name() %>" required>
							</td>
						</tr>
						<tr>
							<th>포스터</th>
							<td>
									<img alt="poster" src="../poster-down.do?movie_no=<%=movieDto.getMovie_no() %>" 
										onerror="this.src='https://placehold.it/400X300?text=IMAGE'" 
										style="height: 400px; width: 300px;">
							</td>
						</tr>
						<tr>
							<th>장르</th>
							<td>
							<label>1:로맨스, 2:범죄, 3:뮤지컬, 4:애니, 5:액션, 6:판타지, 7:역사극,<br> 8:전쟁, 9:코미디, 10:SF</label>
								<input type="text" class="row1" name="movie_genre_no" placeholder="<%=movieDto.getMovie_genre_no() %>" required>
							</td>
						</tr>
						<tr>
							<th>상영시간</th>
							<td>
								<input type="text" class="row1" name="movie_time" placeholder="<%=movieDto.getMovie_time() %>" required>
							</td>
						</tr>
						<tr>
							<th>평점(/5.0)</th>
							<td>
								<input type="text" class="row1" name="movie_rate" placeholder="<%=movieDto.getMovie_rate() %>" required>							
							</td>
						</tr>
						<tr>
							<th>관객수</th>
							<td>
								<input type="text" class="row1" name="movie_audience" placeholder="<%=movieDto.getMovie_audience() %>" required>
							</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<select name="movie_age" class="row1" >
									<option <%if(movieDto.age("전체관람가")){%>selected<%}%>>전체관람가</option>
									<option <%if(movieDto.age("12세이상관람가")){%>selected<%}%>>12세이상관람가</option>
									<option <%if(movieDto.age("15세이상관람가")){%>selected<%}%>>15세이상관람가</option>
									<option <%if(movieDto.age("청소년관람불가")){%>selected<%}%>>청소년관람불가</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>국가</th>
							<td>
								<select name="movie_country" class="row1" >
									<option <%if(movieDto.country("한국")){%>selected<%}%>>한국</option>
									<option <%if(movieDto.country("해외")){%>selected<%}%>>해외</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>개봉일</th>
							<td>
								<input type="date" class="row1"  name="movie_date" placeholder="<%=movieDto.getMovie_date() %>" required>
							</td>
						</tr>
						<tr>
							<th>감독</th>
							<td>
								<input type="text" class="row1"  name="movie_director" placeholder="<%=movieDto.getMovie_director() %>" required>
							</td>
						</tr>
						<tr>
							<th>줄거리</th>
							<td>
								<textarea class="input" name="movie_content" placeholder="줄거리 입력"></textarea>
							</td>
						</tr>
						<tr>
							<th colspan="2">
								<div >
									<input type="submit" class="adbtn green" value="등록" >
									<input type="button" class="adbtn yellow" value="취소" onclick="location.href='movieList.jsp'">
								</div>
							</th>
						</tr>

					</tbody>
				</table>
			</div>
		</article>
	</div>
</form>
    
    
<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>   