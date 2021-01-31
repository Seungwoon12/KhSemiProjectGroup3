<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>    
    
<%
	request.setCharacterEncoding("UTF-8");

	//조회수 방지위해 기록했던 review_no 세션 제거
	session.removeAttribute("review_no");
	//관리자 공지사항용
	session.removeAttribute("notice_no");
	
%>

<%
	//페이지당 보여줄 게시글 목록 개수
	int reviewSize = 15;
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
    	
    	//댓글작성자 검색을 위한 처리
    	int reply_writer_no = 0; //초기화
   			
    		
    		
    	//게시글 목록 구하기
    	List<ReviewVO> list; 
    	//type이 댓글작성자를 제외한 검색일 경우 목록	
    	if(isSearch && !type.equals("reply_writer_no")) {
    		list = reviewDao.list(type, key, startRow, endRow);
    	}
    	//type이 댓글작성자인 검색일 경우 목록
    	else if(isSearch && type.equals("reply_writer_no")) {
    		//key값으로 정확히 일치하는 닉네임을 입력안하면 review_writer_no를 구할 수 없기 때문에 검색 결과가 안나옴
    		reply_writer_no = reviewDao.getWriterNo(key); 
    		list = reviewDao.list(type, reply_writer_no, startRow, endRow);
    	}
    	//검색어가 없을 경우 목록
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
   	
   	//목록 개수 or 검색 개수(영화명, 제목, 내용, 글작성자, 댓글내용, 댓글작성자)
   	int count;
   	
   	if(isSearch) {
			//댓글내용 검색시 게시글 개수   			
   			if(type.equals("reply_content")) {
   				count = reviewDao.countForReply(type, key);
   			}
			//영화명 검색시 게시글 개수
   			else if(type.equals("movie_name")) {
   				count = reviewDao.countForMovie(type, key);
   			}
			//댓글작성자 검색시 게시글 개수
   			else if(type.equals("reply_writer_no")) {
   				count = reviewDao.countForReplyWriter(reply_writer_no);
   			}
			//제목, 내용, 글작성자
   			else {
   				count = reviewDao.count(type, key);
   			}
   	}
   	else {
   		count = reviewDao.count();
   	}
   	
   	// 필요한 페이지 개수
   	// 페이지당 15개씩 보여주는거라 수정
   	int pageSize; 
   	if(count % reviewSize == 0) {
   		pageSize = count / reviewSize;
   	}
   	else {
   		pageSize = count / reviewSize +1;
   	}
   	
   	//페이지 마지막번호가 필요한 페이지 개수보다 클 경우 페이지 마지막번호를 필요한 페이지 개수로 설정해준다.
   	if(endNum > pageSize) {
   		endNum = pageSize;
   	}
 %>
 
 <%
  	//관리자용 공지 및 필독 게시글 출력을 위해 불러오기
    		List<NoticeVO> noticeList = reviewDao.selectNotice();
    		String auth;
    		if(session.getAttribute("auth") == null) {
    			auth = "";
    		}
    		else {
    			auth = (String)session.getAttribute("auth");
    		}
    		
    	 	boolean isAdmin = auth.equals("관리자");
  %>

   
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	.write-btn, .search-btn, .notice-btn{
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
		
		//글쓰기 버튼 클릭시 작성페이지로 이동
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
		
		//공지사항 글쓰기 이동
		$(".notice-btn").click(function(){
			
			location.href = "<%=request.getContextPath()%>/review/noticeWrite.jsp";
			
		});		
	});
</script>    

<div class="outbox" style="width:1100px">
	<div class="row center">
		<h2>당신이 본 영화에 대해 다른 사람들과 자유롭게 얘기해보세요!</h2>
	</div>
	<div class="row right">
	<%
		if(isAdmin) {
	%>
		<button class="notice-btn input input-inline">관리자</button>
	<%
		}
	%>	
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
			<!-- 관리자 게시판 -->
			<%if(p == 1 && !isSearch) {%>
			
			<%for(NoticeVO noticeVO : noticeList) {%>
			
				<tr style="background-color:#d8e0ed;">
					<td><%=noticeVO.getNotice_header()%></td>
					<td></td>
					<td>
						<a href="noticeDetail.jsp?notice_no=<%=noticeVO.getNotice_no()%>">
							<%=noticeVO.getNotice_title()%>
							<%if(noticeVO.getReply_count() > 0) { %>
							[<%=noticeVO.getReply_count()%>]
							<%} %>
						</a>
					</td>
					<td><%=noticeVO.getAdmin_nick()%></td>
					<td><%=noticeVO.getNotice_date()%></td>
					<td><%=noticeVO.getNotice_read()%></td>
				</tr>
			<%} %>
			<%} %>
				<!-- 리뷰 게시판 -->
			    <%for(ReviewVO reviewVO : list) { %>
				<tr>
					<td><%=reviewVO.getReview_no() %></td>
					<td><%=reviewVO.getMovie_name()%></td>
					<td>
						<a href="detail.jsp?review_no=<%=reviewVO.getReview_no()%>&p=<%=p%>">
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
			<%if(list.isEmpty()) { %>
				<h3>등록된 게시글이 존재하지 않습니다.</h3>
			<%} %>	
	</div>
	
	
	<div class="row right">
	<%if(isAdmin) { %>
		<button class="notice-btn input input-inline">관리자</button>
	<%} %>	
		<button class="write-btn input input-inline">글쓰기</button>
	</div>
	
	
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="paginav center">
			<%if(!list.isEmpty() && startNum != 1) { %> <!-- 목록이 있으면서 페이지네비게이션의 첫번째단이 아닐때만 '< 이전' 보여줘라 -->
			<li>
			<%if(isSearch) { %>
				<a href="list.jsp?p=<%=startNum-1%>&type=<%=type%>&key=<%=key%>">	
			<%} else { %>
				<a href="list.jsp?p=<%=startNum-1%>">
			<%} %>
				&lt; 이전</a>
			</li>
			<%} %>
			
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
			
			<%if(!list.isEmpty() && endNum != pageSize) { %> <!-- 목록이 있으면서 페이지네비게이션의 마지막단이 아닐때만 '다음 >' 보여줘라 -->
			<li>
			<%if(isSearch) { %>
					<a href="list.jsp?p=<%=endNum+1%>&type=<%=type%>&key=<%=key%>">
			<%} else { %>
					<a href="list.jsp?p=<%=endNum+1%>">
				<%} %>
				다음 &gt;</a>
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