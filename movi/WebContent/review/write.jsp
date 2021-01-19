<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>


	<div class="outbox">
		<div class="row center">
			<h2>당신이 본 영화를 다른 사람에게 추천해주세요.</h2>
		</div>
		<form action="write.do" method="post">
			<div class="row">
				<label>영화명</label>
				<input type="text" name="movie_name" class="input" placeholder="영화명을 입력해주세요.">
			</div>
			<div class="row">
				<label>제목</label>
				<input type="text" name="review_title" class="input" placeholder="제목을 입력해주세요.">
			</div>
			<div class="row">
				<label>내용</label>
				<textarea name="review_content" rows="20" class="input" placeholder="내용을 입력하세요."></textarea>
			</div>
			<div class="row center">
				<input type="button" value="취소" class="input input-inline">
				<input type="submit" value="등록" class="input input-inline">	
			</div>
		</form>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>