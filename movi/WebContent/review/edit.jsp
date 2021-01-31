<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="movi.beans.*" %>    

<jsp:include page="/template/header.jsp"></jsp:include>    


<%
	int review_no = Integer.parseInt(request.getParameter("review_no"));

	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.find(review_no);
	
	//페이지번호
	int p = Integer.parseInt(request.getParameter("p"));
		
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
			
			var title = document.querySelector("input[name=review_title]").value;
			var content = document.querySelector("textarea[name=review_content]").value;
			
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
				location.href = "list.jsp?review_no=<%=review_no%>&p=<%=p%>";
			}
			
			
		});
		
	});

</script>




<div class="outbox">
		<div class="row center">
			<h2>당신이 본 영화를 다른 사람에게 추천해주세요.</h2>
		</div>
		<form action="edit.do" method="post">
			<input type="hidden" name="review_no" value="<%=review_no%>">
			<input type="hidden" name="p" value=<%=p%>>
			<input type="hidden" name="movie_no" class="input" value="<%=reviewDto.getReview_movie_no()%>">
			
			<div class="row">	
				<label>제목</label>
				<input type="text" name="review_title" class="input box" value="<%=reviewDto.getReview_title()%>">
			</div>
			<div class="row">
				<label>내용</label>
				<textarea name="review_content" rows="20" class="input box"><%=reviewDto.getReview_content()%></textarea>
			</div>
			<div class="row center">
				<input type="button" value="취소하기" class="input input-inline cancel-btn">
				<input type="submit" value="수정완료" class="input input-inline edit-btn">	
			</div>
			
		</form>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>