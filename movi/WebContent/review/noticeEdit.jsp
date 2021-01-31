<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>    

<jsp:include page="/template/header.jsp"></jsp:include>    


<%
    	int notice_no = Integer.parseInt(request.getParameter("notice_no"));

    	ReviewDao reviewDao = new ReviewDao();
    	NoticeDto noticeDto = reviewDao.noticeFind(notice_no);
    %>

<style>
	textarea{
		resize:none;
	}
	
	.box{
		border:1px solid lightgray;
	}
	.edit-btn, .cancel-btn{
		font-size: 16px;
		padding:0.5rem;
		background-color:#4E6FA6;
		color:white;
		border-radius:4px;
		border:none;
		cursor:pointer;
	}
	
</style>

<script>
	$(function(){
		//수정완료 버튼 클릭시 값 여부 체크
		$(".edit-btn").click(function(e){
			
			var title = document.querySelector("input[name=notice_title]").value;
			var content = document.querySelector("textarea[name=notice_content]").value;
			
			if(!title) {
				e.preventDefault();
				alert("제목을 입력하세요");
			}
			else if(!content) {
				e.preventDefault();
				alert("내용을 입력하세요");
			}
			
		});
		
		//취소하기 버튼 클릭시 해당 게시글이 있던 목록 페이지로 이동
		$(".cancel-btn").click(function(){
			var confirm = window.confirm("게시글 수정을 취소하시겠습니까?");
			
			if(confirm) {
				location.href = "list.jsp?p=1";
			}
			
			
		});
		
	});

</script>




<div class="outbox">
		<div class="row center">
			<h2>MOVI 게시판 관리자단</h2>
		</div>
		<form action="notice_edit.do" method="post">
			<input type="hidden" name="notice_no" value="<%=notice_no%>">
			
			<select class="input" name="notice_header" style="border:1px solid lightgray;">
				<option <%if(noticeDto.getNotice_header().equals("공지")) { %> selected <%} %>>공지</option>
				<option <%if(noticeDto.getNotice_header().equals("필독")) { %> selected <%} %>>필독</option> 
			</select>	
			<div class="row">	
				<label>제목</label>
				<input type="text" name="notice_title" class="input box" value="<%=noticeDto.getNotice_title()%>">
			</div>
			<div class="row">
				<label>내용</label>
				<textarea name="notice_content" rows="20" class="input box"><%=noticeDto.getNotice_content()%></textarea>
			</div>
			<div class="row center">
				<input type="button" value="취소하기" class="input input-inline cancel-btn">
				<input type="submit" value="수정완료" class="input input-inline edit-btn">	
			</div>
			
		</form>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>