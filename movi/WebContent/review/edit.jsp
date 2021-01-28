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
				<input type="text" name="review_title" class="input" value="<%=reviewDto.getReview_title()%>">
			</div>
			<div class="row">
				<label>내용</label>
				<textarea name="review_content" rows="20" class="input" ><%=reviewDto.getReview_content()%></textarea>
			</div>
			<div class="row center">
				<input type="submit" value="수정완료" class="input input-inline" style="width:70px;">	
			</div>
		</form>
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>