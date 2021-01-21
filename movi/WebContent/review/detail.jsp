<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>

<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));
	
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.find(review_no);
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(reviewDto.getReview_writer_no());
	
	MovieDaoSW movieDaoSW = new MovieDaoSW();
	MovieDto movieDto = movieDaoSW.find(reviewDto.getReview_movie_no());
	
	
	//댓글 작성란에 닉네임 불러오기
	//int member_no = (int)request.getSession().getAttribute("check");
	//MemberDto memberReplyDto = memberDao.find(member_no); //댓글창에 현재 로그인한 사용자의 닉네임을 가져오기 위한 DTO
	
	
	ReplyDao replyDao = new ReplyDao();
	
	//댓글개수
	int count = replyDao.getCount(review_no);
	
	//댓글 시간 format 설정
	
			
	//댓글 목록 출력
	List<ReplyVO> replyList = replyDao.selectReply(review_no);
	
	

%>



 <jsp:include page="/template/header.jsp"></jsp:include>
 
 
<style>
	textarea{
		resize:none;
	}

</style>



 <script>
 	$(function(){
 		//수정버튼 클릭하면 해당 게시글 수정페이지로 이동
 		$(".review-edit-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/edit.jsp?review_no=<%=review_no%>";
 		});
 		
 		//삭제버튼 클릭하면 삭제
		$(".review-delete-btn").click(function(){
			
			var confirm = window.confirm("정말로 삭제하시겠습니까?");
			if(confirm) {
				location.href = "<%=request.getContextPath()%>/review/delete.do?review_no=<%=review_no%>";
			}
			
		}); 		
 		
 	});
 
 </script>
 
 <div class="outbox" style="width:800px">
 	<div class="row">
 		<button class="review-edit-btn">수정</button>
 		<button class="review-delete-btn">삭제</button>
 	</div>
 	<br>
 	
 	<hr>
 		
 	<div class="row">
 		<h2><%=reviewDto.getReview_title()%></h2>
 	</div>
 	
 	<hr>
	<div class="row" style="min-height:300px">
		<div class="row right">	
			<span><%=memberDto.getMember_nick()%></span> |
			<span><%=reviewDto.getReview_read()%></span>  |
			<span><%=reviewDto.getReview_date()%></span>
 		</div>
 	
		<div class="row">
			<span>영화명: <%=movieDto.getMovie_name()%></span>
		</div>
 		
 		<br>
 		<div class="row" >
 			<%=reviewDto.getReview_content()%>
 		</div>
	
	</div>
 	
 	
 	<!-- 댓글 목록-->
 	<br><br>
 	<div class="outbox">
 		<div class="row">
 			<span>댓글 <%=count%></span>
 		</div>
 		<hr>
 		
 		
 		<%for(ReplyVO replyVO : replyList) { %>
 			<div class="row">
 				<%=replyVO.getMember_nick()%>
 				<%=replyVO.getReply_content()%>
 			</div>
 			
 			
 		<%} %>
 		
 		<hr>
 		
 		<!-- 댓글 작성 -->
 		<div class="row" style="border: 1px solid black;">
 			<form action="reply_write.do" method="post">
	 			<div class="row" style="min-height:100px">
	 				<!-- 
	 				<input type="hidden" name="reply_writer_no" value="<//%=//request.getSession().getAttribute("check")%>">
	 				 -->
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					닉네임
	 					<!--<//%=memberReplyDto.getMember_nick()%> --> 
	 				</div>
	 				<textarea name="reply_content" class="input" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
	 			</div>
	 			
	 			<div class="row right">
	 				<input type="submit" value="등록" class="input input-inline">
	 			</div>
 			</form>
 		</div>
 		
 		
 		</form>
 	</div>
 	
 </div>
 
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>