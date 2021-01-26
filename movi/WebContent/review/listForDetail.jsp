<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>    
    
<%
	request.setCharacterEncoding("UTF-8");

	//조회수 방지위해 기록했던 review_no 세션 제거
	session.removeAttribute("review_no");
	
	
%>

<%
	//페이지당 보여줄 게시글 목록 개수
	int reviewSize = 10;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * reviewSize;
	int startRow = endRow - reviewSize + 1;
%>    


<%
    	// 목록과 검색
    	// type : 분류 , key : 검색어
    	String type = request.getParameter("type");
    	String key = request.getParameter("key");
    	boolean isSearch = type != null && key != null;
    	
    //카테고리 영화 상세페이지에서 리뷰로 넘어올때 movie_no 받아와야함
	int movie_no = Integer.parseInt(request.getParameter("movie_no"));
    	
    	//영화 상세페이지에서 들어올때 리뷰 목록
    	
    	ReviewDao reviewDao = new ReviewDao();
    	List<ReviewVO> detailList = reviewDao.detailList(movie_no, startRow, endRow); 
    	
%>   


<%
   	//페이지 네비게이션 작성
   	
   	//페이지 네비게이션 사이즈 10
   	int pageNavSize = 10;
   	
   	//시작번호, 끝번호 계산
   	int startNum = (p-1) / pageNavSize * pageNavSize + 1;
   	int endNum = startNum + pageNavSize - 1;
   	
   	//목록 개수 or 검색 개수
   	int count = reviewDao.detailCount(movie_no);
   	
   	
   	// 필요한 페이지 개수
   	int pageSize = (count + pageNavSize - 1) / pageNavSize;
   	
   	//페이지 마지막번호가 필요한 페이지 개수보다 클 경우 페이지 마지막번호를 필요한 페이지 개수로 설정해준다.
   	if(endNum > pageSize) {
   		endNum = pageSize;
   	}
   %>

   
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	.table a{
		 text-decoration: none;
         color: black;
	}
	.table a:hover{
		text-decoration: underline;
	}
</style>

<script>
	$(function(){
		
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/review/write.jsp";
			
		});
		
	});
</script>    

<div class="outbox">
	<div class="row center">
		<h2>당신이 본 영화에 대해 다른 사람들과 자유롭게 얘기해보세요!</h2>
	</div>
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	<div class="row center">
		<table class="table table-border">
			<thead>
				<tr>
					<th>글번호</th>
					<th>영화명</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
			</thead>
			
			<tbody>
				
			    <%for(ReviewVO reviewVO : detailList) { %>
				<tr>
					<td><%=reviewVO.getReview_no() %></td>
					<td><%=reviewVO.getMovie_name()%></td>
					<td>
						<a href="detailForDetail.jsp?review_no=<%=reviewVO.getReview_no()%>&movie_no=<%=movie_no%>&p=<%=p%>">
							<%=reviewVO.getReview_title() %>
							<%if(reviewVO.getReply_count() > 0) { %>
								[<%=reviewVO.getReply_count() %>]
							<%} %>
						</a>
					</td>
					<td><%=reviewVO.getMember_nick()%></td>
					<td><%=reviewVO.getReview_date() %></td>
					<td><%=reviewVO.getReview_read() %></td>
				</tr>
				<%} %>
				
			</tbody>
			
			<tfoot>
			
			</tfoot>
		</table>
	</div>
	
	<div class="row center">
			<%if(detailList.isEmpty()) { %>
				<h3>등록된 게시글이 존재하지 않습니다.</h3>
			<%} %>	
	</div>
	
	
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	
	
	
	<!-- 페이지 네비게이션 -->
	<div class=row center>
		<ul class="pagination center">
			<%if(!detailList.isEmpty()) { %>
			<li>
				<a href="listForDetail.jsp?movie_no=<%=movie_no%>&p=<%=startNum-1%>">&lt;</a>
			</li>
			<%} %>
			
			<%for(int i=startNum; i <= endNum; i++) {%>
			<%if(p == i) { %>
			<li class="active">
			<%} else {%>
			<li>
			<%} %>
				<a href="listForDetail.jsp?movie_no=<%=movie_no%>&p=<%=i%>"><%=i%></a>		
			</li>
			<%} %>
			
			<%if(!detailList.isEmpty()) { %>
			<li>
				<a href="listForDetail.jsp?movie_no=<%=movie_no%>&p=<%=endNum+1%>">&gt;</a>
			</li>
			<%} %>
		</ul>
	
	
	
	</div>

	
	
	<!-- 검색창 -->
	<div class="row center">
		<form action="list.jsp" method="post">
			<div>
				<select name="type" class="input input-inline">
					<option>제목+내용</option>
					<option value="review_title" <%if(type != null && type.equals("review_title")) { %> selected <% } %>>제목</option>
					<option value="review_content" <%if(type != null && type.equals("review_content")) { %> selected <% } %>>내용</option>
				</select>
				<%if(isSearch) { %>
				<input type="text" name="key" class="input input-inline" value="<%=key%>">
				<%} else { %>
				<input type="text" name="key" class="input input-inline">
				<%} %>
				
				<input type="submit" value="검색" class="input input-inline">
			</div>
		</form>
	</div>
	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>	