<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>
<%@ page import="java.util.*" %>

<%
	int notice_no = Integer.parseInt(request.getParameter("notice_no"));
	
	ReviewDao reviewDao = new ReviewDao();
	
	NoticeDto noticeDto = reviewDao.noticeFind(notice_no);
	
	//admin_auth_no로 닉네임 찾기
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.select(noticeDto.getNotice_auth_no());
	
	
	//댓글 작성란에 닉네임 불러오기
		int member_no = (int)session.getAttribute("check");
		MemberDto memberReplyDto = memberDao.find(member_no); //댓글창에 현재 로그인한 사용자의 닉네임을 가져오기 위한 DTO
		
		NoticeReplyDao noticeReplyDao = new NoticeReplyDao();
		
		//댓글개수
		int count = noticeReplyDao.getCount(notice_no);
		
		
		//댓글 목록 출력
		List<NoticeReplyVO> replyList = noticeReplyDao.selectReply(notice_no);
	
	
	
	//작성자본인 및 운영자인지 확인작업
	String auth = (String)session.getAttribute("auth");
	boolean isAdmin = auth.equals("관리자");
	
	
	
	//조회수 중복방지(게시글번호 세션에 저장)
	if(!isAdmin && session.getAttribute("admin_no") == null) {
	session.setAttribute("notice_no", notice_no);
	reviewDao.noticePlusRead(notice_no);
		}
%>

 <jsp:include page="/template/header.jsp"></jsp:include>
 
 
<style>
	textarea{
		resize:none;
		background-color:transparent;
		
	}
	
	.reply-list a {
		text-decoration: none;
        color: black;
	}
	
	.f-right{
		float:right;
		margin-left:5px;
	}
	
	.notice-list-btn, .notice-edit-btn, .notice-delete-btn,
	.reply2-cancel-btn, .reply3-cancel-btn, .reply-edit-cancel-btn, .reply2-edit-cancel-btn,
	.reply3-edit-cancel-btn, .reply-regist-btn, input[type=submit] {
		cursor:pointer;
		font-size: 16px;
		padding:0.5rem;
		background-color: #4E6FA6;
		color:white;
		border-radius:4px;
		border:none;
		
	}
	
	.reply-write{
		border: 3px solid lightgray; 
		border-radius:4px;
		
	}
	
	
	
	
</style>



 <script>
 	$(function(){
 		//수정버튼 클릭하면 해당 게시글 수정페이지로 이동
 		$(".notice-edit-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/noticeEdit.jsp?notice_no=<%=notice_no%>";
 		});
 		
 		//삭제버튼 클릭하면 삭제
		$(".notice-delete-btn").click(function(){
			
			var confirm = window.confirm("정말로 삭제하시겠습니까?");
			if(confirm) {
				location.href = "<%=request.getContextPath()%>/review/notice_delete.do?notice_no=<%=notice_no%>";
			}
			
		}); 		
 		
 		//목록버튼 클릭하면 목록으로 이동
 		$(".notice-list-btn").click(function(){
 			
 			location.href = "<%=request.getContextPath()%>/review/list.jsp?p=1";
 			
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
 
 
 		//대댓글, 대대댓글 삭제
 		$(".reply-delete-btn").click(function(e){
 			var confirm = window.confirm("댓글을 삭제하시겠습니까?");
 			if(!confirm) {
 				e.preventDefault();
 			}
 		});
 		
 		//댓글삭제(reply_root를 삭제시키는거라 자식댓글까지 같이 삭제됨)
		$(".reply-root-delete-btn").click(function(e){
 			var confirm = window.confirm("댓글을 삭제하시겠습니까?");
 			if(!confirm) {
 				e.preventDefault();
 			}
 			
 		});
 		
 		
 		
 	});
 
 </script>
 
 <div class="outbox" style="width:900px"> <!-- 헤더 푸터 제외 전체너비 900px -->
 
	 <div class="row" style="margin-bottom:20px">
	 	<%if(isAdmin) { %>
	 		<button class="notice-edit-btn input input-inline">수정</button>
	 		<button class="notice-delete-btn input input-inline">삭제</button>
	 	<%} %>
	 		<button class="notice-list-btn input input-inline">목록</button>
	 </div>
	 <hr>
 
	 <div class="outbox">  <!-- 게시글 내용 및 댓글까지 포함하는 div -->
	 	<div class="row">
	 		<h2>[<%=noticeDto.getNotice_header()%>]<%=noticeDto.getNotice_title()%></h2>
	 	</div>
	 	<hr>
		<div class="row">
			<span class="f-right"><%=noticeDto.getNotice_date()%></span>
			<span class="f-right">조회 <%=noticeDto.getNotice_read()%> |</span> 
			<span class="f-right"><%=memberDto.getMember_nick()%> |</span> 
			 
		</div>
	 		
	 		<br>
	 	<div class="row" style="min-height:350px" >
			<%
				String notice_content = noticeDto.getNotice_content();
				notice_content = notice_content.replace("\r\n", "<br>");
			%>
			<%=notice_content%>
	 	</div>
	 	
	 	<!-- 댓글 목록-->
	 	<div class="row" style="margin-top:70px">
 			<span>댓글 <%=count%></span>
 			<hr>
	 	</div>
	 	
	 	<div class="reply-list">
	 		<%for(NoticeReplyVO noticeReplyVO : replyList) { %>
	 		<!-- 그냥 댓글 -->
	 		<%if(noticeReplyVO.getReply_depth() == 0 ) { %>
	 		<div class="row reply">
	 			<div class="row">
	 			<%if(isAdmin) {%>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%></span><span style="color:red;">(관리자)</span>
	 			<%} else { %>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%></span>
	 			<%} %>
	 			</div>
	 			<div class="row">
	 				<%
	 				String reply_content = noticeReplyVO.getReply_content();
					reply_content = reply_content.replace("\r\n", "<br>");
	 				%>
	 				<%=reply_content%>
	 			</div>
	 			<div class="row">	
	 				<%
		 				//댓글 시간 format 설정
		 				SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		 				String time = f.format(noticeReplyVO.getReply_time());
	 				%>
	 				<%=time%>
	 				<a href="#" class="reply2-write-btn">답글쓰기</a>
	 				<%
	 				boolean isReplyWriter = member_no == noticeReplyVO.getReply_writer_no();  
	 				
	 				%>
	 				<%if(isReplyWriter){ %>
	 				<a href="#" class="reply-edit-btn"> | 수정 |</a>
	 				<%} %>
	 				<%if(isReplyWriter || isAdmin) { %>
	 				<input type="hidden" value="<%=noticeReplyVO.getReply_no()%>">
	 				<a href="notice_reply_root_delete.do?notice_no=<%=notice_no%>&p=1&reply_no=<%=noticeReplyVO.getReply_no()%>" class="reply-root-delete-btn">삭제</a>
	 				<%} %>
	 				<hr>	
	 			</div>
	 		</div>
	 		
	 		
	 		<!-- 대댓글 작성 -->
	 		<div class="row reply2-write">
	 			<form action="notice_reply2_write.do" method="post">
		 			<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
		 				 <input type="hidden" name="reply_origin" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_root" value="<%=noticeReplyVO.getReply_no()%>">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply2-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
		 				</div>
		 				
		 				
		 				<div class="row right">
		 					<input type="hidden" name="p" value="1">
		 					<button class="reply2-cancel-btn input input-inline">취소</button>
		 					<input type="submit" value="등록" class="input input-inline reply2-regist-btn">
		 				</div>
		 			</div>
	 			</form>
	 			<hr>
	 		</div>
	 		
	 		<!-- 댓글 수정 -->
	 		<div class="row reply-edit">
	 			<form action="notice_reply_edit.do" method="post">
	 				<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				 <input type="hidden" name="notice_no" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_no" value="<%=noticeReplyVO.getReply_no()%>">
		 				 <input type="hidden" name="p" value="1">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=noticeReplyVO.getReply_content()%></textarea>
		 					<input type="hidden" class="reply-original-content" value="<%=noticeReplyVO.getReply_content()%>">
		 				</div>
		 				
		 				<div class="row right">
		 					<button class="reply-edit-cancel-btn input input-inline">취소</button>
		 					<input type="submit" value="등록" class="input input-inline reply-edit-regist-btn">
		 				</div>
		 			</div>
	 			</form>
	 		</div>
	 		
	 		<!-- 대댓글 -->
	 		<%} else if(noticeReplyVO.getReply_depth() == 1) { %>
	 		<div class="row reply2" style="margin-left:70px">
	 			<div class="row">
	 			<%if(isAdmin) { %>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%></span><span style="color:red;">(관리자)</span>
	 			<%} else { %>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%></span>
	 			<%} %>
	 			</div>
	 			<div class="row">
	 				<%
	 				String reply_content = noticeReplyVO.getReply_content();
					reply_content = reply_content.replace("\r\n", "<br>");
	 				%>
	 				<%=reply_content%>
	 			</div>
	 			<div class="row">	
	 				<%
		 				//댓글 시간 format 설정
		 				SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		 				String time = f.format(noticeReplyVO.getReply_time());
	 				%>
	 				<%=time%>
	 				<a href="#" class="reply3-write-btn">답글쓰기</a>
	 				<input type="hidden" name="reply_root" value="<%=noticeReplyVO.getReply_root()%>"> <!-- 댓글의 reply_no -->
	 				<%
	 					boolean isReplyWriter = member_no == noticeReplyVO.getReply_writer_no();
	 				%>
	 				<%if(isReplyWriter) { %>
	 				<a href="#" class="reply2-edit-btn"> | 수정 |</a>
	 				<%} %>
	 				<%if(isReplyWriter || isAdmin) { %>
	 				<a href="notice_reply_delete.do?notice_no=<%=notice_no%>&p=1&reply_no=<%=noticeReplyVO.getReply_no()%>" class="reply-delete-btn">삭제</a>
	 				<%} %>
	 				<hr>
	 			</div>
	 		</div>	
	 		
	 		<!-- 대대댓글 작성 -->
	 		<div class="row reply3-write">
	 			<form action="notice_reply3_write.do" method="post">
		 			<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
		 				 <input type="hidden" name="reply_origin" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_root"> <!-- reply3-write-btn 누르면 여기에 root값 넣어주도록 스크립트 태그에서 구현 -->
		 				 <input type="hidden" name="reply_parent" value="<%=noticeReplyVO.getReply_no()%>">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply3-area" rows="3" style="border:0"></textarea>
		 				</div>
		 				
		 				
		 				
		 				<div class="row right">
		 					<input type="hidden" name="p" value="1">
		 					<button class="reply3-cancel-btn input input-inline">취소</button>
		 					<input type="submit" value="등록" class="input input-inline reply3-regist-btn">
		 				</div>
		 			</div>
	 			</form>
	 			<hr>
	 		</div>
	 		
	 		<!-- 대댓글 수정 -->
	 		<div class="row reply2-edit">
	 			<form action="notice_reply_edit.do" method="post">
	 				<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				 <input type="hidden" name="notice_no" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_no" value="<%=noticeReplyVO.getReply_no()%>">
		 				 <input type="hidden" name="p" value="1">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply2-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=noticeReplyVO.getReply_content()%></textarea>
		 					<input type="hidden" class="reply2-original-content" value="<%=noticeReplyVO.getReply_content()%>">
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
	 	 				NoticeReplyVO replyVONick = noticeReplyDao.getNick(noticeReplyVO.getReply_parent());
	 					String parent_nick;
	 					int parent_writer_no;
	 					
	 					if(replyVONick == null) {
	 						parent_nick = "삭제된 댓글";
	 						parent_writer_no = 0;
	 					}
	 					else{
	 	 					parent_nick = replyVONick.getMember_nick();
	 	 					parent_writer_no = replyVONick.getReply_writer_no();
	 					}
	 				
	 					
	 			%>
	 			<div class="row">
	 				<%if(isAdmin) { %>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%></span><span style="color:red;">(관리자)</span><span> -> </span><span style="font-weight:bold;"><%=parent_nick%></span>
	 				<%}else if(isAdmin) { %>	
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%> -> </span><span style="font-weight:bold;"><%=parent_nick%></span><span style="color:red;">(작성자)</span>
	 				<%}else{ %>
	 				<span style="font-weight:bold;"><%=noticeReplyVO.getMember_nick()%> -> </span><span style="font-weight:bold;"><%=parent_nick%></span>
	 				<%} %>
	 			</div>
	 			<div class="row">
	 				<%
	 				String reply_content = noticeReplyVO.getReply_content();
					reply_content = reply_content.replace("\r\n", "<br>");
	 				%>
	 				<%=reply_content%>
	 			</div>
	 			<div class="row">	
	 				<%
		 				//댓글 시간 format 설정
		 				SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd. HH:mm");
		 				String time = f.format(noticeReplyVO.getReply_time());
	 				%>
	 				<%=time%>
	 				<input type="hidden" name="reply_member_nick" value=<%=noticeReplyVO.getMember_nick()%> >
	 				<a href="#" class="reply4-write-btn">답글쓰기</a>
	 				<input type="hidden" name="reply_root" value="<%=noticeReplyVO.getReply_root()%>"> <!-- 댓글의 reply_no -->
	 				<%
	 					boolean isReplyWriter = member_no == noticeReplyVO.getReply_writer_no();
	 				%>
	 				<%if(isReplyWriter) { %>
	 				<a href="#" class="reply3-edit-btn"> | 수정 |</a>
	 				<%} %>
	 				<%if(isReplyWriter || isAdmin) { %>
	 				<a href="notice_reply_delete.do?notice_no=<%=notice_no%>&p=1&reply_no=<%=noticeReplyVO.getReply_no()%>" class="reply-delete-btn">삭제</a>
	 				<%} %>
	 				<hr>
	 			</div>
	 		</div>
	 		<!-- 대대댓글 작성 -->
	 		<div class="row reply3-write">
	 			<form action="notice_reply3_write.do" method="post">
		 			<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
		 				 <input type="hidden" name="reply_origin" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_root"> <!-- reply3-write-btn 누르면 여기에 root값 넣어주도록 스크립트 태그에서 구현 -->
		 				 <input type="hidden" name="reply_parent" value="<%=noticeReplyVO.getReply_no()%>">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply3-area" rows="3" style="border:0"></textarea>
		 				</div>
		 				
		 				<div class="row right">
		 					<input type="hidden" name="p" value="1">
		 					<button class="reply3-cancel-btn input input-inline">취소</button>
		 					<input type="submit" value="등록" class="input input-inline reply3-regist-btn">
		 				</div>
		 			</div>
	 			</form>
	 			<hr>
	 		</div>
	 		
	 		<!-- 대대댓글 수정 -->
	 		<div class="row reply3-edit">
	 			<form action="notice_reply_edit.do" method="post">
	 				<div class="row" style="min-height:100px; border: 1px solid lightgray;">
		 				 <input type="hidden" name="notice_no" value="<%=notice_no%>">
		 				 <input type="hidden" name="reply_no" value="<%=noticeReplyVO.getReply_no()%>">
		 				 <input type="hidden" name="p" value="1">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%> 
		 				</div>
		 				<div class="row">
		 					<textarea name="reply_content" class="input reply3-edit-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"><%=noticeReplyVO.getReply_content()%></textarea>
		 					<input type="hidden" class="reply3-original-content" value="<%=noticeReplyVO.getReply_content()%>">
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
	 		
	 	</div>
	 	
	 		<!-- 댓글 작성 -->
	 		
	 		<div class="row reply-write" style="margin-top:40px;">
	 			<form action="notice_reply_write.do" method="post">
		 			<div class="row" style="min-height:100px">
		 				<input type="hidden" name="reply_writer_no" value="<%=session.getAttribute("check")%>">
		 				 <input type="hidden" name="reply_origin" value="<%=notice_no%>">
		 				
		 				<div style="margin-left:0.3rem">
		 					<%=memberReplyDto.getMember_nick()%>  
		 				</div>
		 				<textarea name="reply_content" class="input reply-area" rows="3" style="border:0" placeholder="댓글을 남겨보세요"></textarea>
		 			</div>
		 			
		 			<div class="row right">
		 				<input type="hidden" name="p" value="1">
		 				<input type="submit" value="등록" class="input input-inline reply-regist-btn">
		 			</div>
	 			</form>
	 		</div>
	 </div>
	 
	 <div class="row" style="margin-top:20px">
	 	<%if(isAdmin) { %>
	 		<button class="notice-edit-btn input input-inline">수정</button>
	 		<button class="notice-delete-btn input input-inline">삭제</button>
	 	<%} %>
	 		<button class="notice-list-btn input input-inline">목록</button>
	 </div>	
		
	</div>
	 
 </div>
 
 
 <jsp:include page="/template/footer.jsp"></jsp:include>