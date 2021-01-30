<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="movi.beans.*"%>   
    
<jsp:include page="/template/header.jsp"></jsp:include>    

<style>
	#regist-btn{
        	cursor:pointer;
        	border-radius:4px;
			font-size: 18px;
			width:100px;
			padding:0.5rem;
			background-color: #4E6FA6;
			color:white;
			border:none;
        }
        textarea{
			resize: none;        
        }
</style>

<script>

$(function(){
	//게시글 등록버튼 이벤트
	$("#regist-btn").click(function(e){
		var notice_title = document.querySelector("input[name=notice_title]").value;
		var notice_content = document.querySelector("textarea[name=notice_content]").value;
		
		
		if(!notice_title) {
			e.preventDefault();
			window.alert("제목을 입력하세요.");
		}
		
		else if(!notice_content) {
			e.preventDefault();
			window.alert("내용을 입력하세요.");
		}
	
});

	
	
});

</script>

<div class="outbox" style="width:1100px;">
<form action="notice_write.do" method="post">
	<div class="outbox write-form">
		<div class="row center">
			<h2>MOVI 게시판 관리자단</h2>
		</div>
		<select class="input" name="notice_header" style="border:1px solid lightgray;">
			<option>공지</option>
			<option>필독</option>
		</select>	
		<div class="row">
			<input type="text" name="notice_title" class="input" placeholder="제목을 입력하세요." style="border:1px solid lightgray;">
		</div>
		<div class="row">
			<textarea name="notice_content" rows="20" class="input" placeholder="내용을 입력하세요." style="border:1px solid lightgray;"></textarea>
		</div>
		<div class="row center">
			<input id="regist-btn" type="submit" value="등록하기" class="input input-inline">	
		</div>
	</div>
</form>
</div>    

<jsp:include page="/template/footer.jsp"></jsp:include>