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
	.write-btn, .search-btn, .admin-btn{
		font-size: 16px;
		padding:0.5rem;
		background-color:#4E6FA6;
		color:white;
		border-radius:4px;
		border:none;
		cursor:pointer;
	}
	
	.swTable{
	width: 100%;
    border-spacing: 0;
    border-top: 1px solid #444444;
    border-collapse: collapse;
	
}
	.swTable a{
		 text-decoration: none;
         color: black;
	}
	.swTable a:hover{
		text-decoration: underline;
	}

 .swTable td {
 	padding: 0.5rem;
    text-align: center;
    border-bottom: 1px solid lightgray;
  }
  
 .swTable th{
 	padding: 0.5rem;
    text-align: center;
 	border-bottom: 1px solid #444444;
 	background-color:#4E6FA6;
 	color:white;
 } 
  
  .search-box{
  	border:1px solid lightgray;
  	height:36px;
  }
  
  
 .paginav {
    margin:0;
    padding:0;
    list-style: none;
}
.paginav > li {
    display:inline-block;
    padding:0.1rem;
    min-width:2rem;
    text-align: center;
    /*border:1px solid transparent;*/
}
.paginav > li.active {
    /*border:1px solid gray;*/
    cursor: pointer;
    box-shadow: 0px 0px 0px 1px lightgray;
}

.paginav > li > a {
    text-decoration: none;
    
}
.paginav > li > a:hover{
	text-decoration: underline;
}
</style>

<script>
	$(function(){
		
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/review/write.jsp";
			
		});
		
		//헤더에 리뷰게시판 클릭했을때 볼드처리 및 언더라인
		$("nav>a:nth-child(3)").addClass("navstyle");
		
		
		//검색창에 검색어 없이 '검색' 눌렀을때 알림창+커서표시
		$(".search-btn").click(function(){
			
			if(!$(".search-box").val()) {
				alert("검색어를 입력하세요.");
				$(".search-box").focus();
				return	false;
					
			}
		  
		});
		
		//페이징에서 클릭한 페이지번호 글자색 설정
		$(".active > a").attr("style", "color:blue");	
		
		//어드민 글쓰기 이동
		$(".admin-btn").click(function(){
			
			location.href = "<%=request.getContextPath()%>/review/adminWrite.jsp";
			
		});		
		
	});
</script>    

<div class="outbox" style="width:1100px">
	<div class="row center">
		<h2>당신이 본 영화에 대해 다른 사람들과 자유롭게 얘기해보세요!</h2>
	</div>
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	<div class="row center">
		<table class="swTable">
			<thead>
				<tr>
					<th>글번호</th>
					<th width="20%">영화명</th>
					<th width="30%">제목</th>
					<th width="18%">작성자</th>
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
				<h3>리뷰가 존재하지 않네요.. 가장 먼저 리뷰를 등록해보세요!</h3>
			<%} %>	
	</div>
	
	
	<div class="row right">
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	
	
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="paginav center">
			<%if(!detailList.isEmpty() && startNum != 1) { %>
			<li>
				<a href="listForDetail.jsp?movie_no=<%=movie_no%>&p=<%=startNum-1%>">&lt; 이전</a>
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
			
			<%if(!detailList.isEmpty() && endNum != pageSize) { %>
			<li>
				<a href="listForDetail.jsp?movie_no=<%=movie_no%>&p=<%=endNum+1%>">다음 &gt;</a>
			</li>
			<%} %>
		</ul>
	
	
	
	</div>

	
	
	<!-- 검색창 -->
	<div class="row center" style="margin-top:20px">
		<form action="list.jsp" method="post">
			<div>
				<select name="type" class="input input-inline search-select">
					<option value="movie_name" <%if(type != null && type.equals("movie_name")) { %> selected <% } %>>영화명</option>
					<option value="review_title" <%if(type != null && type.equals("review_title")) { %> selected <% } %>>제목</option>
					<option value="review_content" <%if(type != null && type.equals("review_content")) { %> selected <% } %>>내용</option>
					<option value="member_nick"<%if(type != null && type.equals("member_nick")) {%> selected <%} %>>글작성자</option>
					<option value="reply_content"<%if(type != null && type.equals("reply_content")) { %> selected <%} %>>댓글내용</option>
					<option value="reply_writer_no"<%if(type != null && type.equals("reply_writer_no")) { %> selected <%} %>>댓글작성자</option>
				</select>
				<%if(isSearch) { %>
				<input type="text" name="key" class="input input-inline search-box" value="<%=key%>">
				<%} else { %>
				<input type="text" name="key" class="input input-inline search-box" placeholder="검색어를 입력해주세요">
				<%} %>
				
				<input type="submit" value="검색" class="input input-inline search-btn">
			</div>
		</form>
	</div>
	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>	