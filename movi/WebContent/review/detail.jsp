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


%>


 <jsp:include page="/template/header.jsp"></jsp:include>
 
 
<style>
	textarea{
		resize:none;
	}

</style>



 <script>
 	$(function(){
 		$(".review-edit-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/edit.jsp?review_no=<%=review_no%>";
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

 	<div class="row">
 		<span><%=memberDto.getMember_nick()%></span> |
 		<span><%=reviewDto.getReview_read()%></span>  |
 		<span><%=reviewDto.getReview_date()%></span>
 	</div>
 	<br>
 	
 	<div class="row">
 		<%=reviewDto.getReview_content()%>
 	</div>
 	
 	<!-- 댓글 -->
 	<br><br>
 	<div class="outbox">
 		<div>
 			<span>댓글</span>
 		</div>
 		
 			
 		<div class="row" style="border: 1px solid black;">
 			<div class="row" style="min-height:100px">
 				<div style="margin-left:0.3rem">
 					닉네임
 				</div>
 				<textarea class="input" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
 			</div>
 			
 			<div class="row right">
 				<input type="submit" value="등록" class="input input-inline">
 			</div>
 			
 		</div>
 		
 		
 		</form>
 	</div>
 	
 </div>
 
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>