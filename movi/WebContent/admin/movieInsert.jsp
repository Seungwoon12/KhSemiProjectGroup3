<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 영화 기본정보 등록하기 -->

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
		.table > thead > tr > th,
		.table > thead > tr > td,
		.table > tbody > tr > th,
		.table > tbody > tr > td,
		.table > tfoot > tr > th,
		.table > tfoot > tr > td
		{
 		   padding: 1rem;
 		   text-align: center;
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
				<h1>영화 등록</h1>
			</div>
			<!--영화 추가 테이블  -->			
			
		<form action="movieInsert.do" method="post">
			<div class="row center">
				<table class="table2 table " style="width: 80%; margin-left:10%;">
					<thead>
						<h1 class="left">영화 기본정보</h1>
					</thead>
					<tbody>
							
						<tr>
							<th style="width:30%">제목</th>
							<td>
								<input type="text" class="row1" name="movie_name" required>
							</td>
						</tr>
						<tr>
							<th>장르</th>
							<td>
								<input type="text" class="row1" name="movie_genre_no" required>
							</td>
						</tr>
						<tr>
							<th>상영시간</th>
							<td>
								<input type="text" class="row1" name="movie_time" required>
							</td>
						</tr>
						<tr>
							<th>평점</th>
							<td>
								<input type="text" class="row1" name="movie_rate" required>							
							</td>
						</tr>
						<tr>
							<th>관객수</th>
							<td>
								<input type="text" class="row1" name="movie_audience" required>
							</td>
						</tr>
						<tr>
							<th>등급</th>
							<td>
								<select name="movie_age" class="row1">
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
								<select name="movie_country" class="row1">
									<option>한국</option>
									<option>해외</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>개봉일</th>
							<td>
								<input type="date" class="row1" name="movie_date" required>
							</td>
						</tr>
						<tr>
							<th>감독</th>
							<td>
								<input type="text" class="row1" name="movie_director" required>
							</td>
						</tr>
						<tr>
							<th>줄거리</th>
							<td>
								<textarea class="input" name="movie_content" placeholder="줄거리 입력" required></textarea>
							</td>
						</tr>
						<tr>
							<th colspan="2">배우는 영화리스트-> 배우 수정에서 넣으세요.</th>
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
		</form>	
		</article>
	</div>



<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>