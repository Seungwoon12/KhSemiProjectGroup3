<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 영화 기본정보 등록하기 -->
<!-- 수정할 때는 영화번호 불러와서 수정할 수 있었지만 insert는 check제한 조건을 어떻게 해야 할지 모르겠다.... -->


<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<form action="movieInsert.do" method="post">
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
				<h1>영화 등록</h1>
			</div>

			<!--영화 추가 테이블  -->
			<div class="row center">
				<table class="table table-border" style="width: 80%">
					<thead>
						<h4 class="left">영화 기본정보</h4>
					</thead>
					<tbody>
						<tr>
							<th style="width:30%">제목</th>
							<td>
								<input type="text" name="movie_name" required>
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
								<input type="text" name="movie_genre_no" required>
							</td>
						</tr>
						<tr>
							<th>상영시간</th>
							<td>
								<input type="text" name="movie_time" required>
							</td>
						</tr>
						<tr>
							<th>평점</th>
							<td>
								<input type="text" name="movie_rate" required>							
							</td>
						</tr>
						<tr>
							<th>관객수</th>
							<td>
								<input type="text" name="movie_audience" required>
							</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<select name="movie_age">
									<option>전체관람가</option>
									<option>12세이상관람가</option>
									<option>15세이상관람가</option>
									<option>청소년관람불가</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>국가</th>
							<td>
								<select name="movie_country">
									<option>한국</option>
									<option>해외</option>
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
								<input type="text" name="movie_director" required>
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
									<input type="submit" value="등록" >
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