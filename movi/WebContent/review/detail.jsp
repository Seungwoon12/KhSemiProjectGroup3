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
	
	ReplyDao replyDao = new ReplyDao();
	
	//댓글개수
	int count = replyDao.getCount(review_no);
	
	
	//댓글 목록 출력
	List<ReplyVO> replyList = replyDao.selectReply(review_no);
	
	
	//목록에서 들어올때 해당 게시글이 몇페이지에 있는지 파라미터로 받기
	int p = Integer.parseInt(request.getParameter("p"));
	
	
	//작성자본인 및 운영자인지 확인작업
	String auth = (String)session.getAttribute("auth");
	boolean isAdmin = auth.equals("관리자");
	
	boolean isWriter = reviewDto.getReview_writer_no() == member_no;
	
	
	
	//조회수 중복방지(게시글번호 세션에 저장)
		if(!isWriter && session.getAttribute("review_no") == null) {
			session.setAttribute("review_no", review_no);
			reviewDao.plusRead(review_no);
		}
			
	
%>



 <jsp:include page="/template/header.jsp"></jsp:include>
 
 
<style>
	textarea{
		resize:none;
	}
	
	.reply-list a {
		text-decoration: none;
        color: black;
	}
</style>



 <script>
 	$(function(){
 		//수정버튼 클릭하면 해당 게시글 수정페이지로 이동
 		$(".review-edit-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/edit.jsp?review_no=<%=review_no%>&p=<%=p%>";
 		});
 		
 		//삭제버튼 클릭하면 삭제
		$(".review-delete-btn").click(function(){
			
			var confirm = window.confirm("정말로 삭제하시겠습니까?");
			if(confirm) {
				location.href = "<%=request.getContextPath()%>/review/delete.do?review_no=<%=review_no%>";
			}
			
		}); 		
 		
 		//목록버튼 클릭하면 목록으로 이동
 		$(".review-list-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/list.jsp?p=<%=p%>";
 			
 		});
 		
 		
//-------------------------------댓글 관련----------------------------------------------- 		
 		
 		//댓글 null값 방지
 		$(".reply-regist-btn").click(function(e){
 			if(!$(".reply-area").val()) {
 				e.preventDefault();
 				window.alert("내용을 입력해주세요");
 			}
 			
 		});
 		
 		
 		//댓글 수정란 숨김처리
 		$(".reply-edit").hide();
 		
 		
 		//댓글 수정란 보여주기
 		$(".reply-edit-btn").click(function(e){
 			e.preventDefault();
 			
 			$(this).parent().parent().hide();
 			$(this).parent().parent().next().next().show();
 			
 		});
 		
 		//댓글 수정란 취소버튼클릭시 설정
 		$(".reply-edit-cancel-btn").click(function(e){
 			e.preventDefault();
 			
 			var original = $(this).parent().prev().find(".reply-original-content").val();
 			//var original = $(this).parent().prev().children().next().val();
 			
 			var newContent = $(this).parent().prev().find(".reply-edit-area").val();
 			//var newContent = $(this).parent().prev().children().val();
 			
 			
 			if(original != newContent) { //!=랑 !==랑 둘 다 적용되긴 하는듯..
 				var confirm = window.confirm("내용 입력을 취소하시겠습니까?");
 				if(confirm){
 					$(this).parent().parent().parent().parent().hide();
 					$(this).parent().prev().children().val(original);
 					$(this).parent().parent().parent().parent().prev().prev().show();
 				}
 					
 			}
 			else{
 				
				$(this).parent().parent().parent().parent().hide();
 				$(this).parent().parent().parent().parent().prev().prev().show();
 			}
 				
 		});
 		
 		//댓글수정 null값 방지
		$(".reply-edit-regist-btn").click(function(e){
 			
 			if(!$(this).parent().prev().find(".reply-edit-area").val()) {
 				e.preventDefault();
 				window.alert("내용을 입력해주세요");
 			}
 		});
 		
 		//댓글삭제진행
 		//$(".reply-delete-btn").click(function(e){
 			//e.preventDefault();
 			
 			//var replyNo = $(this).next().val();
 			
 			//데이터베이스에서 지울 필요가 없음 삭제된 댓글이란걸 보여줄거라서
 			
 			//삭제알림창
 			//var confirm = window.confirm("댓글을 삭제하시겠습니까?");
 			
 			//if($(this).parent().parent().next().next().next().hasClass(".reply2")) {
 				//안에 내용 지우고 삭제됐다고 보여준다.
 				//if(confirm) {
 	 				//$(this).parent().parent().empty();
 	 				//$("<span>삭제된 댓글입니다.</span>")appendTo($(this).parent().parent());
 	 			//}
 			//}
 			//else{
 				//if(confirm) {
 					//location.href = "reply_delete.do?review_no="+review_no+"&p="+p+"&reply_no="+replyNo;
 				//}
 			//}
 			
 				
 		//});
 		
 		
 		
 		
 		
 	
 //------------------------------------------------까지 댓글 관련----------------		
	
 		
 		
 		//"답글쓰기"를 누르지않을때는 대댓글 작성란 숨김처리
 		$(".reply2-write").hide();
 		
 		
 		
 		
 		//"답글쓰기"를 누르면 대댓글 작성창을 보여준다.
 		$(".reply2-write-btn").click(function(e){
 			e.preventDefault();  		//기본이벤트 차단
 			
 			$(this).parent().parent().next().show();
 			
 		});
 		
 		//대댓글 null값 방지
		$(".reply2-regist-btn").click(function(e){
 			
 			if(!$(this).parent().prev().children().val()) {
 				e.preventDefault();
 				window.alert("내용을 입력해주세요");
 			}
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

 		//대댓글 수정란 숨김처리
 		$(".reply2-edit").hide();
 		
 		//대댓글 수정란 보여주기
 		$(".reply2-edit-btn").click(function(e){
 			e.preventDefault();
 			
 			$(this).parent().parent().hide();
 			$(this).parent().parent().next().next().show();
 			
 		});
 		
 		//대댓글 수정란 취소버튼클릭시 설정
 		$(".reply2-edit-cancel-btn").click(function(e){
 			e.preventDefault();
 			
 			var original = $(this).parent().prev().find(".reply2-original-content").val();
 			//var original = $(this).parent().prev().children().next().val();
 			
 			var newContent = $(this).parent().prev().find(".reply2-edit-area").val();
 			//var newContent = $(this).parent().prev().children().val();
 			
 			
 			if(original != newContent) { //!=랑 !==랑 둘 다 적용되긴 하는듯..
 				var confirm = window.confirm("내용 입력을 취소하시겠습니까?");
 				if(confirm){
 					$(this).parent().parent().parent().parent().hide();
 					$(this).parent().prev().children().val(original);
 					$(this).parent().parent().parent().parent().prev().prev().show();
 				}
 					
 			}
 			else{
 				
				$(this).parent().parent().parent().parent().hide();
 				$(this).parent().parent().parent().parent().prev().prev().show();
 			}
 				
 		});
 		
 		//대댓글수정 null값 방지
		$(".reply2-edit-regist-btn").click(function(e){
 			
 			if(!$(this).parent().prev().find(".reply2-edit-area").val()) {
 				e.preventDefault();
 				window.alert("내용을 입력해주세요");
 			}
 		});
 		
 		
 //--------------------까지 대댓글 관련----------------------------------------------------
 		
 		
 		
 		//"답글쓰기"를 누르지않을때는 대대댓글 작성란 숨김처리
 		$(".reply3-write").hide();
 		
 		
 		//대댓글의 답글쓰기를 누르면 대대댓글 작성창을 보여준다.
 		  $(".reply3-write-btn").click(function(e){
 			e.preventDefault();
 			
 			// 대댓글 작성한 사람 닉네임 불러와서 작성창 placeholder에 등록
 			var nick = $(this).parent().prev().prev().children("span:eq(0)").text(); 
 			$(this).parent().parent().next().find(".reply3-area").attr("placeholder", nick+"님께 답글쓰기");
 			
 			//대댓글의 reply_root(댓글의 reply_no)를 대대댓글의 input name이 reply_root 인 것 한테 넣기 
 			var replyRoot = $(this).next().val();
 			
 			$(this).parent().parent().next().find("input[name=reply_root]").val(replyRoot);
 			
 			
 			//작성란 보여주기
 			$(this).parent().parent().next().show();
 		});
 		
 		
 		
 			//대대댓글 null값 방지
 			$(".reply3-regist-btn").click(function(e){
 	 			if(!$(this).parent().prev().children().val()) {
 	 				e.preventDefault();
 	 				window.alert("내용을 입력해주세요");
 	 			}
 	 			
 	 		});
 		
 		
 		//대대댓글 등록취소
 		 $(".reply3-cancel-btn").click(function(e){
  			e.preventDefault();
  			
  			if($(this).parent().prev().children().val()) {
  				var confirm = window.confirm("이미 입력된 답글 내용을 취소 하겠습니까?");
  				
  				if(confirm) {
  	 				$(this).parents(".reply3-write").hide();
  	 	 			
  	 	 			$(this).parent().prev().children().val("");
  	 			}
  			}
  			else {
  				$(this).parents(".reply3-write").hide();
  			}
  	 			
  		});
 		
 		//대대댓글 수정란 숨김처리
  		$(".reply3-edit").hide();
  		
  		//대대댓글 수정란 보여주기
  		$(".reply3-edit-btn").click(function(e){
  			e.preventDefault();
  			
  			$(this).parent().parent().hide();
  			$(this).parent().parent().next().next().show();
  			
  		});
  		
  		//대대댓글 수정란 취소버튼클릭시 설정
  		$(".reply3-edit-cancel-btn").click(function(e){
  			e.preventDefault();
  			
  			var original = $(this).parent().prev().find(".reply3-original-content").val();
  			//var original = $(this).parent().prev().children().next().val();
  			
  			var newContent = $(this).parent().prev().find(".reply3-edit-area").val();
  			//var newContent = $(this).parent().prev().children().val();
  			
  			
  			if(original != newContent) { //!=랑 !==랑 둘 다 적용되긴 하는듯..
  				var confirm = window.confirm("내용 입력을 취소하시겠습니까?");
  				if(confirm){
  					$(this).parent().parent().parent().parent().hide();
  					$(this).parent().prev().children().val(original);
  					$(this).parent().parent().parent().parent().prev().prev().show();
  				}
  					
  			}
  			else{
  				
 				$(this).parent().parent().parent().parent().hide();
  				$(this).parent().parent().parent().parent().prev().prev().show();
  			}
  				
  		});
  		
  		//대대댓글수정 null값 방지
 		$(".reply3-edit-regist-btn").click(function(e){
  			
  			if(!$(this).parent().prev().find(".reply3-edit-area").val()) {
  				e.preventDefault();
  				window.alert("내용을 입력해주세요");
  			}
  		});
 		
 		
 		
 //------------------------------------------까지 대대댓글-------------------------------------
 
 
 
 		
 		//reply4-write-btn 대대댓글에 답글쓸때부터는 쭉 이걸로
 		$(".reply4-write-btn").click(function(e){
 			e.preventDefault();
 			
 			var nick = $(this).prev().val();
 			$(this).parent().parent().next().find(".reply3-area").attr("placeholder", nick+"님께 답글쓰기");
 			
 			//replyRoot는 댓글번호임 depth가 0인거
			var replyRoot = $(this).next().val();
 			
 			$(this).parent().parent().next().find("input[name=reply_root]").val(replyRoot);
 			
 			
 			//작성란 보여주기
 			$(this).parent().parent().next().show();
 			
 		});
 
 		
 		
 		
 		
 		
 	});
 
 </script>
 
 
 <div class="outbox" style="width:800px">
 	<div class="row">
 	<%if(isWriter || isAdmin) { %>
 		<button class="review-edit-btn input input-inline">수정</button>
 		<button class="review-delete-btn input input-inline">삭제</button>
 	<%} %>
 		<button class="review-list-btn input input-inline">목록</button>
 		
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
 			<%
 				String review_content = reviewDto.getReview_content();
 				review_content = review_content.replace("\r\n", "<br>");
 			%>
 			<%=review_content%>
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
 		<div class="row reply">
 			<div class="row" style="font-weight:bold;">
 				<%=replyVO.getMember_nick()%>
 				<%if(reviewDto.getReview_writer_no() == replyVO.getReply_writer_no()) {%>
 				<span style="color:red;">(작성자)</span>
 				<%} %>
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
 				<a href="#" class="reply2-write-btn">답글쓰기</a>
 				<%
 				boolean isReplyWriter = member_no == replyVO.getReply_writer_no();  
 				
 				%>
 				<%if(isReplyWriter){ %>
 				<a href="#" class="reply-edit-btn"> | 수정 |</a>
 				<%} %>
 				<%if(isReplyWriter || isAdmin) { %>
 				<a href="#" class="reply-delete-btn">삭제</a>
 				<input type="hidden" name="reply_no" value="<%=replyVO.getReply_no()%>">
 				<%} %>	
 				<hr>
 			</div>
 		</div>
 		<!-- 대댓글 작성 -->
 		<div class="row reply2-write">
 			<form action="reply2_write.do" method="post">
	 			<div class="row" style="min-height:100px; border: 1px solid black;">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_root" value="<%=replyVO.getReply_no()%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply2-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
	 				</div>
	 				
	 				
	 				<div class="row right">
	 					<input type="hidden" name="p" value="<%=p%>">
	 					<button class="reply2-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply2-regist-btn">
	 				</div>
	 			</div>
 			</form>
 			<hr>
 		</div>
 		
 		<!-- 댓글 수정 -->
 		<div class="row reply-edit">
 			<form action="reply_edit.do" method="post">
 				<div class="row" style="min-height:100px; border: 1px solid black;">
	 				 <input type="hidden" name="review_no" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_no" value="<%=replyVO.getReply_no()%>">
	 				 <input type="hidden" name="p" value=<%=p%>>
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=replyVO.getReply_content()%></textarea>
	 					<input type="hidden" class="reply-original-content" value="<%=replyVO.getReply_content()%>">
	 				</div>
	 				
	 				<div class="row right">
	 					<button class="reply-edit-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply-edit-regist-btn">
	 				</div>
	 			</div>
 			</form>
 		</div>
 		
 		
 		
 		<!-- 대댓글 -->
 		<%} else if(replyVO.getReply_depth() == 1) { %>
 		<div class="row reply2" style="margin-left:70px">
 			<div class="row" style="font-weight:bold;">
 				<span><%=replyVO.getMember_nick()%></span>
 				<%if(reviewDto.getReview_writer_no() == replyVO.getReply_writer_no()) { %>
 				<span style="color:red;">(작성자)</span>
 				<%} %>
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
 				<input type="hidden" name="reply_root" value="<%=replyVO.getReply_root()%>"> <!-- 댓글의 reply_no -->
 				<%
 					boolean isReplyWriter = member_no == replyVO.getReply_writer_no();
 				%>
 				<%if(isReplyWriter) { %>
 				<a href="#" class="reply2-edit-btn"> | 수정 |</a>
 				<%} %>
 				<%if(isReplyWriter || isAdmin) { %>
 				<a href="#">삭제</a>
 				<%} %>
 				<hr>
 			</div>
 		</div>	
 		
 		<!-- 대대댓글 작성 -->
 		<div class="row reply3-write">
 			<form action="reply3_write.do" method="post">
	 			<div class="row" style="min-height:100px; border: 1px solid black;">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_root"> <!-- reply3-write-btn 누르면 여기에 root값 넣어주도록 스크립트 태그에서 구현 -->
	 				 <input type="hidden" name="reply_parent" value="<%=replyVO.getReply_no()%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply3-area" rows="3" style="border:0"></textarea>
	 				</div>
	 				
	 				
	 				
	 				<div class="row right">
	 					<input type="hidden" name="p" value="<%=p%>">
	 					<button class="reply3-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply3-regist-btn">
	 				</div>
	 			</div>
 			</form>
 			<hr>
 		</div>
 		
 		<!-- 대댓글 수정 -->
 		<div class="row reply2-edit">
 			<form action="reply_edit.do" method="post">
 				<div class="row" style="min-height:100px; border: 1px solid black;">
	 				 <input type="hidden" name="review_no" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_no" value="<%=replyVO.getReply_no()%>">
	 				 <input type="hidden" name="p" value=<%=p%>>
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply2-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=replyVO.getReply_content()%></textarea>
	 					<input type="hidden" class="reply2-original-content" value="<%=replyVO.getReply_content()%>">
	 				</div>
	 				
	 				<div class="row right">
	 					<button class="reply2-edit-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply2-edit-regist-btn">
	 				</div>
	 			</div>
 			</form>
 		</div>
 		
 		
 		
 		<!-- 대대댓글 -->
 		<%} else { %>
 		<div class="row" style="margin-left:70px">
 			<%
 				//reply_parent의 닉네임 및 댓글 작성자번호 구하기
 				ReplyVO replyVONick = replyDao.getNick(replyVO.getReply_parent());
 				String parent_nick = replyVONick.getMember_nick();
 				int parent_writer_no = replyVONick.getReply_writer_no();
 			%>
 			<div class="row" style="font-weight:bold;">
 				<%if(reviewDto.getReview_writer_no() == replyVO.getReply_writer_no()) { %>
 				<span><%=replyVO.getMember_nick()%></span>
 				<span style="color:red;">(작성자)</span>
 				<span> -> </span>
 				<span><%=parent_nick%></span>
 				<%}else if(reviewDto.getReview_writer_no() == parent_writer_no) { %>	
 				<span><%=replyVO.getMember_nick()%> -> </span>
 				<span><%=parent_nick%></span>
 				<span style="color:red;">(작성자)</span>
 				<%}else{ %>
 				<span><%=replyVO.getMember_nick()%> -> </span>
 				<span><%=parent_nick%></span>
 				<%} %>
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
 				<input type="hidden" name="reply_member_nick" value=<%=replyVO.getMember_nick()%> >
 				<a href="#" class="reply4-write-btn">답글쓰기</a>
 				<input type="hidden" name="reply_root" value="<%=replyVO.getReply_root()%>"> <!-- 댓글의 reply_no -->
 				<%
 					boolean isReplyWriter = member_no == replyVO.getReply_writer_no();
 				%>
 				<%if(isReplyWriter) { %>
 				<a href="#" class="reply3-edit-btn"> | 수정 |</a>
 				<%} %>
 				<%if(isReplyWriter || isAdmin) { %>
 				<a href="#">삭제</a>
 				<%} %>
 				<hr>
 			</div>
 		</div>
 		<!-- 대대댓글 작성 -->
 		<div class="row reply3-write">
 			<form action="reply3_write.do" method="post">
	 			<div class="row" style="min-height:100px; border: 1px solid black;">
	 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
	 				 <input type="hidden" name="reply_origin" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_root"> <!-- reply3-write-btn 누르면 여기에 root값 넣어주도록 스크립트 태그에서 구현 -->
	 				 <input type="hidden" name="reply_parent" value="<%=replyVO.getReply_no()%>">
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply3-area" rows="3" style="border:0"></textarea>
	 				</div>
	 				
	 				<div class="row right">
	 					<input type="hidden" name="p" value="<%=p%>">
	 					<button class="reply3-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply3-regist-btn">
	 				</div>
	 			</div>
 			</form>
 			<hr>
 		</div>
 		
 		<!-- 대대댓글 수정 -->
 		<div class="row reply3-edit">
 			<form action="reply_edit.do" method="post">
 				<div class="row" style="min-height:100px; border: 1px solid black;">
	 				 <input type="hidden" name="review_no" value="<%=review_no%>">
	 				 <input type="hidden" name="reply_no" value="<%=replyVO.getReply_no()%>">
	 				 <input type="hidden" name="p" value=<%=p%>>
	 				
	 				<div style="margin-left:0.3rem">
	 					<%=memberReplyDto.getMember_nick()%> 
	 				</div>
	 				<div class="row">
	 					<textarea name="reply_content" class="input reply3-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=replyVO.getReply_content()%></textarea>
	 					<input type="hidden" class="reply3-original-content" value="<%=replyVO.getReply_content()%>">
	 				</div>
	 				
	 				<div class="row right">
	 					<button class="reply3-edit-cancel-btn input input-inline">취소</button>
	 					<input type="submit" value="등록" class="input input-inline reply3-edit-regist-btn">
	 				</div>
	 			</div>
 			</form>
 		</div>		
 		<%} %>
 		
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
	 				<textarea name="reply_content" class="input reply-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
	 			</div>
	 			
	 			<div class="row right">
	 				<input type="hidden" name="p" value="<%=p%>">
	 				<input type="submit" value="등록" class="input input-inline reply-regist-btn">
	 			</div>
 			</form>
 		</div>
 		
 		
 		
 	</div>
 	
 	<div>
 	<%if(isWriter || isAdmin) { %>
 		<button class="review-edit-btn input input-inline">수정</button>
 		<button class="review-delete-btn input input-inline">삭제</button>
 	<%} %>
 		<button class="review-list-btn input input-inline">목록</button>
 	</div>	
 	
 </div>
 
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>