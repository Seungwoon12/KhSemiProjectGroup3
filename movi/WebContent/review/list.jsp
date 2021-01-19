<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>    
    
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
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
// 	type : 분류 , key : 검색어
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	
	ReviewDao reviewDao = new ReviewDao();
	List<ReviewDto> list = reviewDao.select(); 

%>   

   
<jsp:include page="/template/header.jsp"></jsp:include>

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
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(ReviewDto reviewDto : list) { %>
				<tr>
					<td><%=reviewDto.getReview_no() %></td>
					<td>
						<a href="detail.jsp?review_no=<%=reviewDto.getReview_no()%>">
							<%=reviewDto.getReview_title() %>
						</a>
					</td>
					<td><%=reviewDto.getReview_writer_no()%></td>
					<td><%=reviewDto.getReview_date() %></td>
					<td><%=reviewDto.getReview_read() %></td>
				</tr>
				<%} %>
			</tbody>
			
			<tfoot>
			
			</tfoot>
		</table>
	</div>
	
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	
	
	
	<!-- 페이지 네비게이션 -->
	<div class=row center>
		
	
	
	
	</div>


	
	
	<!-- 검색창 -->
	<div class="row center">
		<form action="list.jsp" method="post">
			<div>
				<select name="type" class="input input-inline">
					<option>제목+내용</option>
					<option value="review_title">제목</option>
					<option value="review_content">내용</option>
				</select>
				<input type="text" name="key" class="input input-inline">
				<input type="submit" value="검색" class="input input-inline">
			</div>
		</form>
	</div>
	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>