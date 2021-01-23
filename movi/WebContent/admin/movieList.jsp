<%@page import="java.util.*"%>
<%@page import="movi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 인코딩값 : UTF-8 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 페이지 네비게이션 -->
<%
	int pageSize = 10;
	int p ;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p<=0) throw new Exception();//페이지<=0일 때 강제예외
	}catch(Exception e){
		p=1;
	}
	
	//페이지 시작, 끝 번호 계산
	int endRow = p * pageSize;
	int startRow = endRow- pageSize+1;
	
%>

<!-- 영화 검색  -->
<%
	//type(분류):영화 번호,영화제목 	key:검색어
	request.setCharacterEncoding("UTF-8");
	String type= request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean search = type != null && key != null;
%>
<!-- 영화 목록  -->
<%
	MovieAdminDao movieDao = new MovieAdminDao();
	List<MovieDto> movieList;
	if(search){
		//movieList = movieDao.select_admin(type, key);
		movieList = movieDao.page_admin(type, key, startRow, endRow);
	}else{
		movieList = movieDao.page_admin(startRow, endRow);
	}
	

%>	

<!-- 페이지 블록  -->
<%
	
	//블록크기
	int blockSize = 10;
	int startBlock = (p-1)/blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;
	
	//int count;
	//if(search){
	//	count= memberDao.count_admin(type, key); 
	//}else{
	//	count= memberDao.count_admin(); 
	//}
	//페이지 개수
	//int countSize = (count + pageSize -1) / pageSize;
	
	//if(endBlock > countSize){
	//	endBlock = countSize;
	//}
%>
	
<jsp:include page="/adminTemplate/header.jsp"></jsp:include>

<!--영화 삭제시 알림 구현  -->
<script>
	$(function(){
		//삭제시 알림창 보여주기
		$(".delete").click(function(e){
			e.preventDefault();
			
			var check = window.confirm("영화를 삭제하시겠습니까?");
			if(check){
				location.href=$(this).attr("href");
			}
		});
		
		//전체선택 체크박스
		$("#checkall").click(function(){
			//클릭O
			if($("#checkall").prop("checked")){
				//각 체크박스 체크해주기
				$("input[name=chk]").prop("checked",true);
			}else{
				$("input[name=chk]").prop("checked",false);
			}
		});
	});
</script>

<div class="outbox" style="width: 100%">
	<aside>
		<div class="row center">
			<h2 style="color: deepskyblue;">영화 관리</h2>
		</div>
		<div class="left">
			<a href="movieList.jsp"> 영화리스트 </a><br><br> 
			<a href="movieInsert.jsp"> 영화 등록 </a><br><br> 
		</div>
	</aside>

	<article>
		<!-- 영화 검색창 -->
		<div>
			<h1>영화 리스트</h1>
		</div>
		<div>
			<form action="movieList.jsp" method="post">
				<label>영화 검색</label> 
				<select name="type">
					<option value="movie_no">영화 번호</option>
					<option value="movie_name">영화 제목</option>
				</select>
				<input type="text" name="key" placeholder="검색어를 입력하세요" required> 
				<input type="submit" value="검색">
			</form>
		</div>
 <%if(movieList.isEmpty()){ %> 
 <!-- 검색결과가 없는 경우 -->
		<div class="row center">
			<h1>검색결과가 없습니다.</h1>
		</div>
 <%}else{ %>	
<!-- 검색결과가 있는 경우 --> 
		<!--멤버 리스트 테이블  -->
		<div class="row">
			<table class="table table-border">
				<thead>
					<tr>
						<th><input type="checkbox" id="checkall">전체선택</th>
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
						<td><input type="checkbox" name="chk"></td>
						<td><%=movieDto.getMovie_no() %></td>
						<td><%=movieDto.getMovie_name() %></td>
						<td><%=movieDto.getMovie_date() %></td>
						<td><%=movieDto.getMovie_audience() %></td>
						<td>
							<a href="movieDetail.jsp?movie_no=<%=movieDto.getMovie_no()%>">상세보기</a>
						 	<a href="movieEdit.jsp?movie_no=<%=movieDto.getMovie_no()%>">수정</a>
						 	 <a class="delete" href="movieDelete.do?movie_no=<%=movieDto.getMovie_no()%>">삭제</a>
						</td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
 <%} %>		
		<!-- 선택된 회원 삭제버튼 -->
		<div class="right">
			<input type="button" value="선택된 영화 삭제" >
		</div>
		
		<!-- 페이지 네비게이션 -->
		<div class="row center">
			<ul class="pagination">
				

				<%if(search){ %>
				<li><a href="memberList?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
				<%}else{ %>
				<li><a href="memberList?p=<%=startBlock-1%>">&lt;</a></li>
				<%} %>
								

				<%for(int i=1; i<=10;i++){ %>
					<li>
						<%if(search){ %>
						<!-- 검색용 링크 -->
						<a href="movieList.jsp?p=1&type=<%=i%>&key=<%=key%>"><%=i %></a>
						<%}else{ %>
						<!-- 목록용 링크 -->
						<a href="movieList.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
					</li>	
				<%} %>

				<!-- 이후 -->
				<%if(search){ %>
				<li><a href="memberList.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
				<%}else{ %>
				<li><a href="memberLilst.jsp?p=<%=endBlock+1%>">&gt;</a></li>
				<%} %>
				
			</ul>
		</div>
	</article>
</div>


<jsp:include page="/adminTemplate/footer.jsp"></jsp:include>


