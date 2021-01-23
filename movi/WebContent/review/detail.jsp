<%@page import="java.text.SimpleDateFormat"%>
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
	int member_no = (int)session.getAttribute("check");
	MemberDto memberReplyDto = memberDao.find(member_no); //댓글창에 현재 로그인한 사용자의 닉네임을 가져오기 위한 DTO
	
	
	//조회수 증가(*중복방지 어케할지 고민)
	reviewDao.plusRead(review_no);
	
	
	

	ReplyDao replyDao = new ReplyDao();
	
	//댓글개수
	int count = replyDao.getCount(review_no);
	
	
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
 		
 		
 		//"답글쓰기"를 누르지않을때는 대댓글 작성란 숨김처리
 		$(".reply2-write").hide();
 		
 		
 		//"답글쓰기"를 누르면 대댓글 작성창을 보여준다.
 		$(".reply2-write-btn").click(function(e){
 			e.preventDefault();  		//기본이벤트 차단
 			
 			$(this).parent().parent().next().show();
 			
 		});
 		
 		//대댓글 등록 취소
 		$(".reply2-cancel-btn").click(function(e){
 			e.preventDefault();
 			
 			if($(this).parent().prev().children().val()) {
 				var confirm = window.confirm("이미 입력된 답글 내용을 취소 하겠습니까?");
 				
 				if(confirm) {
 	 				$(this).parents(".reply2-write").hide();
 	 	 			
 	 	 			$(this).parent().prev().children().val("");
 	 			}
 			}
 			else {
 				$(this).parents(".reply2-write").hide();
 			}
 	 			
 		});
 		
 		//"답글쓰기"를 누르지않을때는 대대댓글 작성란 숨김처리

 		$(".reply3-write").hide();
 		
 		//대댓글의 답글쓰기를 누르면 대대댓글 작성창을 보여준다.
 		
 		  
 		  $(".reply3-write-btn").click(function(e){
 			e.preventDefault();
 			
 			var nick = $(this).parent().prev().prev().children().text(); // 대댓글 작성한 사람 닉네임
 			
 			$(this).parent().parent().next().next().find("textarea").attr("placeholder", nick+"님께 답글쓰기");
 			
 			$(this).parent().parent().next().next().show();
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
 	<div class="outbox reply-list">
 		<div class="row">
 			<span>댓글 <%=count%></span>
 		</div>
 		<hr>
 		
 		
 		<%for(ReplyVO replyVO : replyList) { %>
 		<!-- 그냥 댓글 -->
 		<%if(replyVO.getReply_depth() == 0) { %>
 		<div class="row">
 			<div class="row" style="font-weight:bold;">
 				<%=replyVO.getMember_nick()%>
 			</div>
 			<div class="row">
 				<%=replyVO.getReply_content()%>
 			</div>
 			<div class="row">	
 				<%
	 				//댓글 시간 format 설정
	 				SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd. h:mm");
	 				String time = f.format(replyVO.getReply_time());
 				%>
 				<%=time%>
 				<a href="#" class="reply2-write-btn">답글쓰기</a>
 				<hr>
 			</div>
 		</div>
 		<!-- 대댓글 -->
 		<%} else if(replyVO.getReply_depth() == 1) { %>
 		<div class="row" style="margin-left:70px">
 			<div class="row" style="font-weight:bold;">
 				<span><%=replyVO.getMember_nick()%></span>
 			</div>
 			<div class="row">
 				<%=replyVO.getReply_content()%>
 			</div>
 			<div class="row">	
 				<%
	 				//댓글 시간 format 설정
	 				SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
	 				String time = f.format(replyVO.getReply_time());
 				%>
 				<%=time%>
 				<a href="#" class="reply3-write-btn">답글쓰기</a>
 				<hr>
 			</div>
 		</div>	
 		<%} %>
 		<!-- 대대댓글 -->
 		
 		
 		
 		
 			
		<!-- 대댓글 작성 -->
 		<div class="row reply2-write">
 			<form action="reply_write2.do" method="post">
	 			<div class="row" style="min-height:100px; border: 1px solid black;">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_root" value="<%=replyVO.getReply_no()%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
	 				</div>
	 				
	 				
	 				<div class="row right">
	 					<button class="reply2-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline">
	 				</div>
	 			</div>
 			</form>
 			<hr>
 		</div>
		
		
		 		
 		<!-- 대대댓글 작성 -->
 		
 		<div class="row reply3-write">
 			<form action="reply_write3.do" method="post">
	 			<div class="row" style="min-height:100px; border: 1px solid black;">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_root" value="<%=replyVO.getReply_no()%>">
	 				 <input type="hidden" name="reply_parent" value=>
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply3-text" rows="3" style="border:0"></textarea>
	 				</div>
	 				
	 				
	 				<div class="row right">
	 					<button class="reply3-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline">
	 				</div>
	 			</div>
 			</form>
 			<hr>
 		</div>
 		
	 		
 		<%} %>
 		
 		
 		
 		
 		<!-- 댓글 작성 -->
 		
 		<div class="row" style="border: 1px solid black;">
 			<form action="reply_write.do" method="post">
	 			<div class="row" style="min-height:100px">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%>  
	 				</div>
	 				<textarea name="reply_content" class="input" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
	 			</div>
	 			
	 			<div class="row right">
	 				<input type="submit" value="등록" class="input input-inline">
	 			</div>
 			</form>
 		</div>
 		
 	</div>
 		
 	
 </div>
 
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>