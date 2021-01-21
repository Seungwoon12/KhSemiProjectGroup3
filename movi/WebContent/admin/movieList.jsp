<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!-- 영화 목록  -->
<%
	MovieDao movieDao = new MovieDao();
	List<MovieDto> movieList = movieDao.select_admin();

%>

<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">영화 관리</h2>
		</div>
		<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br> 
			<a href="#"> 영화 수정 </a><br><br> 
		</div>
	</aside>

	<article>

		<!-- 영화 검색창 -->
		<div>
			<h1>영화 리스트</h1>
		</div>
		<div>
			<form action="#" method="post">
				<label>영화 검색</label> <input type="text" name="movie_name"> <input
					type="submit" value="검색">
			</form>
		</div>

		<!--멤버 리스트 테이블  -->
		<div class="row">
			<table class="table table-border">
				<thead>
					<tr>
						<th><input type="checkbox">전체선택</th>
						<th>영화번호</th>
						<th>영화제목</th>
						<th>개봉일</th>
						<th>관객수</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<%for(MovieDto movieDto : movieList){ %>
					<tr>
						<td><input type="checkbox"></td>
						<td><%=movieDto.getMovie_no() %></td>
						<td><%=movieDto.getMovie_name() %></td>
						<td><%=movieDto.getMovie_date() %></td>
						<td><%=movieDto.getMovie_audience() %></td>
						<td>
							<a href="movieDetail.jsp?movie_no=<%=movieDto.getMovie_no()%>">상세보기</a>
						 	<a href="movieEdit.jsp?movie_no=<%=movieDto.getMovie_no()%>">수정</a>
						 	 <a href="#">삭제</a>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		
		<!-- 선택된 회원 삭제버튼 -->
		<div class="right">
			<input type="button" value="선택된 영화 삭제" >
		</div>
		
		<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
				<li><a href="#">&lt;</a></li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
				<li><a href="#">&gt;</a></li>
			</ul>
		</div>
	</article>
</div>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>


