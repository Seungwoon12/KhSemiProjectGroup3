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
    
<form action="movieEdit.do" method="post">
	<div class="outbox" style="width: 100%">
		<aside>
			<div class="row center">
				<h2 style="color: deepskyblue;">영화 관리</h2>
			</div>
			<div class="left">
				<a href="movieList.jsp"> 영화리스트 </a><br>
				<br> <a href="movieInsert.jsp"> 영화 등록 </a><br>
				<br> <a href="#"> 영화 수정 </a><br>
			</div>
		</aside>

		<article>

			<div>
				<h1>영화 수정</h1>
			</div>

			<!--영화 추가 테이블  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">
					<thead>
						<h4 class="left">영화 정보 수정</h4>
					</thead>
					<tbody>
						<tr>
							<th>영화 번호</th>
							<td>
								<input type="hidden" name="movie_no" value="<%=movieDto.getMovie_no()%>">
							</td>
						</tr>
					
						<tr>
							<th style="width:30%">제목</th>
							<td>
								<input type="text" name="movie_name" placeholder="<%=movieDto.getMovie_name() %>" required>
							</td>
						</tr>
						<tr>
							<th>포스터</th>
							<td>
								<input type="button" value="이미지 업로드">
								<img src="https://placehold.it/300x300?text=IMAGE">
							</td>
						</tr>
						<tr>
							<th>장르</th>
							<td>
								<input type="text" name="movie_genre_no" placeholder="<%=movieDto.getMovie_genre_no() %>" required>
							</td>
						</tr>
						<tr>
							<th>상영시간</th>
							<td>
								<input type="text" name="movie_time" placeholder="<%=movieDto.getMovie_time() %>" required>
							</td>
						</tr>
						<tr>
							<th>평점</th>
							<td>
								<input type="text" name="movie_rate" placeholder="<%=movieDto.getMovie_rate() %>" required>							
							</td>
						</tr>
						<tr>
							<th>관객수</th>
							<td>
								<input type="text" name="movie_audience" placeholder="<%=movieDto.getMovie_audience() %>" required>
							</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<select name="movie_age">
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
								<select name="movie_country">
									<option <%if(movieDto.country("한국")){%>selected<%}%>>한국</option>
									<option <%if(movieDto.country("해외")){%>selected<%}%>>해외</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>개봉일</th>
							<td></td>
						</tr>
						<tr>
							<th>감독</th>
							<td>
								<input type="text" name="movie_director" placeholder="<%=movieDto.getMovie_director() %>" required>
							</td>
						</tr>
						<tr>
							<th>배우</th>
							<td></td>
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
									<input type="submit" value="등록" onclick="location.href='movieDetail.jsp?movie_no=<%=movieDto.getMovie_no()%>'">
									<input type="button" value="취소" onclick="location.href='movieList.jsp'">
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