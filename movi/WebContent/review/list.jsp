<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>    
    
<%
	request.setCharacterEncoding("UTF-8");
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
	
	ReviewDao reviewDao = new ReviewDao();
	List<ReviewNickVO> list; 
	if(isSearch) {
		list = reviewDao.list(type, key, startRow, endRow);
	}
	else {
		list = reviewDao.list(startRow, endRow);
	}
	
%>   


<%
	//페이지 네비게이션 작성
	
	//페이지 네비게이션 사이즈 10
	int pageNavSize = 10;
	
	//시작번호, 끝번호 계산
	int startNum = (p-1) / pageNavSize * pageNavSize + 1;
	int endNum = startNum + pageNavSize - 1;
	
	//목록 개수 or 검색 개수
	int count;
	
	if(isSearch) {
		count = reviewDao.count(type, key);
	}
	else {
		count = reviewDao.count();
	}
	
	// 필요한 페이지 개수
	int pageSize = (count + pageNavSize - 1) / pageNavSize;
	
	//페이지 마지막번호가 필요한 페이지 개수보다 클 경우 페이지 마지막번호를 필요한 페이지 개수로 설정해준다.
	if(endNum > pageSize) {
		endNum = pageSize;
	}


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
				<%for(ReviewNickVO reviewNickVO : list) { %>
				<tr>
					<td><%=reviewNickVO.getReview_no() %></td>
					<td>
						<a href="detail.jsp?review_no=<%=reviewNickVO.getReview_no()%>">
							<%=reviewNickVO.getReview_title() %>
						</a>
					</td>
					<td><%=reviewNickVO.getMember_nick()%></td>
					<td><%=reviewNickVO.getReview_date() %></td>
					<td><%=reviewNickVO.getReview_read() %></td>
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
		<ul class="pagination center">
			<li>
			<%if(isSearch) { %>
				<a href="list.jsp?p=<%=startNum-1%>&type=<%=type%>&key=<%=key%>">	
			<%} else { %>
				<a href="list.jsp?p=<%=startNum-1%>">
			<%} %>
				&lt;</a>
			</li>
			
			<%for(int i=startNum; i <= endNum; i++) {%>
			<%if(p == i) { %>
			<li class="active">
			<%} else {%>
			<li>
			<%} %>
				<%if(isSearch) { %>
				<a href="list.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
				<%} else { %>
				<a href="list.jsp?p=<%=i%>"><%=i%></a>		
				<%} %>
			</li>
			
			<%} %>
			
			<li>
			<%if(isSearch) { %>
				<a href="list.jsp?p=<%=endNum+1%>&type=<%=type%>&key=<%=key%>">
			<%} else { %>
				<a href="list.jsp?p=<%=endNum+1%>">
			<%} %>
				&gt;</a>
			</li>
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